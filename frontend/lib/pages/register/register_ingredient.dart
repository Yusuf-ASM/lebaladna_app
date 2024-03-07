import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';

class RegisterIngredientPage extends StatelessWidget {
  final mealName = TextEditingController();
  final password = TextEditingController();

  RegisterIngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(textCreateMeal), centerTitle: true),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormTextField(
                    controller: mealName,
                    onSubmitted: () => {},
                    labelText: textIngredientName,
                  ),
                  FormTextField(
                    controller: password,
                    onSubmitted: () => {},
                    labelText: textIngredientMeasure,
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
      ),
    );
  }
}
