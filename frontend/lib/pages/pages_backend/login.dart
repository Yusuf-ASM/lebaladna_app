import 'package:flutter/material.dart';
import 'package:frontend/backend/text.dart';

import '../../backend/custom_functions.dart';
import '../../components/shared_components.dart';

Future<void> loginButton({
  required String name,
  required String password,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  final signInStateNotifier = SignInStateNotifier();

  if (name.isNotEmpty && password.isNotEmpty) {
    loadingIndicatorDialog(context);
    // final response = await signIn(name: name, password: password);
    final response = [];

    if (context.mounted) {
      Navigator.of(context).pop();
      // if (response[0] == 200) {
      // box.put("name", name);
      // box.put("_id", response[1]['_id']);
      // box.put("permissions", response[1]['permissions']);
      // box.put("token", response[1]['token']);
      signInStateNotifier.signIn();
      // } else {
      // snackBar(response[1], context);
      // }
    }
  } else {
    snackBar(textFillUsernamePassword, context);
  }
}
