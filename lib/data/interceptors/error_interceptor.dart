import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// interceptor for logging errors
@injectable
class ErrorInterceptor extends Interceptor {

  ErrorInterceptor();


  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger().e('$err \n${err.response}');

    super.onError(err, handler);
  }
}
