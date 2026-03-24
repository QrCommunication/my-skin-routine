import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Generates unique, visually distinct product images for seeding.
///
/// Each product gets a distinct image based on its brand+name hash,
/// using the product type's color scheme with unique geometric patterns.
class SeedImageGenerator {
  static const int _imageSize = 512;

  // Color palettes per product type: (background, primary, accent, highlight)
  static const Map<String, (int, int, int, int)> _typePalettes = {
    'cleanser': (0xFFF0F9FF, 0xFF4FC3F7, 0xFF0288D1, 0xFFE1F5FE),
    'toner': (0xFFF1F8E9, 0xFFAED581, 0xFF689F38, 0xFFDCEDC8),
    'serum': (0xFFFFF8E1, 0xFFFFD54F, 0xFFF9A825, 0xFFFFECB3),
    'moisturizer': (0xFFE3F2FD, 0xFF90CAF9, 0xFF1565C0, 0xFFBBDEFB),
    'sunscreen': (0xFFFFF3E0, 0xFFFFB74D, 0xFFEF6C00, 0xFFFFE0B2),
    'oil': (0xFFF9FBE7, 0xFFE6EE9C, 0xFF9E9D24, 0xFFF0F4C3),
    'mask': (0xFFF3E5F5, 0xFFCE93D8, 0xFF7B1FA2, 0xFFE1BEE7),
    'exfoliant': (0xFFFFEBEE, 0xFFEF9A9A, 0xFFC62828, 0xFFFFCDD2),
    'eyeCream': (0xFFE0F7FA, 0xFF80DEEA, 0xFF00838F, 0xFFB2EBF2),
    'lipCare': (0xFFFCE4EC, 0xFFF48FB1, 0xFFAD1457, 0xFFF8BBD0),
    'mist': (0xFFE1F5FE, 0xFFB3E5FC, 0xFF0277BD, 0xFF81D4FA),
    'spotTreatment': (0xFFFBE9E7, 0xFFFFCC80, 0xFFE65100, 0xFFFFAB91),
    'other': (0xFFEFEBE9, 0xFFBCAAA4, 0xFF5D4037, 0xFFD7CCC8),
  };

  // Shape icons per product type (simplified geometric shapes)
  static const Map<String, _ShapeType> _typeShapes = {
    'cleanser': _ShapeType.droplet,
    'toner': _ShapeType.diamond,
    'serum': _ShapeType.flask,
    'moisturizer': _ShapeType.circle,
    'sunscreen': _ShapeType.sun,
    'oil': _ShapeType.droplet,
    'mask': _ShapeType.oval,
    'exfoliant': _ShapeType.hexagon,
    'eyeCream': _ShapeType.almond,
    'lipCare': _ShapeType.heart,
    'mist': _ShapeType.cloud,
    'spotTreatment': _ShapeType.target,
    'other': _ShapeType.square,
  };

