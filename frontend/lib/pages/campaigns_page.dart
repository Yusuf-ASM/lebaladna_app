
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebaladna/backend/custom_functions.dart';
import 'package:lebaladna/pages/kitchen_leader_page.dart';

import '../backend/shared_variables.dart';
import '../components/shared_components.dart';
import 'pages_backend/campaigns.dart';
import 'station_page.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    final loading = LoadingStateNotifier();
    List response = [];
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Campaigns")),
      body: SafeArea(
        child: Scaffold(
          body: ListenableBuilder(
            listenable: loading,
            builder: (context, child) {
              if (loading.loading) {
                campaignData().then((value) {
                  if (value.isNotEmpty) response = value[1];
                  loading.change();
                });
                return loadingIndicator();
              } else if (response.isEmpty) {
                return const Center(
                    child: Text("Error :(", style: TextStyle(fontSize: BigTextSize)));
              }
              return ListView.builder(
                itemCount: response.length,
                itemBuilder: (context, index) {
                  final role = response[index][2];
                  final campaignId = response[index][0];
                  final campaignName = response[index][1];
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: GestureDetector(
                        onTap: () async {
                          if (role == "kitchen") {
                            
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => KitchenLeaderPage(
                                  campaignId: campaignId,
                                ),
                              ),
                            );
                          } else if (role == "station") {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => StationPage(
                                  campaignId: campaignId,
                                ),
                              ),
                            );
                          } else if (role == "facilitator") {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => KitchenLeaderPage(
                                  campaignId: campaignId,
                                ),
                              ),
                            );
                          }
                        },
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "$campaignName - $role",
                                      style: const TextStyle(fontSize: SemiTextSize),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
