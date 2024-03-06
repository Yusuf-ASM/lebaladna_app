import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:lebaladna/components/shared_components.dart';
import 'package:lebaladna/pages/register/register_meal.dart';
import 'package:lebaladna/pages/register/register_user.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../backend/custom_functions.dart';
import '../backend/shared_variables.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    return SafeArea(
      child: Scaffold(
          drawer: drawer(context),
          appBar: AppBar(title: const Text(textDashboard), centerTitle: true),
          body: Center(
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
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
                    child: const Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
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
                                children: [
                                  SizedBox(
                                    width: maxWidth * 0.6,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Station 1:",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                        Text(
                                          "10 Meals",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: maxWidth * 0.6,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Station 2:",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                        Text(
                                          "20 Meals",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: maxWidth * 0.6,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Station 3:",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                        Text(
                                          "30 Meals",
                                          style: TextStyle(fontSize: SemiTextSize),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
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
                                  DataRow(cells: [
                                    DataCell(Text("11:00")),
                                    DataCell(Text("1")),
                                    DataCell(Text("Meal")),
                                    DataCell(Text("1"))
                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )

          // Container(
          //   width: 400,
          //   height: 400,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //     color: const Color.fromARGB(255, 233, 233, 233),
          //   ),
          // ),
          ),
    );
  }
}

Drawer drawer(BuildContext context) {
  final signInStateNotifier = SignInStateNotifier();
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
                      builder: (context) => const RegisterUserPage(),
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

              // DrawerIconButton(
              //   text: "textRegisterBranch",
              //   icon: Icons.storefront,
              //   pressFunction: () async {
              //     // final controller = TextEditingController();
              //     // final localNotifier = VariableNotifier();
              //     // bool clicked = false;
              //     // bool response = false;
              //     // showDialog(
              //     //   context: context,
              //     //   builder: (BuildContext context) => AlertDialog(
              //     //     title: const Text(
              //     //       textRegisterBranch,
              //     //       textDirection: TD,
              //     //     ),
              //     //     content: Column(
              //     //       mainAxisSize: MainAxisSize.min,
              //     //       children: [
              //     //         FormTextField(
              //     //           controller: controller,
              //     //           onSubmitted: () => addBranchButton(context, controller.text).then(
              //     //             (value) {
              //     //               response = value;
              //     //               localNotifier.change();
              //     //               clicked = true;
              //     //             },
              //     //           ),
              //     //           labelText: textBranch,
              //     //         ),
              //     //         ListenableBuilder(
              //     //           listenable: localNotifier,
              //     //           builder: (context, child) {
              //     //             String result = "";
              //     //             if (!response && clicked) {
              //     //               result = textRegistrationFailed;
              //     //             } else if (clicked) {
              //     //               result = textSuccessfulRegistration;
              //     //             }
              //     //             return Text(
              //     //               result,
              //     //               style: const TextStyle(fontSize: NormalTextSize),
              //     //             );
              //     //           },
              //     //         )
              //     //       ],
              //     //     ),
              //     //     actions: [
              //     //       TextButton(
              //     //         onPressed: () => addBranchButton(context, controller.text).then(
              //     //           (value) {
              //     //             response = value;
              //     //             localNotifier.change();
              //     //             clicked = true;
              //     //           },
              //     //         ),
              //     //         child: const Text(textRegister),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // );
              //   },
              // ),
            ],
          ),
        ),
        DrawerIconButton(
          text: textLogout,
          icon: Icons.logout,
          pressFunction: () => signInStateNotifier.signOut(),
        )
      ],
    ),
  );
}
