import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TextfieldCodeNumbers extends StatefulWidget {
  const TextfieldCodeNumbers({Key? key}) : super(key: key);

  @override
  State<TextfieldCodeNumbers> createState() => _TextfieldCodeNumbersState();
}

class _TextfieldCodeNumbersState extends State<TextfieldCodeNumbers> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44 * 6 + 10 * 5,
      height: 58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          6,
          (index) => Row(
            children: [
              SizedBox(
                width: 40,
                height: 50,
                child: TextField(
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  focusNode: _focusNodes[index],
                  controller: _controllers[index],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      if (index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    } else if (index < _focusNodes.length - 1) {
                      _focusNodes[index + 1].requestFocus();
                    }
                  },
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.darkGreen,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    // Define a cor do texto aqui
                    // Pode ajustar o tamanho da fonte, a cor, etc.
                    // Usando a AppColors.darkGreen para a cor
                    // e TextStyle para personalizar outros atributos do texto
                    labelStyle: TextStyle(color: AppColors.darkGreen),
                  ),
                  cursorColor: AppColors.darkGreen,
                  cursorWidth: 1.5,
                  style: const TextStyle(color: AppColors.darkGreen),
                ),
              ),
              if (index < 5) const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
