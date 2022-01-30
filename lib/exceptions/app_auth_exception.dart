class AppAuthException implements Exception {
  final String type;
  final String message;

  AppAuthException({
    this.type,
    this.message,
  });
}
