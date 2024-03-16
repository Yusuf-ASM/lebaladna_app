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
  required String name,
  required String campaignId,
  required int quantity,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  if (name.isEmpty) {
    snackBar("Ingredient Name field is empty.", context);
  } else if (quantity == 0) {
    snackBar("Count should be more than 0", context);
  } else {
    loadingIndicatorDialog(context);
    final response = await addMeal({
      "campaignId": campaignId,
      "name": box.get("name"),
      "quantity": quantity,
      "meal": name,
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
