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
