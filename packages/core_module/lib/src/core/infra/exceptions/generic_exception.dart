abstract class AppException implements Exception {
  final String message;
  final String? code;
  final String? statusCode;

  AppException({required this.message, this.code, this.statusCode});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenericException &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode ^ code.hashCode;
}

class GenericException extends AppException {
  final Object? details;

  GenericException({super.statusCode, required super.message, super.code, this.details});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenericException &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.details == details &&
        other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode ^ code.hashCode ^ details.hashCode;

}


class HiveException extends AppException {

  HiveException({super.statusCode, required super.message, super.code});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenericException &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode ^ code.hashCode;

}
