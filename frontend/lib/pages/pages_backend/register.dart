import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';

import '../../backend/api.dart';
import '../../components/shared_components.dart';

Future<void> registerUserButton({
  required String name,
  required String password,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();

  if (name.isNotEmpty && password.isNotEmpty) {
    loadingIndicatorDialog(context);
    final response = await registerUser({"name": name, "password": password});
    if (context.mounted) {
      Navigator.of(context).pop();
      if (response[0] == 200) {
        snackBar("Done :)", context);
      } else {
        snackBar(response[1], context);
      }
    }
  } else {
    snackBar(textFillUsernamePassword, context);
  }
}

Future<void> registerIngredientButton({
  required String name,
  required String measureUnit,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  measureUnit = measureUnit.trim().toLowerCase();
  if (name.isEmpty) {
    snackBar("Meal Name field is empty.", context);
  } else if (measureUnit.isEmpty) {
    snackBar("Measurement Unit field is empty.", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await registerIngredient({"name": name, "measureUnit": measureUnit});
    if (context.mounted) {
      Navigator.of(context).pop();
      if (response[0] == 200) {
        snackBar("Done :)", context);
      } else {
        snackBar(response[1], context);
      }
    }
  }
}

Future<void> registerMealButton({
  required String name,
  required List ingredients,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  if (name.isEmpty) {
    snackBar("Meal Name field is empty.", context);
  } else if (ingredients.isEmpty) {
    snackBar("Select at least one ingredient.", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await registerMeal({"name": name, "ingredients": ingredients});
    if (context.mounted) {
      Navigator.of(context).pop();
      if (response[0] == 200) {
        snackBar("Done :)", context);
      } else {
        snackBar(response[1], context);
      }
    }
  }
}

Future<void> registerCampaignButton({
  required String name,
  required String kitchen,
  required Set stations,
  required Map meals,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  if (name.isEmpty) {
    snackBar("Campaign Name field is empty.", context);
  } else if (kitchen.isEmpty) {
    snackBar("Select one kitchen leader only.", context);
  } else if (meals.isEmpty) {
    snackBar("Add least one meal.", context);
  } else if (stations.isEmpty) {
    snackBar("Select at least one station leader only.", context);
  } else if (stations.contains(kitchen)) {
    snackBar("Kitchen leader can't be station leader", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await registerCampaign({
      "name": name,
      "stationLeaders": stations.toList(),
      "kitchenLeader": kitchen,
      "meals": meals
    });
    if (context.mounted) {
      Navigator.of(context).pop();
      if (response[0] == 200) {
        snackBar("Done :)", context);
      } else {
        snackBar(response[1], context);
      }
    }
  }
}

Future<List> createMealData() async {
  final response = await getMeals();
  if (response[0] == 200) {
    return response;
  }
  return [];
}

Future<List> createIngredientsData() async {
  final response = await getIngredients();
  if (response[0] == 200) {
    return response;
  }
  return [];
}

Future<List> createCampaignsData() async {
  final meals = await getMeals();
  final users = await getUsers();
  if (users[0] == 200 && meals[0] == 200) {
    return [users[1], meals[1]];
  }
  return [];
}
// 94:52:44:7C:D2:61
// 70:CE:8C:5F:56:50
// C8:94:02:F6:6A:CB
// 14:D4:24:94:4C:D1