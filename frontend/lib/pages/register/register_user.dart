import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';

import '../pages_backend/register.dart';

class RegisterUserPage extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();

  RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(textRegisterUser), centerTitle: true),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormTextField(
                  controller: username,
                  onSubmitted: () => {},
                  labelText: textUsername,
                ),
                FormTextField(
                  controller: password,
                  onSubmitted: () => registerUserButton(
                    context: context,
                    name: username.text,
                    password: password.text,
                  ),
                  labelText: textPassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: ElevatedButton(
                    onPressed: () => registerUserButton(
                      context: context,
                      name: username.text,
                      password: password.text,
                    ),
                    child: const Text(textRegister),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
