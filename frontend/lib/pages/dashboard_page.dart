import 'package:flutter/material.dart';
import 'package:lebaladna/components/shared_components.dart';
import 'package:lebaladna/pages/pages_backend/dashboard.dart';

import '../backend/custom_functions.dart';
import '../backend/shared_variables.dart';
import '../components/drawers.dart';

class DashboardPage extends StatefulWidget {
  final String campaignId;
  const DashboardPage({super.key, required this.campaignId});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final notifier = VariableNotifier();
  final loading = LoadingStateNotifier();
  List<Widget> mealProgress = [];
  List<Widget> usedMaterial = [];
  List<Widget> stationProgress = [];
  List<Widget> repo = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;

    if (stream != null) {
      stream!.listen((event) {
        if (event == "kitchen" || event == "station") {
          backend(context, maxWidth, widget.campaignId).then((value) {
            mealProgress = value[0];
            usedMaterial = value[1];
            stationProgress = value[2];
            repo = value[3];
            notifier.change();
          });
        }
      });
    }

    return SafeArea(
      child: Scaffold(
        drawer: adminDrawer(context),
        appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              backend(context, maxWidth, widget.campaignId).then((value) {
                mealProgress = value[0];
                usedMaterial = value[1];
                stationProgress = value[2];
                repo = value[3];
                loading.change();
              });
              return loadingIndicator();
            } else if (stationProgress.isEmpty) {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Current Progress:",
                                style: TextStyle(
                                  fontSize: SemiTextSize,
                                ),
                              ),
                              ListenableBuilder(
                                listenable: notifier,
                                builder: (context, child) {
                                  return Column(children: mealProgress);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                    "Used Material:",
                                    style: TextStyle(fontSize: SemiTextSize),
                                  ),
                                ],
                              ),
                              ListenableBuilder(
                                listenable: notifier,
                                builder: (context, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Wrap(
                                        spacing: 32,
                                        direction: Axis.horizontal,
                                        children: usedMaterial,
                                      ),
                                    ),
                                  );
                                },
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
                                        children: stationProgress,
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
                                    child: Wrap(
                                      spacing: 32,
                                      direction: Axis.horizontal,
                                      children: repo,
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
