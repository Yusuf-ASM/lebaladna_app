// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';

import 'shared_variables.dart';
import 'package:dio/dio.dart';

Future<bool> checkInternetConnection() async {
  if (Testing) {
    return true;
  }
  Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 3)));
  try {
    await dio.get('https://example.com');
    return true;
  } on DioException catch (_) {
    return false;
  }
}

void writeLog<T>(String functionName, T text) {
  String log = box.get("log") ?? "";
  log += "[$functionName] - [${DateTime.now()}] - log: $text\n";
  if (Testing) {
    print("\x1B[33m[$functionName] - [${DateTime.now()}] - log: $text\x1B[0m");
  }
  box.put("log", log);
}

void writeError<T>(String functionName, T error) {
  String log = box.get("log") ?? "";
  log += "[$functionName] - [${DateTime.now()}] - error: $error\n";
  if (Testing) {
    print("\x1B[31m[$functionName] - [${DateTime.now()}] - error: $error\x1B[0m");
  }
  box.put("log", log);
}

class DarkThemeNotifier with ChangeNotifier {
  DarkThemeNotifier.darkThemeNotifier();
  static final DarkThemeNotifier _instance = DarkThemeNotifier.darkThemeNotifier();
  factory DarkThemeNotifier() {
    return _instance;
  }

  bool mode = box.get("theme") ?? false;

  void changeTheme() {
    mode = !mode;
    box.put("theme", mode);
    notifyListeners();
  }
}

String int2Time(int time) {
  if (time < 12) {
    return RTL ? "$time ص" : "$time AM";
  } else if (time == 12) {
    return RTL ? "$time م" : "$time PM";
  }
  return RTL ? "${time - 12} م" : "${time - 12} PM";
}

class LoadingStateNotifier with ChangeNotifier {
  LoadingStateNotifier({this.loading = true});
  bool loading = true;
  List<dynamic> response = [];
  void change() {
    loading = !loading;
    notifyListeners();
  }
}

class SignInStateNotifier with ChangeNotifier {
  SignInStateNotifier.signInStateNotifier();
  static final SignInStateNotifier _instance = SignInStateNotifier.signInStateNotifier();
  factory SignInStateNotifier() {
    return _instance;
  }
  bool signed = box.get("signInState") ?? false;
  void signOut() {
    signed = false;
    box.put("signInState", false);
    notifyListeners();
  }

  void signIn() {
    signed = true;
    box.put("signInState", true);
    notifyListeners();
  }
}

class StringListNotifier with ChangeNotifier {
  List<String> list = [];
  void addCourse(String courseName) {
    list.add(courseName);
    notifyListeners();
  }

  void removeCourse(String courseName) {
    list.remove(courseName);
    notifyListeners();
  }

  void clearCart() {
    list.clear();
    notifyListeners();
  }
}

class VariableNotifier<T> with ChangeNotifier {
  void change() {
    notifyListeners();
  }
}

int currentTimeEpoch() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 2).millisecondsSinceEpoch ~/ 1000;
}
