import 'package:flutter/material.dart';

import '../backend/text.dart';
import '../components/auth/button.dart';
import '../components/auth/text_field.dart';
import 'buttons/login.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.45;
    if (width < 500) {
      maxWidth = width * 0.8;
    } else if (width < 1190) {
      maxWidth = width * 0.6;
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TODO Use program client logo
                  // Image.asset(
                  //   "assets/images/logo.png",
                  // ),
                  Column(
                    children: [
                      SignInTextField(
                        hintText: textUsernameHint,
                        controller: username,
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: () {},
                      ),
                      PasswordTextField(
                        hintText: textPasswordHint,
                        controller: password,
                        onSubmitted: () => loginButton(
                          name: username.text,
                          password: password.text,
                          context: context,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          left: maxWidth * 0.2,
                          right: maxWidth * 0.2,
                        ),
                        child: CustomButton(
                          text: textLogin,
                          color: const Color.fromARGB(255, 39, 178, 243),
                          pressFunction: () => loginButton(
                            name: username.text,
                            password: password.text,
                            context: context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
