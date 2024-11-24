import 'package:equatable/equatable.dart';

class PushNotificationModel extends Equatable {
  PushNotificationModel({
    required this.amount,
    required this.tripId,
    required this.state,
    required this.body,
    required this.title,
  });

  final String? amount;
  String? tripId;
  final String? state;
  final String? body;
  final String? title;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json){
    return PushNotificationModel(
      amount: json["amount"],
      tripId: json["tripId"],
      state: json["state"],
      body: json["body"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "tripId": tripId,
    "state": state,
    "body": body,
    "title": title,
  };

  @override
  List<Object?> get props => [
    amount, tripId, state, body, title, ];
}
