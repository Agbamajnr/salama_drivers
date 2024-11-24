import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/app/utils/logger.dart';

import '../constants/keys.dart';

@lazySingleton
class HttpRequester {
  HttpRequester({
    required this.dio,
  });
  final Dio dio;

  final String baseUrl = "";

  Future<Response<dynamic>> post({
    required String endpoint,
    required dynamic body,
    String? token,
    Map<String, dynamic>? queryParam,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = await dio.post<dynamic>(
      baseUrl + endpoint,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        headers: headers,
      ),
    );
    return response;
  }

  Future<Response<dynamic>> getRequest({
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParam,
    String? contentType,
    Map<String, dynamic>? headers,
    String? baseUrl,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = dio.get<dynamic>(
      endpoint,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        headers: headers,
      ),
    );
    logger.d(response);
    return response;
  }

  Future<Response<dynamic>> put({
    required String endpoint,
    required dynamic body,
    String? token,
    Map<String, dynamic>? queryParam,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = dio.put<dynamic>(
      baseUrl + endpoint,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        headers: headers,
      ),
    );
    return response;
  }

  Future<Response<dynamic>> patch({
    required String endpoint,
    required dynamic body,
    String? token,
    Map<String, dynamic>? queryParam,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = await dio.patch<dynamic>(
      baseUrl + endpoint,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        headers: headers,
      ),
    );
    return response;
  }

  Future<Response<dynamic>> delete({
    required String endpoint,
    dynamic body,
    String? token,
    Map<String, dynamic>? queryParam,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = await dio.delete<dynamic>(
      baseUrl + endpoint,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
        headers: headers,
      ),
    );
    return response;
  }
}
