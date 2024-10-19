import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetConnection {
  Future<bool> get isConnected;
}

@LazySingleton(as: InternetConnection)
class InternetConnectionImpl implements InternetConnection {
  InternetConnectionImpl(
    this.dataConnectionChecker,
  );

  final InternetConnectionChecker dataConnectionChecker;

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
