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
    final kitchen = VariableNotifier();
    final width = MediaQuery.of(context).size.width;
    final loading = LoadingStateNotifier();
    Map meals = {};
    Map ingredients = {};
    List<Widget> mealsWidget = [];
    List<Widget> ingredientsWidget = [];
    double maxWidth = width * 0.9;
    Map response = {};
    if (stream != null) {
      stream!.listen((event) {
        print(event);
        if (event == "station") {
          //TODO check campaign id :)
          stationDashboardData(campaignId).then((value) {
            if (value.isNotEmpty) {
              response = value[1];
              meals = response["meals"];
              ingredients = response["ingredients"];
              mealsWidget.clear();
              ingredientsWidget.clear();
              meals.forEach((key, value) {
                mealsWidget.add(progressText(value, key, ""));
              });
              ingredients.forEach((key, value) {
                ingredientsWidget.add(progressText(value, key, ""));
              });
              station.change();
            }
          });
        }
      });
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Station")),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final quantityNotifier = VariableNotifier();

            String ingredient = "";
            int quantity = 0;

            return await showDialog(
              context: context,
              useRootNavigator: false,
              builder: (context) {
                final menu = meals.keys.map((e) => DropdownMenuEntry(value: e, label: e)).toList();
                // ingredientNames.map((e) => DropdownMenuEntry(value: e, label: e)).toList();

                return AlertDialog(
                  title: const Text("Add Meal", style: TextStyle(fontSize: SemiTextSize)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Meal Name:", style: TextStyle(fontSize: SemiTextSize)),
                      const SizedBox(height: 8),
                      Center(
                        child: DropdownMenu(
                          onSelected: (value) {
                            ingredient = value ?? "";
                          },
                          dropdownMenuEntries: menu,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Quantity:", style: TextStyle(fontSize: SemiTextSize)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 0) {
                                quantity--;
                                quantityNotifier.change();
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          ListenableBuilder(
                            listenable: quantityNotifier,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Text(
                                  quantity.toString(),
                                  style: const TextStyle(fontSize: SemiTextSize),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              quantity++;
                              quantityNotifier.change();
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await addMealButton(
                          campaignId: campaignId,
                          context: context,
                          name: ingredient,
                          quantity: quantity,
                        );
                      },
                      child: const Text("Add"),
                    ),
                  ],
                );
              },
            );
          },
        ),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              stationDashboardData(campaignId).then((value) {
                if (value.isNotEmpty) {
                  response = value[1];
                  meals = response["meals"];
                  ingredients = response["ingredients"];
                  mealsWidget.clear();
                  ingredientsWidget.clear();
                  meals.forEach((key, value) {
                    mealsWidget.add(progressText(value, key, ""));
                  });
                  ingredients.forEach((key, value) {
                    ingredientsWidget.add(progressText(value, key, ""));
                  });
                }
                loading.change();
              });
              return loadingIndicator();
            } else if (response.isEmpty) {
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
                        }),
                    const SizedBox(height: 16),
                    ListenableBuilder(
                        listenable: kitchen,
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
                        }),
                    const SizedBox(height: 16)
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
