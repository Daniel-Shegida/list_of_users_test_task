import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:list_of_users_test_task/di/locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void initDependencies() {
   getIt.init();
}
