import 'package:dio/dio.dart';

import '../shared_variables.dart';
import '../custom_functions.dart';

Future<List> getStationProgress(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$StationBackendLink/get_station_progress", data: body);
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
    final response = await dio.post("$BackendLink/kitchen_progress", data: body);
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


Future<List> addMeal(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$StationBackendLink/add/meal", data: body);
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

Future<List> consumeIngredient(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$StationBackendLink/consume/ingredient", data: body);
    dio.close();
    return [200, response.data];
  } on DioException catch (error) {
    List response = [-1, error.message];
    dio.close();
    if (error.response != null) {
      writeError("consumeIngredient", "${error.response!.statusCode} - ${error.response!.data}");
      response = [error.response!.statusCode, error.response!.data["error"]];
    } else {
      writeError("consumeIngredient", error);
    }
    return response;
  }
}
