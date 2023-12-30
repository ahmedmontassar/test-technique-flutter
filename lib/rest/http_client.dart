import 'package:dio/dio.dart';

class HttpClient {
  late Dio dio;

  HttpClient() {
    dio = Dio();
    dio.options.baseUrl = "https://jsonplaceholder.typicode.com/";
    dio.options.connectTimeout = Duration(milliseconds: 5000);
    dio.options.receiveTimeout = Duration(milliseconds: 3000);
  }

  Future<Response> getTodoList() {
    return dio.get("todos");
  }

  Future<Response> getSingleTodo(int id) {
    return dio.get("todos?id=$id");
  }
}
