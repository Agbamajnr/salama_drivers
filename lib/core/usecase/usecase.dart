import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Params> {
  dynamic call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
