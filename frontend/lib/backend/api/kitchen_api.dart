import 'package:dio/dio.dart';

import '../shared_variables.dart';
import '../custom_functions.dart';

Future<List> addIngredient(Map body) async {
  Dio dio = Dio();
  try {
    final response = await dio.post("$KitchenBackendLink/add/ingredient", data: body);
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