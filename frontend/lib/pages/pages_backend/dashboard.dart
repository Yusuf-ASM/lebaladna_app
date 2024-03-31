import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../backend/api/admin_api.dart';
import '../../backend/shared_variables.dart';
import '../../components/shared_components.dart';

Future<List> campaignReport(String id) async {
  final List response;
  response = await getCampaign(id);

  if (response[0] == 200) {
    return response;
  }
  return [];
}

Future<List<List<Widget>>> backend(
  BuildContext context,
  double maxWidth,
  String campaignId,
) async {
  List<List<Widget>> output = [];
  List<Widget> stationProgress = [];
  List<Widget> mealProgress = [];
  Map<String, dynamic> materials = {};
  List<Widget> usedMaterial = [];
  List<Widget> repo = [];
  Map response = {};

  final value = await campaignReport(campaignId);

  if (context.mounted && value.isNotEmpty) {
    response = value[1];
    for (final meal in response["meals"].entries) {
      final target = meal.value["target"];
      final cooked = meal.value["cooked"];
      mealProgress.add(mealProgressWidget(meal.key, cooked, target));
    }

    for (final station in response["stationReport"].entries) {
      List<Widget> meals = [];
      List<Widget> ingredients = [];

      for (final meal in station.value["meals"].entries) {
        meals.add(
          Text(
            "${meal.key}: ${meal.value}",
            style: const TextStyle(fontSize: SemiTextSize),
          ),
        );
      }

      for (final ingredient in station.value["ingredients"].entries) {
        if (!materials.containsKey(ingredient.key)) {
          materials[ingredient.key] = 0;
        }
        materials[ingredient.key] = materials[ingredient.key] + ingredient.value;
        ingredients.add(
          Text(
            "${ingredient.key}: ${ingredient.value}",
            style: const TextStyle(fontSize: SemiTextSize),
          ),
        );
      }

      stationProgress.add(
        stationProgressWidget(context, maxWidth, station.key, meals, ingredients),
      );
    }

    for (final ingredient in response["repo"].entries) {
      repo.add(usedMaterialWidget(ingredient.key, ingredient.value));
    }

    for (final material in materials.entries) {
      usedMaterial.add(usedMaterialWidget(material.key, material.value));
    }
    output = [mealProgress, usedMaterial, stationProgress, repo];
  }
  return output;
}

Column usedMaterialWidget(String name, int count) {
  return Column(
    children: [
      Text(
        "$count",
        style: const TextStyle(fontSize: BigTextSize),
      ),
      Text(
        name,
        style: const TextStyle(fontSize: SemiTextSize),
      ),
    ],
  );
}

Column stationProgressWidget(
  BuildContext context,
  double maxWidth,
  String stationName,
  List<Widget> meals,
  List<Widget> ingredients,
) {
  return Column(
    children: [
      Text(
        "$stationName's station: ",
        style: const TextStyle(fontSize: SemiTextSize, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: maxWidth * 0.9,
        child: expansionTile(context, "Meals", meals),
      ),
      SizedBox(
        width: maxWidth * 0.9,
        child: expansionTile(context, "Ingredients", ingredients),
      )
    ],
  );
}

Padding mealProgressWidget(String meal, int cooked, int target) {
  double percent = cooked / target;
  String percentText = "${percent * 100}%";
  if (percent > 1.0) {
    percent = 1.0;
  }
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Row(
          children: [
            Text("$meal: ", style: const TextStyle(fontSize: SemiTextSize)),
            Flexible(
              child: LinearPercentIndicator(
                percent: percent,
                lineHeight: 20,
                barRadius: const Radius.circular(5),
                center: Text(percentText),
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("cooked: $cooked", style: const TextStyle(fontSize: SemiTextSize)),
            Text("target: $target", style: const TextStyle(fontSize: SemiTextSize)),
          ],
        )
      ],
    ),
  );
}
