sealed class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

final class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message);
}

final class ImportFailure extends Failure {
  ImportFailure(String message) : super(message);
}

final class ExportFailure extends Failure {
  ExportFailure(String message) : super(message);
}

final class PhotoFailure extends Failure {
  PhotoFailure(String message) : super(message);
}

final class ValidationFailure extends Failure {
  ValidationFailure(String message) : super(message);
}
