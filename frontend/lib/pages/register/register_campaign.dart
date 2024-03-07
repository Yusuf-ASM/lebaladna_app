import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';

import '../../backend/shared_variables.dart';
import '../../components/about_us/about_us_switch.dart';

class RegisterCampaignPage extends StatelessWidget {
  final campaignName = TextEditingController();
  final names = ["0", "1", "2", "3", "4"];
  RegisterCampaignPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, int> selectedMeals = {};
    List selectedStationLeaders = [];
    List selectedKitchenLeaders = [];

    final width = MediaQuery.of(context).size.width;

    double maxWidth = width * 0.9;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(textCreateCampaign), centerTitle: true),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormTextField(
                    controller: campaignName,
                    onSubmitted: () => {},
                    labelText: textCampaignName,
                  ),
                  expansionTile(context, textMeals, [
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
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        names[index],
                                        style: const TextStyle(fontSize: NormalTextSize),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextField(
                                          // enabled: ,
                                          onChanged: (value) {
                                            final parsedTarget = int.tryParse(value);
                                            if (parsedTarget != null) {
                                              selectedMeals[index] = parsedTarget;
                                            } else {
                                              selectedMeals.remove(index);
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Target",
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                  ]),
                  expansionTile(context, textKitchenLeader, [
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
                                  selectedKitchenLeaders.add(index);
                                } else {
                                  selectedKitchenLeaders.remove(index);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  expansionTile(context, textStationLeader, [
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
                                  selectedStationLeaders.add(index);
                                } else {
                                  selectedStationLeaders.remove(index);
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
                      onPressed: () {
                        print(selectedKitchenLeaders);
                        print(selectedStationLeaders);
                        print(selectedMeals);
                        print(selectedMeals.values.toList());
                        print(selectedMeals.keys.toList());
                      },
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
