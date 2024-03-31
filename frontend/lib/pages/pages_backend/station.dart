import 'package:flutter/material.dart';
import 'package:lebaladna/backend/shared_variables.dart';

import '../../backend/api/station_api.dart';
import '../../components/shared_components.dart';

Future<List> stationDashboardData(String campaignId) async {
  final response = await getStationProgress({
    "campaignId": campaignId,
    "stationName": box.get("name"),
  });
  if (response[0] == 200) {
    return response;
  }
  return [];
}

Future<void> addMealButton({
  required String meal,
  required String campaignId,
  required int quantity,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  meal = meal.trim().toLowerCase();
  if (meal.isEmpty) {
    snackBar("Ingredient Name field is empty.", context);
  } else if (quantity == 0) {
    snackBar("Count should be more than 0", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await addMeal({
      "campaignId": campaignId,
      "name": box.get("name"),
      "quantity": quantity,
      "meal": meal,
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

Future<void> consumeIngredientButton({
  required String ingredient,
  required String campaignId,
  required int quantity,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  ingredient = ingredient.trim().toLowerCase();
  if (ingredient.isEmpty) {
    snackBar("Ingredient Name field is empty.", context);
  } else if (quantity == 0) {
    snackBar("Count should be more than 0", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await consumeIngredient({
      "campaignId": campaignId,
      "name": box.get("name"),
      "ingredient": ingredient,
      "quantity": quantity,
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

Future<List> backend(String campaignId) async {
  final data = await stationDashboardData(campaignId);
  if (data.isNotEmpty) {
    Map meals = {};
    Map ingredients = {};
    List<Widget> mealsWidget = [];
    List<Widget> ingredientsWidget = [];
    final response = data[1];

    meals = response["meals"];
    ingredients = response["ingredients"];

    meals.forEach((key, value) {
      mealsWidget.add(progressText(value, key, ""));
    });

    ingredients.forEach((key, value) {
      ingredientsWidget.add(progressText(value, key, ""));
    });
    return [mealsWidget, ingredientsWidget, meals, ingredients];
  }

  return [];
}
