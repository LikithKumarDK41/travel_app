import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ApiConfig {
  static const String baseUrlV1 = "https://api.gose.nichi.in/api/v1";
  static const String baseUrlV2 = "https://api.gose.nichi.in/api/v2";
}

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // FIX: Bypass SSL verification for development to ensure API loads
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Global Error Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          String errorMessage = "An unexpected error occurred.";
          if (error.response != null) {
            errorMessage =
                "Error: ${error.response?.statusCode} - ${error.response?.statusMessage}";
          } else if (error.type == DioExceptionType.connectionTimeout) {
            errorMessage = "Connection timed out. Please check your internet.";
          } else if (error.type == DioExceptionType.connectionError) {
            errorMessage = "No internet connection.";
          }

          // You can also emit this to a global state management or show a toast here if configured
          print("API Error: $errorMessage");
          print("Details: ${error.message}");
          print("Response Data: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  Dio get client => _dio;

  Future<Response> get(
    String endpoint, {
    bool useV2 = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    final String baseUrl = useV2 ? ApiConfig.baseUrlV2 : ApiConfig.baseUrlV1;
    final String url = "$baseUrl$endpoint";
    return await _dio.get(url, queryParameters: queryParameters);
  }
}

final apiService = ApiService();
