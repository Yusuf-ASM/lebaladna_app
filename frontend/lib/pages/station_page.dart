import 'package:flutter/material.dart';
import 'package:lebaladna/backend/custom_functions.dart';

import '../backend/shared_variables.dart';
import '../components/shared_components.dart';
import 'pages_backend/station.dart';

class StationPage extends StatelessWidget {
  final String campaignId;
  const StationPage({super.key, required this.campaignId});
  @override
  Widget build(BuildContext context) {
    final station = VariableNotifier();
    final width = MediaQuery.of(context).size.width;
    final loading = LoadingStateNotifier();

    Map meals = {};
    Map ingredients = {};
    List<Widget> mealsWidget = [];
    List<Widget> ingredientsWidget = [];
    double maxWidth = width * 0.9;

    if (stream != null) {
      stream!.listen((event) {
        if (event == "station") {
          //TODO check campaign id :)
          backend(campaignId).then((value) {
            if (value.isNotEmpty) {
              mealsWidget = value[0];
              ingredientsWidget = value[1];
              meals = value[2];
              ingredients = value[3];
              station.change();
            }
          });
        }
      });
    }
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Station")),
        floatingActionButton: GestureDetector(
          onLongPress: () async {
            final menu =
                ingredients.keys.map((e) => DropdownMenuEntry(value: e, label: e)).toList();

            return await addDialog(
              context,
              menu,
              "Add Ingredient",
              "Ingredient Name:",
              (selected, quantity) async => await addMealButton(
                campaignId: campaignId,
                context: context,
                meal: selected,
                quantity: quantity,
              ),
            );
          },
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final menu = meals.keys.map((e) => DropdownMenuEntry(value: e, label: e)).toList();

              return await addDialog(
                context,
                menu,
                "Add Meal",
                "Meal Name:",
                (selected, quantity) async => await consumeIngredientButton(
                  campaignId: campaignId,
                  context: context,
                  ingredient: selected,
                  quantity: quantity,
                ),
              );
            },
          ),
        ),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              backend(campaignId).then((value) {
                if (value.isNotEmpty) {
                  mealsWidget = value[0];
                  ingredientsWidget = value[1];
                  meals = value[2];
                  ingredients = value[3];
                  loading.change();
                }
              });

              return loadingIndicator();
            } else if (meals.isEmpty) {
              return const Center(child: Text("Error :(", style: TextStyle(fontSize: BigTextSize)));
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListenableBuilder(
                      listenable: station,
                      builder: (context, child) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Meals:",
                                        style: TextStyle(fontSize: SemiTextSize),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: mealsWidget,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ListenableBuilder(
                      listenable: station,
                      builder: (context, child) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ingredients:",
                                        style: TextStyle(fontSize: SemiTextSize),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: ingredientsWidget,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
