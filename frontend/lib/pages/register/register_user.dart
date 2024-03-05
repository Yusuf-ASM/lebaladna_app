import 'package:flutter/material.dart';
import 'package:frontend/backend/text.dart';
import 'package:frontend/components/shared_components.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({super.key});
  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    final password = TextEditingController();
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
                  onSubmitted: () => {},
                  labelText: textPassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: ElevatedButton(
                    onPressed: () {},
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
