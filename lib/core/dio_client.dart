import 'package:dio/dio.dart';
import 'dio_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.escuelajs.co/api/v1/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(AppInterceptor());

  static Dio get instance => _dio;
}