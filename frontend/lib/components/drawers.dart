import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebaladna/pages/register/register_user.dart';

import '../backend/custom_functions.dart';
import '../backend/shared_variables.dart';
import '../pages/register/register_campaign.dart';
import '../pages/register/register_ingredient.dart';
import '../pages/register/register_meal.dart';
import 'shared_components.dart';

Drawer drawer(BuildContext context) {
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
        DrawerIconButton(
          text: "Logout",
          icon: Icons.logout,
          pressFunction: () => signInStateNotifier.logout(),
        )
      ],
    ),
  );
}

Drawer adminDrawer(BuildContext context) {
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
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text(
              "Registration",
              style: TextStyle(fontSize: SemiTextSize),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              DrawerIconButton(
                text: "Register user",
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
                text: "Create Campaign",
                icon: Icons.campaign,
                pressFunction: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const RegisterCampaignPage(),
                    ),
                  );
                },
              ),
              DrawerIconButton(
                text: "Create Ingredient",
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
                text: "Create Meal",
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
