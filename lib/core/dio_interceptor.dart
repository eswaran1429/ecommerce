import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("➡️ REQUEST: ${options.method} ${options.path}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("RESPONSE: ${response.statusCode}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("❌ ERROR: ${err.message}");

    if (_shouldRetry(err)) {
      try {
        final response = await _retry(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout;
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final dio = Dio();
    return dio.request(
      requestOptions.path,
      options: Options(method: requestOptions.method),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}