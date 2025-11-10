import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ConnectivityMixin {
  ScrollController scrollController = ScrollController();

  HomeViewModel({required IUseCases useCases}) : _useCases = useCases;
  final IUseCases _useCases;
  late double vWidth;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final double mdSize = 770;

  final nameKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final messageKey = GlobalKey<FormState>();

  String nameErrorText = 'por favor, insira um nome.';
  String emailErrorText = 'por favor, insira um email válido.';
  String messageErrorText = 'por favor, insira uma mensagem.';

  ValueNotifier<bool> isNameValid = ValueNotifier(true);
  ValueNotifier<bool> isEmailValid = ValueNotifier(true);
  ValueNotifier<bool> isMessageValid = ValueNotifier(true);
  ValueNotifier<bool> isAllFieldsValid = ValueNotifier(true);
  ValueNotifier<bool> isSubmitted = ValueNotifier(false);

  formValidation(bool validation, ValueNotifier<bool> isValid) {
    Future.delayed(Duration.zero, () async {
      isValid.value = validation;
    });
    return null;
  }

  bool emailValidation(String? data) {
    return !isEmptyData(data) && EmailValidator.validate(data ?? '');
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
  }

  void submit(BuildContext context) async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty &&
        isNameValid.value &&
        isEmailValid.value &&
        isMessageValid.value &&
        !isSubmitted.value) {
      if (EmailValidator.validate(emailController.text)) {
        isSubmitted.value = true;
        isSubmitted.value = true;
        final response = await isConnected();
        if (response) {
          await _useCases.upsert(
            data: {
              'name': nameController.text,
              'email': emailController.text,
              'message': messageController.text,
            },
            params: {'table': 'form_website'},
          );
          if (context.mounted) {
            isAllFieldsValid.value = false;
            showCustomMessageDialog(
              type: DialogType.success,
              context: context,
              title: 'Sucesso!',
              message: 'Evento salvo',
              duration: const Duration(seconds: 1),
              onDelayedAction: () {
                isSubmitted.value = false;
              },
            );
          }
        }
        nameController.clear();
        messageController.clear();
        emailController.clear();
      } else {
        isEmailValid.value = false;
      }
    }
  }
}
