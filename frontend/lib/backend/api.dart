import 'package:dio/dio.dart';

import 'shared_variables.dart';
import 'custom_functions.dart';

Future<List> login(Map<String, dynamic> body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$BackendLink/login", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("login", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("login", error);
    }
    return response;
  }
}

Future<List> registerUser(Map<String, dynamic> body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$BackendLink/admin/register_user", data: body);
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
    final response = await dio.post("$BackendLink/admin/register_ingredient", data: body);
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
    final response = await dio.post("$BackendLink/admin/register_meal", data: body);
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
    final response = await dio.post("$BackendLink/admin/register_campaign", data: body);
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
    final response = await dio.get("$BackendLink/admin/get_users");
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
    final response = await dio.get("$BackendLink/admin/get_meals");
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

Future<List> getUserCampaigns() async {
  Dio dio = Dio();
  final body = {"_id": box.get("_id"), "activated": true};
  try {
    final response = await dio.post("$BackendLink/get_user_campaign", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("getUserCampaigns", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("getUserCampaigns", error);
    }
    return response;
  }
}

Future<List> getStationProgress(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$BackendLink/get_station_progress", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("getStationProgress", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("getStationProgress", error);
    }
    return response;
  }
}

Future<List> getKitchenProgress(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$BackendLink/get_kitchen_progress", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("getKitchenProgress", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("getKitchenProgress", error);
    }
    return response;
  }
}

Future<List> getIngredients() async {
  Dio dio = Dio();
  try {
    final response = await dio.get("$BackendLink/admin/get_ingredients");
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

Future<List> addIngredient(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$BackendLink/add_ingredient", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("addIngredient", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("addIngredient", error);
    }
    return response;
  }
}

Future<List> addMeal(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$BackendLink/add_Meal", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("addMeal", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("addMeal", error);
    }
    return response;
  }
}
