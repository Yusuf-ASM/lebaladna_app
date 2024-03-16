import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';

import '../backend/custom_functions.dart';
import '../backend/shared_variables.dart';
import '../components/shared_components.dart';
import 'pages_backend/kitchen.dart';

class KitchenLeaderPage extends StatelessWidget {
  final notifier = VariableNotifier();
  final loading = LoadingStateNotifier();
  final String campaignId;
  KitchenLeaderPage({
    super.key,
    required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    List response = [];
    List ingredientNames = [];
    Map progress = {};
    List<Widget> progressWidgets = [];
    List<Widget> repoWidgets = [];
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    if (stream != null) {
      stream!.listen((event) {
        if (event == "kitchen") {
          //TODO check campaign id :)
          kitchenDashboardData(campaignId).then((value) {
            if (value.isNotEmpty) {
              response = value;
              ingredientNames = response[0];
              progress = response[1];
              repoWidgets.clear();
              progressWidgets.clear();
              for (final key in progress.keys) {
                final ingredient = progress[key].keys.toList();
                for (final element in ingredient) {
                  final widget = Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Wrap(
                      spacing: 32,
                      direction: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            Text(
                              progress[key][element].toString(),
                              style: const TextStyle(fontSize: BigTextSize),
                            ),
                            Text(
                              "$element\n$key",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: SemiTextSize),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  if (element == "plate") {
                    repoWidgets.add(widget);
                  } else {
                    progressWidgets.add(widget);
                  }
                }
              }
              notifier.change();
            }
          });
        }
      });
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(textDashboard), centerTitle: true),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final plateNotifier = VariableNotifier();
            final kitchenNotifier = VariableNotifier();

            String ingredient = "";
            int plate = 0;
            int kitchen = 0;

            return await showDialog(
              context: context,
              useRootNavigator: false,
              builder: (context) {
                final menu =
                    ingredientNames.map((e) => DropdownMenuEntry(value: e, label: e)).toList();

                return AlertDialog(
                  title: const Text("Add Ingredient", style: TextStyle(fontSize: SemiTextSize)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ingredient Name:", style: TextStyle(fontSize: SemiTextSize)),
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
                      const Text("Kitchen:", style: TextStyle(fontSize: SemiTextSize)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (kitchen > 0) {
                                kitchen--;
                                kitchenNotifier.change();
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          ListenableBuilder(
                            listenable: kitchenNotifier,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Text(
                                  kitchen.toString(),
                                  style: const TextStyle(fontSize: SemiTextSize),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              kitchen++;
                              kitchenNotifier.change();
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text("Plate :", style: TextStyle(fontSize: SemiTextSize)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (plate > 0) {
                                plate--;
                                plateNotifier.change();
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          ListenableBuilder(
                              listenable: plateNotifier,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  child: Text(
                                    plate.toString(),
                                    style: const TextStyle(fontSize: SemiTextSize),
                                  ),
                                );
                              }),
                          IconButton(
                            onPressed: () {
                              plate++;
                              plateNotifier.change();
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        addIngredientButton(
                          campaignId: campaignId,
                          context: context,
                          kitchen: kitchen,
                          name: ingredient,
                          plate: plate,
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
              kitchenDashboardData(campaignId).then((value) {
                if (value.isNotEmpty) {
                  response = value;
                }
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

            ingredientNames = response[0];
            progress = response[1];
            writeLog("functionName", progress);
            for (final key in progress.keys) {
              final ingredient = progress[key].keys.toList();
              for (final element in ingredient) {
                final widget = Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16),
                  child: Wrap(
                    spacing: 32,
                    direction: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          Text(
                            progress[key][element].toString(),
                            style: const TextStyle(fontSize: BigTextSize),
                          ),
                          Text(
                            "$element\n$key",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: SemiTextSize),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                if (element == "plate") {
                  repoWidgets.add(widget);
                } else {
                  progressWidgets.add(widget);
                }
              }
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListenableBuilder(
                        listenable: notifier,
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
                                          "Used Ingredients:",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: progressWidgets,
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
                        listenable: notifier,
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
                                          "Repo:",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: repoWidgets,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(height: 16),
                    ConstrainedBox(
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
                                    "Requests:",
                                    style: TextStyle(fontSize: SemiTextSize),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  dividerThickness: 3,
                                  border: const TableBorder(),
                                  columns: const [
                                    DataColumn(label: Text("Time")),
                                    DataColumn(label: Text("Station")),
                                    DataColumn(label: Text("op")),
                                    DataColumn(label: Text("num"))
                                  ],
                                  rows: const [
                                    DataRow(
                                      cells: [
                                        DataCell(Text("11:00")),
                                        DataCell(Text("1")),
                                        DataCell(Text("Meal")),
                                        DataCell(Text("1"))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
