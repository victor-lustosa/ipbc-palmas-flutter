import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ValueNotifier<GenericState<HomeViewState>>
    with ConnectivityMixin, ValidationMixin {
  ScrollController scrollController = ScrollController();

  HomeViewModel({required IUseCases useCases})
    : _useCases = useCases,
      super(InitialState<HomeViewState>());
  final IUseCases _useCases;
  late double vWidth;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final double mdSize = 770;
  final double maxMessageLength = 500;

  final nameKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final messageKey = GlobalKey<FormState>();

  String nameErrorText = 'por favor, insira um nome.';
  String emailErrorText = 'por favor, insira um email válido.';
  String messageErrorText = 'por favor, insira uma mensagem.';

  ValueNotifier<bool> isNameValid = ValueNotifier(true);
  ValueNotifier<bool> isEmailValid = ValueNotifier(true);
  ValueNotifier<bool> isMessageValid = ValueNotifier(true);
  ValueNotifier<bool> isSubmitted = ValueNotifier(false);
  ValueNotifier<int> messageLength = ValueNotifier<int>(0);

  void formValidation(bool validation, ValueNotifier<bool> isValid) {
    Future.delayed(Duration.zero, () async {
      isValid.value = validation;
      value = UpdateFormFieldState();
    });
  }

  void submit(BuildContext context) async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty &&
        isNameValid.value &&
        isEmailValid.value &&
        isMessageValid.value) {
      final response = await isConnected(
        context: context,
        width: 350,
        alignment: Alignment.bottomRight,
      );
      if (response) {
       final response = await _useCases.upsert(
          data: {
            'name': nameController.text,
            'email': emailController.text,
            'message': messageController.text,
          },
          params: {'table': 'form_website'},
        );
       response.fold((_){
         if (context.mounted) {
           showCustomToast(
             width: 350,
             alignment: Alignment.bottomRight,
             context: context,
             title: 'Sucesso!',
             message: 'Evento salvo',
             duration: const Duration(seconds: 1),
           );
         }
         isSubmitted.value = true;
         messageLength.value = 0;
         nameController.clear();
         messageController.clear();
         emailController.clear();
         value = UpdateFormFieldState();
         Future.delayed(const Duration(seconds: 1), () {
           isSubmitted.value = false;
           value = UpdateFormFieldState();
         });
       },(_){
         if (context.mounted) {
           showCustomToast(
             type: .error,
             context: context,
             duration: const Duration(seconds: 1),
             title: 'Erro ao salvar',
             message: 'Verifique a internet e tente novamente.',
           );
         }
       });
      }
    } else {
      formValidation(!isEmptyData(nameController.text), isNameValid);
      formValidation(emailValidation(emailController.text), isEmailValid);
      formValidation(!isEmptyData(messageController.text), isMessageValid);
    }
  }
}

@immutable
abstract class HomeViewState {}
