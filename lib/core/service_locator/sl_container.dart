import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/core/service_locator/sl_container.config.dart';


final sl = GetIt.instance;
@injectableInit
void configureDependencies() => sl.init();
