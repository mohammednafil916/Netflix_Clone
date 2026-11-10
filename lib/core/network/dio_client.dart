import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: "https://api.themoviedb.org/3",
            connectTimeout: Duration(seconds: 15),
            receiveTimeout: Duration(seconds: 15),
            headers: {
              "accept": "application/json",
              "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NTI1ZTMzNWFhNTdmMzU5ZmU3N2E5M2IxMTEwMmE3ZSIsIm5iZiI6MTc5Mzc3MjY1NC4xMjksInN1YiI6IjZhZWFjYzZlMmNhY2ViZjBkYzc4ZTRmNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.p2z6q_jVke8I_FX4JrXhrlSR5om7KGjhLTxbVhchezA",
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(
            request: true,
            requestHeader: false,
            requestBody: false,
            responseHeader: false,
            responseBody: false,
            error: true,
          ),
        );
}