  /// Generate unique images for all products.
  ///
  /// Returns a `Map<String, String>` where the key is `{type}_{brand}_{name}`
  /// and the value is the relative path from the documents directory.
  static Future<Map<String, String>> generateAllProductImages(
    List<({String name, String brand, String type})> products,
  ) async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(appDir.path, 'images', 'products', 'seed'));
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    final result = <String, String>{};

    for (final product in products) {
      final fileName = _sanitizeFileName(product.type, product.brand, product.name);
      final relativePath = 'images/products/seed/$fileName.jpg';
      final absolutePath = p.join(appDir.path, relativePath);

      // Skip if already generated
      final file = File(absolutePath);
      if (await file.exists()) {
        result[_productKey(product.type, product.brand, product.name)] = relativePath;
        continue;
      }

      final image = _generateProductImage(
        type: product.type,
        brand: product.brand,
        name: product.name,
      );

      await file.writeAsBytes(img.encodeJpg(image, quality: 90));
      result[_productKey(product.type, product.brand, product.name)] = relativePath;
    }

    return result;
  }

  /// Generate a single product image with unique visual identity.
  static img.Image _generateProductImage({
    required String type,
    required String brand,
    required String name,
  }) {
    final image = img.Image(width: _imageSize, height: _imageSize);
    final palette = _typePalettes[type] ?? _typePalettes['other']!;
    final shape = _typeShapes[type] ?? _ShapeType.circle;
    final seed = _hashString('$brand$name');
    final rng = Random(seed);

    final (bgColor, primaryColor, accentColor, highlightColor) = palette;

    // 1. Fill background with soft gradient
    _drawGradientBackground(image, bgColor, highlightColor, rng);

    // 2. Draw decorative geometric pattern unique to this product
    _drawUniquePattern(image, primaryColor, accentColor, rng);

    // 3. Draw the central product type shape
    _drawCentralShape(image, shape, accentColor, primaryColor, rng);

    // 4. Draw brand initial letter
    _drawBrandInitial(image, brand, accentColor);

    // 5. Add subtle vignette
    _drawVignette(image);

    return image;
  }

  static void _drawGradientBackground(
    img.Image image,
    int bgColorHex,
    int highlightHex,
    Random rng,
  ) {
    final bgR = (bgColorHex >> 16) & 0xFF;
    final bgG = (bgColorHex >> 8) & 0xFF;
    final bgB = bgColorHex & 0xFF;

    final hlR = (highlightHex >> 16) & 0xFF;
    final hlG = (highlightHex >> 8) & 0xFF;
    final hlB = highlightHex & 0xFF;

    // Angle of gradient varies per product
    final angle = rng.nextDouble() * pi * 2;
    final cosA = cos(angle);
    final sinA = sin(angle);

    for (int y = 0; y < _imageSize; y++) {
      for (int x = 0; x < _imageSize; x++) {
        // Directional gradient
        final nx = (x - _imageSize / 2) / _imageSize;
        final ny = (y - _imageSize / 2) / _imageSize;
        final t = ((nx * cosA + ny * sinA) + 0.5).clamp(0.0, 1.0);

        final r = (bgR + (hlR - bgR) * t).round().clamp(0, 255);
        final g = (bgG + (hlG - bgG) * t).round().clamp(0, 255);
        final b = (bgB + (hlB - bgB) * t).round().clamp(0, 255);

        image.setPixelRgb(x, y, r, g, b);
      }
    }
  }

  static void _drawUniquePattern(
    img.Image image,
    int primaryHex,
    int accentHex,
    Random rng,
  ) {
    final pR = (primaryHex >> 16) & 0xFF;
    final pG = (primaryHex >> 8) & 0xFF;
    final pB = primaryHex & 0xFF;

    // Choose pattern type based on RNG
    final patternType = rng.nextInt(5);

    switch (patternType) {
      case 0:
        // Concentric circles
        _drawConcentricCircles(image, pR, pG, pB, rng);
      case 1:
        // Diagonal stripes
        _drawDiagonalStripes(image, pR, pG, pB, rng);
      case 2:
        // Dot grid
        _drawDotGrid(image, pR, pG, pB, rng);
      case 3:
        // Wavy lines
        _drawWavyLines(image, pR, pG, pB, rng);
      case 4:
        // Scattered shapes
        _drawScatteredShapes(image, pR, pG, pB, rng);
    }
  }

  static void _drawConcentricCircles(
    img.Image image,
    int r,
    int g,
    int b,
    Random rng,
  ) {
    final cx = _imageSize ~/ 2 + rng.nextInt(60) - 30;
    final cy = _imageSize ~/ 2 + rng.nextInt(60) - 30;
    final spacing = 30 + rng.nextInt(25);
    final lineWidth = 2;

    for (int radius = spacing; radius < _imageSize; radius += spacing) {
      _drawCircleOutline(image, cx, cy, radius, r, g, b, 30, lineWidth);
    }
  }

  static void _drawDiagonalStripes(
    img.Image image,
    int r,
    int g,
    int b,
    Random rng,
  ) {
    final spacing = 25 + rng.nextInt(30);
    final thickness = 3 + rng.nextInt(4);
    final angle = rng.nextDouble() * pi;

    for (int y = 0; y < _imageSize; y++) {
      for (int x = 0; x < _imageSize; x++) {
        final projected = (x * cos(angle) + y * sin(angle)).round();
        if (projected % spacing < thickness) {
          _blendPixel(image, x, y, r, g, b, 25);
        }
      }
    }
  }

  static void _drawDotGrid(
    img.Image image,
    int r,
    int g,
    int b,
    Random rng,
  ) {
    final spacing = 35 + rng.nextInt(25);
    final dotRadius = 4 + rng.nextInt(5);
    final offsetX = rng.nextInt(spacing);
    final offsetY = rng.nextInt(spacing);

    for (int gy = offsetY; gy < _imageSize; gy += spacing) {
      for (int gx = offsetX; gx < _imageSize; gx += spacing) {
        _drawFilledCircle(image, gx, gy, dotRadius, r, g, b, 35);
      }
    }
  }

  static void _drawWavyLines(
    img.Image image,
    int r,
    int g,
    int b,
    Random rng,
  ) {
    final numLines = 5 + rng.nextInt(6);
    final amplitude = 15.0 + rng.nextDouble() * 25;
    final frequency = 0.01 + rng.nextDouble() * 0.02;
    final phase = rng.nextDouble() * pi * 2;

    for (int line = 0; line < numLines; line++) {
      final baseY = (_imageSize * (line + 1)) ~/ (numLines + 1);
      for (int x = 0; x < _imageSize; x++) {
        final y = baseY + (amplitude * sin(frequency * x + phase + line)).round();
        if (y >= 0 && y < _imageSize) {
          for (int dy = -1; dy <= 1; dy++) {
            final py = y + dy;
            if (py >= 0 && py < _imageSize) {
              _blendPixel(image, x, py, r, g, b, 30);
            }
          }
        }
      }
    }
  }

  static void _drawScatteredShapes(
    img.Image image,
    int r,
    int g,
    int b,
    Random rng,
  ) {
    final count = 8 + rng.nextInt(12);
    for (int i = 0; i < count; i++) {
      final cx = rng.nextInt(_imageSize);
      final cy = rng.nextInt(_imageSize);
      final size = 10 + rng.nextInt(30);
      final opacity = 15 + rng.nextInt(25);

      if (rng.nextBool()) {
        _drawFilledCircle(image, cx, cy, size, r, g, b, opacity);
      } else {
        _drawCircleOutline(image, cx, cy, size, r, g, b, opacity, 2);
      }
    }
  }

  static void _drawCentralShape(
    img.Image image,
    _ShapeType shape,
    int accentHex,
    int primaryHex,
    Random rng,
  ) {
    final cx = _imageSize ~/ 2;
    final cy = _imageSize ~/ 2;
    final size = (_imageSize * 0.28).round();

    final aR = (accentHex >> 16) & 0xFF;
    final aG = (accentHex >> 8) & 0xFF;
    final aB = accentHex & 0xFF;

    final pR = (primaryHex >> 16) & 0xFF;
    final pG = (primaryHex >> 8) & 0xFF;
    final pB = primaryHex & 0xFF;

    switch (shape) {
      case _ShapeType.circle:
        _drawFilledCircle(image, cx, cy, size, pR, pG, pB, 60);
        _drawCircleOutline(image, cx, cy, size, aR, aG, aB, 90, 3);
      case _ShapeType.droplet:
        _drawDroplet(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.diamond:
        _drawDiamond(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.flask:
        _drawFlask(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.sun:
        _drawSun(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.oval:
        _drawOval(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.hexagon:
        _drawHexagon(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.almond:
        _drawAlmond(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.heart:
        _drawHeart(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.cloud:
        _drawCloud(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.target:
        _drawTarget(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
      case _ShapeType.square:
        _drawRoundedSquare(image, cx, cy, size, pR, pG, pB, aR, aG, aB);
    }
  }

  static void _drawBrandInitial(img.Image image, String brand, int accentHex) {
    if (brand.isEmpty) return;

    final initial = brand[0].toUpperCase();
    final aR = (accentHex >> 16) & 0xFF;
    final aG = (accentHex >> 8) & 0xFF;
    final aB = accentHex & 0xFF;

    // Draw the initial as a simple block font at center
    final font = img.arial48;
    final textWidth = initial.length * 28;
    final x = (_imageSize - textWidth) ~/ 2;
    final y = (_imageSize - 48) ~/ 2;

    img.drawString(
      image,
      initial,
      font: font,
      x: x,
      y: y,
      color: img.ColorRgba8(aR, aG, aB, 200),
    );
  }

  static void _drawVignette(img.Image image) {
    final cx = _imageSize / 2;
    final cy = _imageSize / 2;
    final maxDist = sqrt(cx * cx + cy * cy);

    for (int y = 0; y < _imageSize; y++) {
      for (int x = 0; x < _imageSize; x++) {
        final dx = x - cx;
        final dy = y - cy;
        final dist = sqrt(dx * dx + dy * dy);
        final t = (dist / maxDist).clamp(0.0, 1.0);

        // Only darken edges slightly
        if (t > 0.7) {
          final darken = ((t - 0.7) / 0.3 * 30).round();
          final pixel = image.getPixel(x, y);
          image.setPixelRgb(
            x,
            y,
            (pixel.r.toInt() - darken).clamp(0, 255),
            (pixel.g.toInt() - darken).clamp(0, 255),
            (pixel.b.toInt() - darken).clamp(0, 255),
          );
        }
      }
    }
  }

  // === Shape Drawing Helpers ===

  static void _drawFilledCircle(
    img.Image image,
    int cx,
    int cy,
    int radius,
    int r,
    int g,
    int b,
    int opacity,
  ) {
    final r2 = radius * radius;
    for (int dy = -radius; dy <= radius; dy++) {
      for (int dx = -radius; dx <= radius; dx++) {
        if (dx * dx + dy * dy <= r2) {
          final px = cx + dx;
          final py = cy + dy;
          if (px >= 0 && px < _imageSize && py >= 0 && py < _imageSize) {
            _blendPixel(image, px, py, r, g, b, opacity);
          }
        }
      }
    }
  }

  static void _drawCircleOutline(
    img.Image image,
    int cx,
    int cy,
    int radius,
    int r,
    int g,
    int b,
    int opacity,
    int lineWidth,
  ) {
    final outerR2 = radius * radius;
    final innerR2 = (radius - lineWidth) * (radius - lineWidth);
    for (int dy = -radius; dy <= radius; dy++) {
      for (int dx = -radius; dx <= radius; dx++) {
        final d2 = dx * dx + dy * dy;
        if (d2 <= outerR2 && d2 >= innerR2) {
          final px = cx + dx;
          final py = cy + dy;
          if (px >= 0 && px < _imageSize && py >= 0 && py < _imageSize) {
            _blendPixel(image, px, py, r, g, b, opacity);
          }
        }
      }
    }
  }

  static void _drawDroplet(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final ny = (y - cy) / size;
        final nx = (x - cx) / size;
        // Droplet shape: circle at bottom, narrowing to point at top
        final widthAtY = ny < 0 ? (1.0 + ny) * 0.6 : sqrt(1.0 - ny * ny);
        if (nx.abs() < widthAtY) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
      }
    }
    // Outline
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final ny = (y - cy) / size;
        final nx = (x - cx) / size;
        final widthAtY = ny < 0 ? (1.0 + ny) * 0.6 : sqrt(1.0 - ny * ny);
        final dist = (nx.abs() - widthAtY).abs();
        if (dist < 0.04 && nx.abs() < widthAtY + 0.04) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawDiamond(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final dist = (x - cx).abs() + (y - cy).abs();
        if (dist <= size) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
        if ((dist - size).abs() < 3) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawFlask(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    // Flask = narrow neck at top, wide bottom
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final ny = (y - cy).toDouble() / size;
        final nx = (x - cx).toDouble() / size;
        double width;
        if (ny < -0.3) {
          width = 0.25; // Narrow neck
        } else if (ny < 0.0) {
          width = 0.25 + (ny + 0.3) / 0.3 * 0.55; // Widening
        } else {
          width = 0.8; // Wide body
        }
        if (nx.abs() < width) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
        if ((nx.abs() - width).abs() < 0.04) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawSun(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    // Central circle
    final innerR = (size * 0.55).round();
    _drawFilledCircle(image, cx, cy, innerR, pR, pG, pB, 60);
    _drawCircleOutline(image, cx, cy, innerR, aR, aG, aB, 90, 2);

    // Rays
    for (int i = 0; i < 12; i++) {
      final angle = i * pi / 6;
      final startR = innerR + 5;
      final endR = size;
      for (int r = startR; r <= endR; r++) {
        final px = cx + (r * cos(angle)).round();
        final py = cy + (r * sin(angle)).round();
        if (px >= 0 && px < _imageSize && py >= 0 && py < _imageSize) {
          _blendPixel(image, px, py, aR, aG, aB, 70);
          // Thicken rays
          if (px + 1 < _imageSize) _blendPixel(image, px + 1, py, aR, aG, aB, 40);
          if (py + 1 < _imageSize) _blendPixel(image, px, py + 1, aR, aG, aB, 40);
        }
      }
    }
  }

  static void _drawOval(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    final rx = size;
    final ry = (size * 0.7).round();
    for (int y = cy - ry; y <= cy + ry; y++) {
      for (int x = cx - rx; x <= cx + rx; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final dx = (x - cx).toDouble() / rx;
        final dy = (y - cy).toDouble() / ry;
        final d = dx * dx + dy * dy;
        if (d <= 1.0) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
        if ((d - 1.0).abs() < 0.05) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawHexagon(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        // Hexagon distance
        final dx = (x - cx).abs().toDouble();
        final dy = (y - cy).abs().toDouble();
        final hexDist = max(dx * 0.866 + dy * 0.5, dy);
        if (hexDist <= size * 0.85) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
        if ((hexDist - size * 0.85).abs() < 2.5) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawAlmond(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    // Almond / eye shape: intersection of two offset circles
    final r = (size * 1.2).round();
    final offset = (size * 0.5).round();
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final d1 = sqrt(pow(x - (cx - offset), 2) + pow(y - cy, 2));
        final d2 = sqrt(pow(x - (cx + offset), 2) + pow(y - cy, 2));
        if (d1 < r && d2 < r) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
        if ((d1 < r && (d2 - r).abs() < 2.5) || (d2 < r && (d1 - r).abs() < 2.5)) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawHeart(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final nx = (x - cx).toDouble() / size;
        final ny = (y - cy).toDouble() / size;
        // Heart equation: (x^2 + y^2 - 1)^3 - x^2 * y^3 < 0
        final ny2 = -ny + 0.2; // Shift up
        final val = pow(nx * nx + ny2 * ny2 - 0.8, 3) - nx * nx * ny2 * ny2 * ny2;
        if (val < 0) {
          _blendPixel(image, x, y, pR, pG, pB, 55);
        }
        if (val.abs() < 0.06) {
          _blendPixel(image, x, y, aR, aG, aB, 85);
        }
      }
    }
  }

  static void _drawCloud(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    // Cloud = overlapping circles
    final circles = [
      (cx - size ~/ 2, cy, (size * 0.5).round()),
      (cx, cy - size ~/ 4, (size * 0.55).round()),
      (cx + size ~/ 2, cy, (size * 0.5).round()),
      (cx, cy + size ~/ 6, (size * 0.6).round()),
    ];

    for (int y = 0; y < _imageSize; y++) {
      for (int x = 0; x < _imageSize; x++) {
        bool inside = false;
        bool onEdge = false;
        for (final (ccx, ccy, cr) in circles) {
          final d = sqrt(pow(x - ccx, 2) + pow(y - ccy, 2));
          if (d < cr) inside = true;
          if ((d - cr).abs() < 2.5) onEdge = true;
        }
        if (inside) _blendPixel(image, x, y, pR, pG, pB, 50);
        if (onEdge && !inside) _blendPixel(image, x, y, aR, aG, aB, 70);
      }
    }
  }

  static void _drawTarget(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    // Target = concentric circles with alternating colors
    for (int ring = 0; ring < 4; ring++) {
      final outerR = size - ring * (size ~/ 4);
      final innerR = outerR - size ~/ 8;
      if (outerR < 0) break;
      final isAccent = ring.isEven;
      final r = isAccent ? aR : pR;
      final g = isAccent ? aG : pG;
      final b = isAccent ? aB : pB;
      for (int y = cy - outerR; y <= cy + outerR; y++) {
        for (int x = cx - outerR; x <= cx + outerR; x++) {
          if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
          final d2 = (x - cx) * (x - cx) + (y - cy) * (y - cy);
          if (d2 <= outerR * outerR && d2 >= max(0, innerR * innerR)) {
            _blendPixel(image, x, y, r, g, b, 50);
          }
        }
      }
    }
  }

  static void _drawRoundedSquare(
    img.Image image,
    int cx,
    int cy,
    int size,
    int pR,
    int pG,
    int pB,
    int aR,
    int aG,
    int aB,
  ) {
    final cornerR = size ~/ 4;
    for (int y = cy - size; y <= cy + size; y++) {
      for (int x = cx - size; x <= cx + size; x++) {
        if (x < 0 || x >= _imageSize || y < 0 || y >= _imageSize) continue;
        final dx = (x - cx).abs();
        final dy = (y - cy).abs();
        bool inside = false;
        bool onEdge = false;

        if (dx <= size - cornerR && dy <= size) {
          inside = true;
        } else if (dx <= size && dy <= size - cornerR) {
          inside = true;
        } else {
          final cdx = dx - (size - cornerR);
          final cdy = dy - (size - cornerR);
          final cd = sqrt(cdx * cdx + cdy * cdy);
          if (cd <= cornerR) inside = true;
          if ((cd - cornerR).abs() < 2.5) onEdge = true;
        }

        // Edge detection for straight sides
        if (inside && !onEdge) {
          if (dx >= size - 2 || dy >= size - 2) onEdge = true;
        }

        if (inside) _blendPixel(image, x, y, pR, pG, pB, 55);
        if (onEdge) _blendPixel(image, x, y, aR, aG, aB, 85);
      }
    }
  }

  // === Utility Methods ===

  static void _blendPixel(
    img.Image image,
    int x,
    int y,
    int r,
    int g,
    int b,
    int opacity,
  ) {
    final pixel = image.getPixel(x, y);
    final alpha = opacity / 255.0;
    final invAlpha = 1.0 - alpha;
    image.setPixelRgb(
      x,
      y,
      (pixel.r * invAlpha + r * alpha).round().clamp(0, 255),
      (pixel.g * invAlpha + g * alpha).round().clamp(0, 255),
      (pixel.b * invAlpha + b * alpha).round().clamp(0, 255),
    );
  }

  static int _hashString(String input) {
    // DJB2 hash
    int hash = 5381;
    for (int i = 0; i < input.length; i++) {
      hash = ((hash << 5) + hash) + input.codeUnitAt(i);
      hash &= 0x7FFFFFFF; // Keep positive
    }
    return hash;
  }

  static String _sanitizeFileName(String type, String brand, String name) {
    String sanitize(String s) => s
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return '${sanitize(type)}_${sanitize(brand)}_${sanitize(name)}';
  }

  static String _productKey(String type, String brand, String name) {
    return '${type}_${brand}_$name';
  }

  /// Legacy method for backward compatibility — generates one image per type.
  /// Prefer [generateAllProductImages] for per-product images.
  static Future<Map<String, String>> generateAllTypeImages() async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(appDir.path, 'images', 'products'));
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    final result = <String, String>{};

    for (final entry in _typePalettes.entries) {
      final typeName = entry.key;
      final (_, primaryColor, accentColor, _) = entry.value;

      final image = _generateLegacyTypeImage(primaryColor, accentColor);
      final relativePath = 'images/products/seed_$typeName.jpg';
      final absolutePath = p.join(appDir.path, relativePath);

      final file = File(absolutePath);
      await file.writeAsBytes(img.encodeJpg(image, quality: 90));

      result[typeName] = relativePath;
    }

    return result;
  }

  static img.Image _generateLegacyTypeImage(int mainColorHex, int accentColorHex) {
    final size = 512;
    final image = img.Image(width: size, height: size);

    final mainR = (mainColorHex >> 16) & 0xFF;
    final mainG = (mainColorHex >> 8) & 0xFF;
    final mainB = mainColorHex & 0xFF;

    final accentR = (accentColorHex >> 16) & 0xFF;
    final accentG = (accentColorHex >> 8) & 0xFF;
    final accentB = accentColorHex & 0xFF;

    final center = size ~/ 2;
    final maxRadius = size / 2;

    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        final dx = x - center;
        final dy = y - center;
        final distance = sqrt(dx * dx + dy * dy);
        final t = (distance / maxRadius).clamp(0.0, 1.0);

        int r, g, b;
        if (t < 0.6) {
          final tt = t / 0.6;
          r = (accentR + (mainR - accentR) * tt).round();
          g = (accentG + (mainG - accentG) * tt).round();
          b = (accentB + (mainB - accentB) * tt).round();
        } else {
          final tt = (t - 0.6) / 0.4;
          r = (mainR + (240 - mainR) * tt).round();
          g = (mainG + (240 - mainG) * tt).round();
          b = (mainB + (240 - mainB) * tt).round();
        }

        image.setPixelRgb(
          x,
          y,
          r.clamp(0, 255),
          g.clamp(0, 255),
          b.clamp(0, 255),
        );
      }
    }

    final circleRadius = size * 0.3;
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        final dx = x - center;
        final dy = y - center;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < circleRadius && distance > circleRadius - 3) {
          final pixel = image.getPixel(x, y);
          final pr = pixel.r.toInt();
          final pg = pixel.g.toInt();
          final pb = pixel.b.toInt();
          image.setPixelRgb(
            x,
            y,
            ((pr + 255) ~/ 2).clamp(0, 255),
            ((pg + 255) ~/ 2).clamp(0, 255),
            ((pb + 255) ~/ 2).clamp(0, 255),
          );
        }
      }
    }

    return image;
  }
}

enum _ShapeType {
  circle,
  droplet,
  diamond,
  flask,
  sun,
  oval,
  hexagon,
  almond,
  heart,
  cloud,
  target,
  square,
}
