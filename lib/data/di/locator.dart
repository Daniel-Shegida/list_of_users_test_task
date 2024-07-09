import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:list_of_users_test_task/data/interceptors/error_interceptor.dart';

@module
abstract class DataModule {
  @Named('dio')
  @lazySingleton
  Dio get dioNewDev => Dio(
        BaseOptions(
          baseUrl: 'https://api.github.com/',
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      )
        ..interceptors.add(ErrorInterceptor())
        ..options.headers['Authorization'] =
            'Bearer ${dotenv.env['BEARER_TOKEN']}';
}
