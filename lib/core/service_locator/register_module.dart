import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constants/constants.dart';
import '../constants/keys.dart';


@module
abstract class RegisterModule {
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: dotenv.env[EnvKeys.baseUrl]!,
          connectTimeout: const Duration(seconds: CONNECT_TIMEOUT),
          receiveTimeout: const Duration(seconds: RECEIVE_TIMEOUT),
          contentType: CONTENT_TYPE_DEFAULT,
        ),
      );
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();
}
