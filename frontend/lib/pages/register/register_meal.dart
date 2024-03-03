import 'package:flutter/material.dart';
import 'package:frontend/backend/text.dart';
import 'package:frontend/components/shared_components.dart';

class RegisterMealPage extends StatelessWidget {
  const RegisterMealPage({super.key});
  @override
  Widget build(BuildContext context) {
    final mealName = TextEditingController();
    final password = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.8;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(textCreateMeal), centerTitle: true),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormTextField(
                  controller: mealName,
                  onSubmitted: () => {},
                  labelText: textMealName,
                ),
                FormTextField(
                  controller: password,
                  onSubmitted: () => {},
                  labelText: textIngredients,
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
