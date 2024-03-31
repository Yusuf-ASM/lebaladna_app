import 'package:flutter/material.dart';
import 'package:lebaladna/components/shared_components.dart';
import 'package:lebaladna/pages/pages_backend/register.dart';

class RegisterIngredientPage extends StatelessWidget {
  final name = TextEditingController();
  final measureUnit = TextEditingController();

  RegisterIngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Create Ingredient"), centerTitle: true),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormTextField(
                    controller: name,
                    onSubmitted: () => {},
                    labelText: "Ingredient Name",
                  ),
                  FormTextField(
                    controller: measureUnit,
                    onSubmitted: () async => registerIngredientButton(
                      name: name.text,
                      measureUnit: measureUnit.text,
                      context: context,
                    ),
                    labelText: "Measurement Unit",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: ElevatedButton(
                      onPressed: () async => registerIngredientButton(
                        name: name.text,
                        measureUnit: measureUnit.text,
                        context: context,
                      ),
                      child: const Text("Register"),
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
