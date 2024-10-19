import 'package:json_annotation/json_annotation.dart';
import 'package:salama_users/domain/entities/subscriptions/report.dart';


part 'report_model.g.dart';

@JsonSerializable()
class ReportModel extends Report {
  const ReportModel({
    required super.id,
    required super.message,
    required super.status,
    required super.createdAt,
    required super.updatedAt,

  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
