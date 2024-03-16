import 'package:flutter/material.dart';

import '../../backend/api/kitchen_api.dart';
import '../../backend/api/admin_api.dart';
import '../../components/shared_components.dart';

Future<List> kitchenDashboardData(String campaignId) async {
  final kitchen = await getKitchenProgress(campaignId);
  final ingredients = await getIngredients();
  if (ingredients[0] == 200 && kitchen[0] == 200) {
    return [ingredients[1][0], kitchen[1]];
  }
  return [];
}

Future<void> addIngredientButton({
  required String name,
  required String campaignId,
  required int kitchen,
  required int plate,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  if (name.isEmpty) {
    snackBar("Ingredient Name field is empty.", context);
  } else if (kitchen == 0) {
    snackBar("kitchen should be more than 0", context);
  } else if (plate == 0) {
    snackBar("plate should be more than 0", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await addIngredient({
      "campaignId": campaignId,
      "quantity": kitchen,
      "plate": plate,
      "ingredient": name,
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
