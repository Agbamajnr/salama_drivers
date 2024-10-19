import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String userId;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic middleName;
  final dynamic email;
  final dynamic phone;
  final dynamic firebaseToken;
  final dynamic isVerified;
  final dynamic longitude;
  final dynamic country;
  final dynamic profileImage;
  final dynamic rideStatus;
  final dynamic isActive;
  final dynamic createdAt;

  const Person(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.phone,
      required this.firebaseToken,
      required this.isVerified,
      required this.longitude,
      required this.country,
      required this.profileImage,
      required this.rideStatus,
      required this.isActive,
      required this.createdAt});

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        middleName,
        email,
        phone,
        firebaseToken,
        isVerified,
        longitude,
        country,
        profileImage,
        rideStatus,
        isActive,
        createdAt
      ];
}
