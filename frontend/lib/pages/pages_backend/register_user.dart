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
      print(response);
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
