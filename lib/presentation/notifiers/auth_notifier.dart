import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../core/alerts/__export.dart';
import '../../core/exception/__export.dart';
import '../../core/local_storage/__export.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/entities/auth/person.dart';
import '../../domain/usecases/auth/change_password.dart';
import '../../domain/usecases/auth/delete_user.dart';
import '../../domain/usecases/auth/get_saved_user.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/auth/register.dart';
import '../../domain/usecases/auth/request_otp.dart';
import '../../domain/usecases/auth/update_detail.dart';
import '../../domain/usecases/auth/verify_email.dart';
import '../../main.dart';
import '../widgets/loader_popup.dart';

@lazySingleton
class AuthNotifier extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final GetSavedUserUsecase savedUserUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final UpdateUserDetailUsecase updateUserDetailUsecase;
  final DeleteUserUsecase deleteUserUsecase;
  final RequestOTPUsecase requestOTPUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final VerifyEmailUsecase verifyEmailUsecase;

  AuthNotifier({
    required this.loginUsecase,
    required this.savedUserUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.updateUserDetailUsecase,
    required this.deleteUserUsecase,
    required this.requestOTPUsecase,
    required this.changePasswordUsecase,
    required this.verifyEmailUsecase,
  });

  var onboardingData = GenericStore<Map<String, dynamic>>({
    "firstName": "",
    "lastName": "",
    "middleName": "",
    "email": "",
    "phone": "",
    "address": "",
    "country": "",
    "userType": "",
    "internationalPassport": "",
    "drivingLicense": "",
    "votersCard": "",
    "nin": "",
    "plateNo": "",
    "password": "",
    "rePassword": "",
    "device": ""
  });
  final user = GenericStore<Person?>(null);

  Future<bool> login({
    required String email,
    required String password,
    required String device,
  }) async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await loginUsecase(
        LoginUsecaseParams(email: email, password: password, device: device));
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));

        return false;
      },
      (r) {
        user.emit(r);
        return true;
      },
    );
  }

  Future<bool> checkSavedUser() async {
    final response = await savedUserUsecase(NoParams());
    if (response != null) {
      user.emit(response);
    }
    return response != null;
  }

  Future<bool> register() async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await registerUsecase(onboardingData.value);
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return false;
      },
      (r) {
        return true;
      },
    );
  }

  Future<void> logout() async {
    await logoutUsecase(NoParams());
    user.emit(null);
  }

  Future<bool> updateUserDetails(
      {required String firstName,
      required String lastName,
      required String middleName,
      required String firebaseToken,
      required double longitude,
      required double latitude}) async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await updateUserDetailUsecase(
        UpdateUserDetailUsecaseParams(
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            firebaseToken: firebaseToken,
            longitude: longitude,
            latitude: latitude));
    await checkSavedUser();
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return false;
      },
      (r) {
        AppFlushbar.show(r, isError: false);
        return true;
      },
    );
  }

  Future<bool> deleteUser() async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await deleteUserUsecase(NoParams());
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return false;
      },
      (r) async {
        await logout();
        return true;
      },
    );
  }

  Future<bool> requestOTP() async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await requestOTPUsecase(onboardingData.value['email']);
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return false;
      },
      (r) {
        AppFlushbar.show(r, isError: false);
        return true;
      },
    );
  }

  Future<bool> changePassword({
    required String password,
    required String rePassword,
    required String otp,
  }) async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await changePasswordUsecase(
      ChangePasswordUsecaseParams(
          password: password, rePassword: rePassword, otp: otp),
    );
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return false;
      },
      (r) {
        AppFlushbar.show(r, isError: false);
        return true;
      },
    );
  }

  @disposeMethod
  void onDone() {
    onboardingData.close();
    user.close();
  }

  Future<bool> verifyEmail() async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await verifyEmailUsecase(
      VerifyEmailUsecaseParams(
          otp: onboardingData.value['otp'],
          email: onboardingData.value['email']),
    );
    nav.pop();
    return response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return false;
      },
      (r) {
        return true;
      },
    );
  }
}
