import 'package:dio/dio.dart';

class HttpClient {
  Dio dio;
  HttpClient() {
    dio = new Dio();
    dio.options.baseUrl = "https://jsonplaceholder.typicode.com/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }

  Future<Response> getTodoList() {
    return dio.get("todos");
  }

  Future<Response> getSingleTodo(int id) {
    return dio.get("todos?id=$id");
  }
}
