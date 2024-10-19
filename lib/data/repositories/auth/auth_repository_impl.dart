import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import '../../../core/exception/__export.dart';
import '../../../core/local_storage/__export.dart';
import '../../../core/location/__export.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/auth/auth_remote_datasource.dart';
import '../../models/auth/person_model.dart';


@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SecureStorage secureStorage;
  final AuthRemoteDatasource remoteDatasource;
   final DeviceLocation deviceLocation;


  AuthRepositoryImpl({
    required this.secureStorage,
    required this.remoteDatasource,
    required this.deviceLocation
   
  });
  @override
  Future<Either<Failure, PersonModel>> login({
    required String email,
    required String password,
    required String device,
  }) async {
    try {
      final response =
          await remoteDatasource.login(email: email, password: password, device: device);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<PersonModel?> getSavedUser() {
    return secureStorage.getUser();
  }
  @override
  Future<Either<Failure, PersonModel>> register(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await remoteDatasource.register(data: data);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }
  @override
  Future<void> logout() => secureStorage.clearUser();

    @override
  Future<Position?> getCurrentPosition() async {
    try {
      final position = await deviceLocation.getCurrentPosition();
      return position;
    } catch (e) {
      Logger().d(e);
      return null;
    }
  }

    @override
  Future<Either<Failure, String>> updateUserDetails({
    required String firstName,
      required String lastName,
      required String middleName,
      required String firebaseToken,
      required double longitude,
      required double latitude
  }) async {
    try {
      final response =
          await remoteDatasource.updateUserDetails(firstName: firstName, lastName: lastName, middleName: middleName, firebaseToken: firebaseToken, longitude: longitude, latitude: latitude);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      final response = await remoteDatasource.deleteUser();
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }


      @override
  Future<Either<Failure, String>> dashboard({
   
      required bool  isActive,
      required String firebaseToken,
      required double longitude,
      required double latitude
  }) async {
    try {
      final response =
          await remoteDatasource.dashboard(isActive: isActive,firebaseToken: firebaseToken, longitude: longitude, latitude: latitude);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  
  @override
  Future<Either<Failure, String>> requestOTP({required String email}) async {
    try {
      final response = await remoteDatasource.requestOTP(email: email);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }
  @override
  Future<Either<Failure, String>> changePassword({
    required String password,
    required String rePassword,
    required String otp
  }) async {
    try {
      final response = await remoteDatasource.changePassword(
        password: password,
        rePassword: rePassword,
        otp: otp
      );
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

    @override
  Future<Either<Failure, void>> verifyEmail({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await remoteDatasource.verifyEmail(
        otp: otp,
        email: email,
      );
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

}
