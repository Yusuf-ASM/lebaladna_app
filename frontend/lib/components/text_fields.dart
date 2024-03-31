import 'package:flutter/material.dart';

import '../backend/shared_variables.dart';

class SignInTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final VoidCallback onSubmitted;
  const SignInTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.name,
      required this.onSubmitted});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: TextField(
        onSubmitted: (value) => onSubmitted(),
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade200, width: 1.1),
            borderRadius: BorderRadius.circular(TextFieldBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 20, 137, 255), width: 1.1),
            borderRadius: BorderRadius.circular(TextFieldBorderRadius),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSubmitted;
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
  });

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

bool obscureText = true;

class PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: TextField(
        onSubmitted: (value) => widget.onSubmitted(),
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: eyeIcon(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade200, width: 1.1),
            borderRadius: BorderRadius.circular(TextFieldBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 20, 137, 255), width: 1.1),
            borderRadius: BorderRadius.circular(TextFieldBorderRadius),
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }

  IconButton eyeIcon() {
    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
      ),
      splashRadius: 20,
      onPressed: () {
        setState(() => obscureText = !obscureText);
      },
    );
  }
}
