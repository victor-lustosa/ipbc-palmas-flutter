import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*padronizar cores de acordo com Design system
* vincular tela ao splash screm
*
*
*
*  */
class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountView();
}

class _CreateAccountView extends State<CreateAccountView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _passwordKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();

  String nameErrorText = 'por favor, insira um nome.';
  String emailErrorText = 'por favor, insira um email válido.';

  bool _isPasswordValid = true;
  bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60, bottom: 32),
                child: Image(
                  image: AssetImage(
                    AppImages.logoLoginImage,
                  ),
                  fit: BoxFit.cover,
                  width: 166,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text('Criar conta',
                    style: AppFonts.defaultFont(
                      color: AppColors.grey10,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              emailField(),
              passwordField(),
              Container(
                width: 343,
                height: 48,
                child: Stack(
                  children: [
                    Container(
                      width: 343,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: Color(0xFF005B40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "CADASTRAR",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "ou",
                style: AppFonts.defaultFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  height: 1.26,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 48,
                  color: Colors.amber,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: const Image(
                            image: NetworkImage(
                                'https://imagepng.org/wp-content/uploads/2019/08/google-icon.png')),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 251,
                        height: 30,
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Fazer cadastro com o Google")]),
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton( style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                minimumSize: const Size.fromHeight(45),
              ), onPressed: () {}, child: Text("Fazer cadastro com o Google")),
              Container(
                width: 343,
                height: 48,
                child: Stack(
                  children: [
                    Container(
                      width: 343,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 272,
                      height: 32,
                      child: Stack(
                        children: [
                          Text(
                            'Fazer cadastro com o Facebook',
                            style: TextStyle(
                              color: Color(0xFF363638),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/32x32"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'ou',
                style: TextStyle(
                  color: Color(0xFF545456),
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 21.40,
                ),
              ),
              Text(
                'Fazer login',
                style: TextStyle(
                  color: Color(0xFF363638),
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  emailField() => field(
        key: _emailKey,
        fieldMargin: EdgeInsets.only(bottom: 24),
        titleMargin: EdgeInsets.only(bottom: 4),
        title: 'Insira seu email',
        isValid: _isEmailValid,
        controller: _emailController,
        hintText: 'Email',
        errorText: emailErrorText,
        validator: (data) {
          return _emailValidation(data);
        },
      );
  passwordField() => field(
        key: _passwordKey,
        titleMargin: EdgeInsets.only(bottom: 4),
        fieldMargin: EdgeInsets.only(bottom: 17),
        title: 'Insira sua senha',
        isValid: _isPasswordValid,
        controller: _passwordController,
        hintText: 'Senha',
        errorText: nameErrorText,
        validator: (data) {
          return _nameValidation(data);
        },
      );

  _passwordBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _isPasswordValid = value;
      });
    });
  }

  _emailBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _isEmailValid = value;
      });
    });
  }

  _emailValidation(String? data) {
    if (data == null || data.isEmpty) {
      _emailBorderValidation(false);
      return null;
    } else {
      if (EmailValidator.validate(_emailController.text)) {
        _emailBorderValidation(true);
        return null;
      } else {
        _emailBorderValidation(false);
        return null;
      }
    }
  }

  _nameValidation(String? data) {
    if (data == null || data.isEmpty) {
      _passwordBorderValidation(false);
      return null;
    } else {
      _passwordBorderValidation(true);
      return null;
    }
  }

  field(
      {required Key key,
      required String title,
      required bool isValid,
      required String hintText,
      required String errorText,
      required FormFieldValidator validator,
      required TextEditingController controller,
      bool? isDense,
      int? maxLines,
      int? maxLength,
      EdgeInsetsGeometry? titleMargin,
      EdgeInsetsGeometry? fieldMargin}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: titleMargin,
            child: Text(
              title,
              style: AppFonts.defaultFont(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.grey9,
              ),
            ),
          ),
          Container(
            margin: fieldMargin,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(
                color: isValid ? AppColors.inputBorderGrey : Colors.red,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              key: key,
              cursorColor: const Color(0xff979797),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              validator: validator,
              maxLines: maxLines,
              maxLength: maxLength,
              keyboardType: TextInputType.text,
              inputFormatters: const <TextInputFormatter>[],
              decoration: InputDecoration(
                counterStyle: AppFonts.defaultFont(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: isValid ? const Color(0xff979797) : Colors.red,
                ),
                isDense: isDense,
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 5,
                ),
                hintStyle: AppFonts.defaultFont(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: isValid ? AppColors.hintInputForm : Colors.red,
                ),
              ),
              style: AppFonts.defaultFont(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isValid ? const Color(0xff979797) : Colors.red,
              ),
            ),
          ),
          Visibility(
            visible: !isValid,
            child: Container(
              margin: const EdgeInsets.only(top: 4, left: 2),
              child: Text(
                errorText,
                style: AppFonts.defaultFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
