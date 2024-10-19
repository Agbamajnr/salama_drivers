import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final dynamic id;
  final dynamic message;
  final dynamic status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Report(
      {required this.id,
      required this.message,
      required this.status,

      required this.createdAt,
      required this.updatedAt,});

  @override
  List<Object?> get props =>
      [id, message, status, createdAt, updatedAt,];
}
