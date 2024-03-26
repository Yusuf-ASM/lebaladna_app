import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebaladna/backend/custom_functions.dart';
import 'package:lebaladna/pages/kitchen_leader_page.dart';

import '../backend/shared_variables.dart';
import '../backend/text.dart';
import '../components/shared_components.dart';
import 'home_page_.dart';
import 'pages_backend/campaigns.dart';
import 'register/register_campaign.dart';
import 'register/register_ingredient.dart';
import 'register/register_meal.dart';
import 'register/register_user.dart';
import 'station_page.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width * 0.9;
    final loading = LoadingStateNotifier();
    List response = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Campaigns")),
        drawer: drawer(context),
        body: ListenableBuilder(
          listenable: loading,
          builder: (context, child) {
            if (loading.loading) {
              campaignData().then((value) {
                if (value.isNotEmpty) response = value;
                loading.change();
              });
              return loadingIndicator();
            } else if (response.isEmpty) {
              return const Center(
                child: Text("Error :(", style: TextStyle(fontSize: BigTextSize)),
              );
            }
            response = response[1];
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
                        loadingIndicatorDialog(context);
                        connectWebSocket();
                        Navigator.of(context).pop();
                        if (box.get("name") == "admin") {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => HomePage(
                                campaignId: campaignId,
                              ),
                            ),
                          );
                        } else if (role == "kitchen") {
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
    );
  }
}

Drawer drawer(BuildContext context) {
  print(box.get("name"));
  final signInStateNotifier = UserStateNotifier();
  return Drawer(
    child: Column(
      children: [
        const DrawerHeader(
          child: Center(
            child: Text(
              "Lebaladna",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (box.get("name") == "admin")
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
          text: "Logout",
          icon: Icons.logout,
          pressFunction: () => signInStateNotifier.logout(),
        )
      ],
    ),
  );
}
