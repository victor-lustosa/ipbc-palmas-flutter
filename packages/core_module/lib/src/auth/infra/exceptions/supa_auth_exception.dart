class SupaAuthException implements Exception {
  final String? message;
  final String statusCode;
  final String? code;

  const SupaAuthException({ required this.statusCode, this.message,  this.code});

  @override
  String toString() =>
      'SupaAuthException(message: $message, statusCode: $statusCode, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupaAuthException &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode ^ code.hashCode;
}
