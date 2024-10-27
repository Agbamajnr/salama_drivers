class UserSubscriptionModel {
  UserSubscriptionModel({
    required this.id,
    required this.userId,
    required this.subscriptionId,
    required this.isActive,
    required this.reference,
    required this.expiresAt,
  });

  final String? id;
  final String? userId;
  final String? subscriptionId;
  final bool? isActive;
  final String? reference;
  final DateTime? expiresAt;

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json){
    return UserSubscriptionModel(
      id: json["id"],
      userId: json["userId"],
      subscriptionId: json["subscriptionId"],
      isActive: json["isActive"],
      reference: json["reference"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "subscriptionId": subscriptionId,
    "isActive": isActive,
    "reference": reference,
    "expiresAt": expiresAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $userId, $subscriptionId, $isActive, $reference, $expiresAt, ";
  }
}
