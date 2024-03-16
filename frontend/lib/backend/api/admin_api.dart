import 'package:dio/dio.dart';

import '../shared_variables.dart';
import '../custom_functions.dart';

Future<List> registerUser(Map<String, dynamic> body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$AdminBackendLink/register/user", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("registerUser", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("registerUser", error);
    }
    return response;
  }
}

Future<List> registerIngredient(Map<String, dynamic> body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$AdminBackendLink/register/ingredient", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("registerIngredient", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("registerIngredient", error);
    }
    return response;
  }
}

Future<List> registerMeal(Map<String, dynamic> body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$AdminBackendLink/register/meal", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("registerMeal", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("registerMeal", error);
    }
    return response;
  }
}

Future<List> registerCampaign(Map<String, dynamic> body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$AdminBackendLink/register/campaign", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("registerMeal", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("registerMeal", error);
    }
    return response;
  }
}

Future<List> getUsers() async {
  Dio dio = Dio();
  try {
    final response = await dio.get("$AdminBackendLink/users");
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("getUsers", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("getUsers", error);
    }
    return response;
  }
}

Future<List> getMeals() async {
  Dio dio = Dio();
  try {
    final response = await dio.get("$AdminBackendLink/meals");
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("getMeals", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("getMeals", error);
    }
    return response;
  }
}

Future<List> getIngredients() async {
  Dio dio = Dio();
  try {
    final response = await dio.get("$AdminBackendLink/ingredients");
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("getIngredients", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("getIngredients", error);
    }
    return response;
  }
}