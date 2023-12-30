import 'package:dio/dio.dart';

class HttpClient {
  late Dio dio;

  HttpClient() {
    dio = Dio();
    dio.options.baseUrl = "https://jsonplaceholder.typicode.com/";
    dio.options.connectTimeout = Duration(milliseconds: 5000);
    dio.options.receiveTimeout = Duration(milliseconds: 3000);
  }

  Future<Response> getarticleList() {
    return dio.get("posts");
  }

  Future<Response> getSinglePosts(int id) {
    return dio.get("posts?id=$id");
  }
}
