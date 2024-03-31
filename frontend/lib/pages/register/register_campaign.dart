import 'package:flutter/material.dart';
import 'package:lebaladna/backend/custom_functions.dart';
import 'package:lebaladna/components/shared_components.dart';

import '../../backend/shared_variables.dart';
import '../../components/switches.dart';
import '../pages_backend/register.dart';

class RegisterCampaignPage extends StatefulWidget {
  const RegisterCampaignPage({super.key});

  @override
  State<RegisterCampaignPage> createState() => _RegisterCampaignPageState();
}

class _RegisterCampaignPageState extends State<RegisterCampaignPage> {
  final loading = LoadingStateNotifier();
  final campaignName = TextEditingController();
  Map<String, dynamic> selectedMeals = {};
  Set selectedStationLeaders = {};
  String selectedKitchenLeader = "";
  List response = [];
  List users = [];
  List meals = [];
  List userIds = [];
  List mealIds = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Create Campaign"), centerTitle: true),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              createCampaignsData().then((value) {
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

            users = response[0][0];
            userIds = response[0][1];
            meals = response[1][0];
            mealIds = response[1][1];

            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormTextField(
                        controller: campaignName,
                        onSubmitted: () => {},
                        labelText: "Campaign Name",
                      ),
                      expansionTile(context, "Meals", [
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
                                itemCount: meals.length,
                                itemBuilder: (context, index) {
                                  final mealName = meals[index];
                                  final target = TextEditingController();
                                  target.text = mealIds[index]["target"].toString();
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          mealName,
                                          style: const TextStyle(fontSize: NormalTextSize),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: TextField(
                                            controller: target,
                                            onChanged: (value) {
                                              final parsedTarget = int.tryParse(value);
                                              if (parsedTarget != null) {
                                                mealIds[index]["target"] = parsedTarget;
                                                selectedMeals[mealName] = mealIds[index];
                                              } else {
                                                mealIds[index]["target"] = 0;
                                                selectedMeals.remove(mealName);
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Target",
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                      expansionTile(context, "Kitchen Leader", [
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
                                itemCount: users.length,
                                itemBuilder: (context, index) => CustomSwitch(
                                  initialValue: selectedKitchenLeader == userIds[index],
                                  switchName: users[index],
                                  callback: (value) {
                                    if (value) {
                                      selectedKitchenLeader = userIds[index];
                                    } else {
                                      selectedKitchenLeader = "";
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      expansionTile(context, "Station Leader", [
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
                                itemCount: users.length,
                                itemBuilder: (context, index) => CustomSwitch(
                                  initialValue: selectedStationLeaders.contains(userIds[index]),
                                  switchName: users[index],
                                  callback: (value) {
                                    if (value) {
                                      selectedStationLeaders.add(userIds[index]);
                                    } else {
                                      selectedStationLeaders.remove(userIds[index]);
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
                            await registerCampaignButton(
                              context: context,
                              name: campaignName.text,
                              kitchen: selectedKitchenLeader,
                              stations: selectedStationLeaders,
                              meals: selectedMeals,
                            );
                          },
                          child: const Text("Register"),
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
