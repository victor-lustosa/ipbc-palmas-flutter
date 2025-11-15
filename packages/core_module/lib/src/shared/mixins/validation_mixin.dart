import 'package:core_module/core_module.dart';

mixin ValidationMixin {

  bool emailValidation(String? data) {
    return !isEmptyData(data) && EmailValidator.validate(data ?? '');
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
  }
}
