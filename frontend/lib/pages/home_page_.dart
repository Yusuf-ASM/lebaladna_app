import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';
import 'package:lebaladna/pages/pages_backend/dashboard.dart';
import 'package:lebaladna/pages/register/register_campaign.dart';
import 'package:lebaladna/pages/register/register_ingredient.dart';
import 'package:lebaladna/pages/register/register_meal.dart';
import 'package:lebaladna/pages/register/register_user.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../backend/custom_functions.dart';
import '../backend/shared_variables.dart';

class HomePage extends StatelessWidget {
  final notifier = VariableNotifier();
  final loading = LoadingStateNotifier();
  final String campaignId;
  HomePage({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    Map response = {};
    Map repo = {};
    Map requests = {};
    List<Widget> stationReport = [];
    Map meals = {};
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;

    if (stream != null) {
      stream!.listen((event) {
        if (event == "kitchen" || event == "station") {
          backend(context, maxWidth, campaignId).then((value) {
            stationReport = value;
            notifier.change();
          });
        }
      });
    }

    return SafeArea(
      child: Scaffold(
        drawer: drawer(context),
        appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              backend(context, maxWidth, campaignId).then((value) {
                stationReport = value;
                loading.change();
              });
              return loadingIndicator();
            } else if (stationReport.isEmpty) {
              return const Center(
                  child: Text(
                "Error :(",
                style: TextStyle(fontSize: BigTextSize),
              ));
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    "Current Progress:",
                                    style: TextStyle(fontSize: SemiTextSize),
                                  ),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 5.0,
                                percent: 0.5,
                                center: const Text("100%"),
                                progressColor: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
                      child: const Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Used Material:",
                                    style: TextStyle(fontSize: SemiTextSize),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Wrap(
                                  spacing: 32,
                                  // alignment: WrapAlignment.spaceEvenly,
                                  direction: Axis.horizontal,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "01",
                                          style: TextStyle(fontSize: BigTextSize),
                                        ),
                                        Text(
                                          "Rice",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "10",
                                          style: TextStyle(fontSize: BigTextSize),
                                        ),
                                        Text(
                                          "Pack",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "02",
                                          style: TextStyle(fontSize: BigTextSize),
                                        ),
                                        Text(
                                          "Meat",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListenableBuilder(
                      listenable: notifier,
                      builder: (context, child) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stations Progress:",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Wrap(
                                        spacing: 8,
                                        alignment: WrapAlignment.spaceEvenly,
                                        direction: Axis.vertical,
                                        children: stationReport,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                                    "Report:",
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

Future<List<Widget>> backend(
  BuildContext context,
  double maxWidth,
  String campaignId,
) async {
  List<Widget> stationProgress = [];
  List meals = [];
  Map response = {};
  final value = await campaignReport(campaignId);

  if (value.isNotEmpty) {
    response = value[1];
    for (final station in response["stationReport"].entries) {
      List<Widget> meals = [];
      List<Widget> ingredients = [];
      for (final meal in station.value["meals"].entries) {
        meals.add(
          Text(
            "${meal.key}: ${meal.value}",
            style: const TextStyle(fontSize: SemiTextSize),
          ),
        );
      }
      for (final ingredient in station.value["ingredients"].entries) {
        ingredients.add(
          Text(
            "${ingredient.key}: ${ingredient.value}",
            style: const TextStyle(fontSize: SemiTextSize),
          ),
        );
      }
      for (final meal in response["meals"].entries) {
        final target = meal.value["target"];
        final cooked = meal.value["cooked"];
        final progress = cooked / target;
        print(progress);
      }

// {repo: {}, requests: [], kitchenReport: {}, meals: {roz-kofta: {target: 10, cooked: 58}}}

      stationProgress.add(
        Column(
          children: [
            Text(
              "${station.key}'s station: ",
              style: const TextStyle(fontSize: SemiTextSize),
            ),
            SizedBox(
              width: maxWidth * 0.9,
              child: expansionTile(context, "Meals", meals),
            ),
            SizedBox(
              width: maxWidth * 0.9,
              child: expansionTile(context, "Ingredients", ingredients),
            )
          ],
        ),
      );
    }
  }

  return stationProgress;
}

Drawer drawer(BuildContext context) {
  final signInStateNotifier = UserStateNotifier();
  return Drawer(
    child: Column(
      children: [
        const DrawerHeader(
          child: Center(
            child: Text(
              textProgramClientName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text(
              textRegistration,
              style: TextStyle(fontSize: SemiTextSize),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              DrawerIconButton(
                text: textRegisterUser,
                icon: Icons.person_add_alt_1,
                pressFunction: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => RegisterUserPage(),
                    ),
                  );
                },
              ),
              DrawerIconButton(
                text: textCreateCampaign,
                icon: Icons.campaign,
                pressFunction: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => RegisterCampaignPage(),
                    ),
                  );
                },
              ),
              DrawerIconButton(
                text: textCreateIngredient,
                icon: Icons.local_grocery_store_rounded,
                pressFunction: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => RegisterIngredientPage(),
                    ),
                  );
                },
              ),
              DrawerIconButton(
                text: textCreateMeal,
                icon: Icons.local_dining,
                pressFunction: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const RegisterMealPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        DrawerIconButton(
          text: textLogout,
          icon: Icons.logout,
          pressFunction: () => signInStateNotifier.logout(),
        )
      ],
    ),
  );
}
