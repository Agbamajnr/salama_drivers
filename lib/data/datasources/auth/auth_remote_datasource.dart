import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../core/exception/__export.dart';
import '../../../core/local_storage/__export.dart';
import '../../../core/network/__export.dart';
import '../../models/auth/person_model.dart';

abstract class AuthRemoteDatasource {
  Future<PersonModel> login(
      {required String email,
      required String password,
      required String device});
  Future<PersonModel> register({required Map<String, dynamic> data});
  Future<void> verifyEmail({required String otp, required String email});
  Future<String> updateUserDetails(
      {required String firstName,
      required String lastName,
      required String middleName,
      required String firebaseToken,
      required double longitude,
      required double latitude});
  Future<String> dashboard(
      {required bool isActive,
      required String firebaseToken,
      required double longitude,
      required double latitude});
  Future<void> deleteUser();
  Future<String> requestOTP({required String email});
  Future<String> changePassword(
      {required String password,
      required String rePassword,
      required String otp});
}

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final HttpRequester httpRequester;
  final InternetConnection networkInfo;
  final SecureStorage secureStorage;

  AuthRemoteDatasourceImpl({
    required this.httpRequester,
    required this.networkInfo,
    required this.secureStorage,
  });

  @override
  Future<PersonModel> login(
      {required String email,
      required String password,
      required String device}) async {
    if (await networkInfo.isConnected) {
      final body = {
        "identity": email,
        "password": password,
        "userType": "driver",
        "device": device
      };
      final response = await httpRequester.post(
        endpoint: '/taxi/auth/login',
        body: body,
      );
      final data = response.data['data'] as Map<String, dynamic>;
      await secureStorage.saveToken(data['token']);

      final user = PersonModel.fromJson(data['user'] as Map<String, dynamic>);
      await secureStorage.saveUser(user);
      return user;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<PersonModel> register({required Map<String, dynamic> data}) async {
    if (await networkInfo.isConnected) {
      final response = await httpRequester.post(
        endpoint: '/taxi/auth/register-driver',
        body: data,
      );
      Logger().d(response.data);
      final datas = response.data['data'] as Map<String, dynamic>;
      await secureStorage.saveToken(datas['token']);

      final user = PersonModel.fromJson(datas['user'] as Map<String, dynamic>);
      await secureStorage.saveUser(user);
      return user;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> updateUserDetails(
      {required String firstName,
      required String lastName,
      required String middleName,
      required String firebaseToken,
      required double longitude,
      required double latitude}) async {
    final user = await secureStorage.getUser();
    if (await networkInfo.isConnected) {
      final body = {
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "device": "Android",
        "firebaseToken": firebaseToken,
        "longitude": longitude,
        "latitude": latitude
      };
      await httpRequester.put(
        endpoint: '/taxi/users',
        body: body,
        token: (await secureStorage.getToken()),
      );
      final userMap = user!.toJson();
      userMap['firstName'] = firstName;
      userMap['lastName'] = lastName;
      userMap['middleName'] = middleName;
      userMap['firebaseToken'] = firebaseToken;
      await secureStorage.saveUser(PersonModel.fromJson(userMap));
      return 'Account updated successfully';
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> deleteUser() async {
    if (await networkInfo.isConnected) {
      await httpRequester.delete(
        endpoint: '/taxi/users/delete',
        token: (await secureStorage.getToken()),
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> dashboard(
      {required bool isActive,
      required String firebaseToken,
      required double longitude,
      required double latitude}) async {
    if (await networkInfo.isConnected) {
      final body = {
        "isActive": isActive,
        "firebaseToken": firebaseToken,
        "longitude": longitude,
        "latitude": latitude
      };

      final response = await httpRequester.patch(
        endpoint: '/taxi/users/dashboard',
        body: body,
        token: (await secureStorage.getToken()),
      );
      Logger().d(response.data);
      return 'Dashboard Updated Successfully';
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> requestOTP({required String email}) async {
    if (await networkInfo.isConnected) {
      final body = {'email': email, "intent": "sign_otp", "userType": "driver"};
      final response = await httpRequester.post(
        endpoint: '/taxi/auth/otp',
        body: body,
      );
      return (response.data as Map<String, dynamic>)['message'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> verifyEmail({required String otp, required String email}) async {
    if (await networkInfo.isConnected) {
      final body = {
        "email": email,
        "intent": "sign_otp",
        "userType": "driver",
        "otp": otp
      };
      await httpRequester.post(
        endpoint: '/taxi/auth/verify-account',
        body: body,
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> changePassword({
    required String password,
    required String rePassword,
    required String otp,
  }) async {
    final user = await secureStorage.getUser();
    if (await networkInfo.isConnected) {
      final body = {
        "email": user?.email,
        "password": password,
        "rePassword": rePassword,
        "intent": "password_reset",
        "userType": "driver",
        "otp": otp
      };

      final response = await httpRequester.patch(
        endpoint: '/taxi/auth/reset-password',
        body: body,
        token: (await secureStorage.getToken()),
      );
      Logger().d(response.data);
      return 'Password changed successfully';
    } else {
      throw NoInternetException();
    }
  }
}
