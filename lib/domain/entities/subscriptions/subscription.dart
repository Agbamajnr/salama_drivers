import 'package:equatable/equatable.dart';

class Subscription extends Equatable {
  final dynamic id;
  final dynamic title;
  final dynamic description;
  final dynamic amount;
  final dynamic tenor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Subscription(
      {required this.id,
      required this.title,
      required this.description,
      required this.amount,
      required this.tenor,
      required this.createdAt,
      required this.updatedAt,
     });

  @override
  List<Object?> get props =>
      [id, title, description, amount, tenor, createdAt, updatedAt,];
}
