import 'package:dartz/dartz.dart';

import 'package:geolocator/geolocator.dart';
import '../../../core/exception/__export.dart';
import '../../entities/auth/person.dart';

abstract class AuthRepository {
  Future<Either<Failure, Person>> login(
      {required String email,
      required String password,
      required String device});

  Future<Person?> getSavedUser();
  Future<Either<Failure, Person>> register(
      {required Map<String, dynamic> data});
  Future<void> logout();
  Future<Position?> getCurrentPosition();

  Future<Either<Failure, String>> updateUserDetails(
      {required String firstName,
      required String lastName,
      required String middleName,
      required String firebaseToken,
      required double longitude,
      required double latitude});
  Future<Either<Failure, void>> deleteUser();
  Future<Either<Failure, String>> dashboard(
      {required bool isActive,
      required String firebaseToken,
      required double longitude,
      required double latitude});

  Future<Either<Failure, String>> requestOTP({required String email});
    Future<Either<Failure, void>> verifyEmail({
    required String otp,
    required String email,
  });
  Future<Either<Failure, String>> changePassword(
      {required String password,
      required String rePassword,
      required String otp});
}
