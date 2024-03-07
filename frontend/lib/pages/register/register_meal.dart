import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';

import '../../components/about_us/about_us_switch.dart';

class RegisterMealPage extends StatelessWidget {
  final mealName = TextEditingController();
  final password = TextEditingController();

  RegisterMealPage({super.key});
  final names = ["0", "1", "2", "3", "4"];
  @override
  Widget build(BuildContext context) {
    List selectedIngredients = [];
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
                    labelText: textMealName,
                  ),
                  expansionTile(context, "Ingredients", [
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: maxWidth * 0.8,
                      height: 300,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: names.length,
                            itemBuilder: (context, index) => AboutUsSwitchV2(
                              switchName: names[index],
                              callback: (value) {
                                if (value) {
                                  selectedIngredients.add(index);
                                } else {
                                  selectedIngredients.remove(index);
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
