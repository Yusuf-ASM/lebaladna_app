import 'package:flutter/material.dart';
import 'package:lebaladna/backend/custom_functions.dart';
import 'package:lebaladna/backend/shared_variables.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';
import 'package:lebaladna/pages/pages_backend/register.dart';

import '../../components/about_us/about_us_switch.dart';

class RegisterMealPage extends StatelessWidget {
  const RegisterMealPage({super.key});
  @override
  Widget build(BuildContext context) {
    final mealName = TextEditingController();
    final loading = LoadingStateNotifier();
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    List response = [];
    List<String> ingredients = [];
    List ingredientsData = [];
    List selectedIngredients = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(textCreateMeal), centerTitle: true),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              createIngredientsData().then((value) {
                response = value;
                loading.change();
              });
              return loadingIndicator();
            } else if (response.isEmpty) {
              return const Center(
                  child: Text(
                "Error :(",
                style: TextStyle(fontSize: BigTextSize),
              ));
            }

            ingredients = List<String>.from(response[1][0]);
            ingredientsData = response[1][1];

            return Center(
              child: SingleChildScrollView(
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
                      expansionTile(context, "Ingredient:", [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: maxWidth * 0.9,
                          height: 300,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: ingredients.length,
                                itemBuilder: (context, index) => CustomSwitch(
                                  initialValue:
                                      selectedIngredients.contains(ingredientsData[index]),
                                  switchName: ingredients[index],
                                  callback: (value) {
                                    if (value) {
                                      selectedIngredients.add(ingredientsData[index]);
                                    } else if (selectedIngredients.isNotEmpty) {
                                      selectedIngredients.remove(ingredientsData[index]);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 32),
                        child: ElevatedButton(
                          onPressed: () async {
                            await registerMealButton(
                              name: mealName.text,
                              ingredients: selectedIngredients,
                              context: context,
                            );
                          },
                          child: const Text(textRegister),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
