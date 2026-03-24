import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Maximum dimension for resized photos (maintains aspect ratio).
const int _maxPhotoDimension = 1024;

/// Saves a photo from source path to app documents directory.
///
/// Copies the file from [sourcePath] to the app's documents directory
/// under the specified [subdir], naming it with [identifier].
/// Resizes the image to a maximum of 1024x1024 pixels (maintains aspect ratio).
///
/// Returns the relative path from app documents directory.
/// Example: 'progressPhotos/action_123.jpg'
///
/// Throws [FileSystemException] if file operations fail.
Future<String> savePhoto(
  String sourcePath,
  String subdir,
  String identifier,
) async {
  final appDir = await getApplicationDocumentsDirectory();
  final subdirPath = Directory(p.join(appDir.path, subdir));

  // Create subdirectory if it doesn't exist
  if (!await subdirPath.exists()) {
    await subdirPath.create(recursive: true);
  }

  // Read original image
  final sourceFile = File(sourcePath);
  final imageBytes = await sourceFile.readAsBytes();
  final originalImage = img.decodeImage(imageBytes);

  if (originalImage == null) {
    throw FileSystemException('Failed to decode image', sourcePath);
  }

  // Resize if necessary
  final resized = _resizeImage(originalImage);

  // Determine file extension
  final sourceExt = p.extension(sourcePath);
  final filename = '$identifier$sourceExt';
  final destPath = p.join(subdirPath.path, filename);

  // Save resized image
  final destFile = File(destPath);
  await destFile.writeAsBytes(img.encodeJpg(resized, quality: 85));

  // Return relative path
  return p.join(subdir, filename);
}

/// Deletes a photo at the given relative path.
///
/// [relativePath] should be relative to the app documents directory.
/// Does nothing if the file doesn't exist.
///
/// Throws [FileSystemException] if deletion fails for reasons other than file not existing.
Future<void> deletePhoto(String relativePath) async {
  final appDir = await getApplicationDocumentsDirectory();
  final filePath = p.join(appDir.path, relativePath);
  final file = File(filePath);

  if (await file.exists()) {
    await file.delete();
  }
}

/// Resolves a relative path to an absolute path in the app documents directory.
///
/// [relativePath] should be relative to the app documents directory.
/// Returns the full absolute path.
///
/// Example: 'progressPhotos/action_123.jpg' -> '/data/user/0/com.example.app/documents/progressPhotos/action_123.jpg'
Future<String> getAbsolutePath(String relativePath) async {
  final appDir = await getApplicationDocumentsDirectory();
  return p.join(appDir.path, relativePath);
}

/// Resizes an image to fit within [_maxPhotoDimension] x [_maxPhotoDimension].
///
/// Maintains aspect ratio. If the image is smaller than the max dimension,
/// returns the original image unchanged.
img.Image _resizeImage(img.Image image) {
  final width = image.width;
  final height = image.height;

  // If already smaller than max dimension, return as is
  if (width <= _maxPhotoDimension && height <= _maxPhotoDimension) {
    return image;
  }

  // Calculate scaling factor to maintain aspect ratio
  final scale = (_maxPhotoDimension / (width > height ? width : height)).toInt();

  return img.copyResize(
    image,
    width: width ~/ scale,
    height: height ~/ scale,
  );
}
