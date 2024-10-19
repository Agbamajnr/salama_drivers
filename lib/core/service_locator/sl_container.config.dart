// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:salama_users/core/local_storage/__export.dart' as _i815;
import 'package:salama_users/core/local_storage/secure_storage.dart' as _i220;
import 'package:salama_users/core/location/__export.dart' as _i35;
import 'package:salama_users/core/location/device_location.dart' as _i30;
import 'package:salama_users/core/network/__export.dart' as _i172;
import 'package:salama_users/core/network/http_requester.dart' as _i715;
import 'package:salama_users/core/network/internet_connection.dart' as _i1056;
import 'package:salama_users/core/service_locator/register_module.dart' as _i5;
import 'package:salama_users/data/datasources/auth/auth_remote_datasource.dart'
    as _i747;
import 'package:salama_users/data/datasources/subscriptions/subscriptions_remote_datasource.dart'
    as _i286;
import 'package:salama_users/data/repositories/auth/auth_repository_impl.dart'
    as _i645;
import 'package:salama_users/data/repositories/subscriptions/subscription_repository_impl.dart'
    as _i232;
import 'package:salama_users/domain/repositories/auth/auth_repository.dart'
    as _i127;
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart'
    as _i531;
import 'package:salama_users/domain/usecases/auth/change_password.dart'
    as _i421;
import 'package:salama_users/domain/usecases/auth/dashboard_usecase.dart'
    as _i891;
import 'package:salama_users/domain/usecases/auth/delete_user.dart' as _i1057;
import 'package:salama_users/domain/usecases/auth/get_current_position.dart'
    as _i102;
import 'package:salama_users/domain/usecases/auth/get_saved_user.dart'
    as _i1050;
import 'package:salama_users/domain/usecases/auth/login.dart' as _i755;
import 'package:salama_users/domain/usecases/auth/logout.dart' as _i92;
import 'package:salama_users/domain/usecases/auth/register.dart' as _i140;
import 'package:salama_users/domain/usecases/auth/request_otp.dart' as _i523;
import 'package:salama_users/domain/usecases/auth/update_detail.dart' as _i578;
import 'package:salama_users/domain/usecases/auth/verify_email.dart' as _i807;
import 'package:salama_users/domain/usecases/subscriptions/accept_ride.dart'
    as _i641;
import 'package:salama_users/domain/usecases/subscriptions/cancel_booking.dart'
    as _i787;
import 'package:salama_users/domain/usecases/subscriptions/complete_booking_usecase.dart'
    as _i489;
import 'package:salama_users/domain/usecases/subscriptions/create_subscription_usecase.dart'
    as _i230;
import 'package:salama_users/domain/usecases/subscriptions/fetch_active_booking_usecase.dart'
    as _i325;
import 'package:salama_users/domain/usecases/subscriptions/fetch_address_coordinate_usecase.dart'
    as _i349;
import 'package:salama_users/domain/usecases/subscriptions/fetch_bookings_usecase.dart'
    as _i82;
import 'package:salama_users/domain/usecases/subscriptions/fetch_report_usecase.dart'
    as _i843;
import 'package:salama_users/domain/usecases/subscriptions/fetch_single_post_usecase.dart'
    as _i257;
import 'package:salama_users/domain/usecases/subscriptions/fetch_subscriptions_usecase.dart'
    as _i362;
import 'package:salama_users/domain/usecases/subscriptions/fetch_user_subscriptions.dart'
    as _i522;
import 'package:salama_users/domain/usecases/subscriptions/report_booking_usecase.dart'
    as _i284;
import 'package:salama_users/domain/usecases/subscriptions/start_booking_usecase.dart'
    as _i465;
import 'package:salama_users/domain/usecases/subscriptions/update_report_usecase.dart'
    as _i186;
import 'package:salama_users/presentation/notifiers/auth_notifier.dart'
    as _i745;
import 'package:salama_users/presentation/notifiers/subscription_notifier.dart'
    as _i1071;
import 'package:salama_users/presentation/widgets/loader_popup.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i973.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.factory<_i558.FlutterSecureStorage>(
        () => registerModule.flutterSecureStorage);
    gh.lazySingleton<_i811.PopupLoader>(() => _i811.PopupLoader());
    gh.lazySingleton<_i1056.InternetConnection>(() =>
        _i1056.InternetConnectionImpl(gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i30.DeviceLocation>(() => _i30.DeviceLocationImpl());
    gh.lazySingleton<_i715.HttpRequester>(
        () => _i715.HttpRequester(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i220.SecureStorage>(
        () => _i220.SecureStorageImpl(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i747.AuthRemoteDatasource>(
        () => _i747.AuthRemoteDatasourceImpl(
              httpRequester: gh<_i172.HttpRequester>(),
              networkInfo: gh<_i172.InternetConnection>(),
              secureStorage: gh<_i815.SecureStorage>(),
            ));
    gh.lazySingleton<_i127.AuthRepository>(() => _i645.AuthRepositoryImpl(
          secureStorage: gh<_i815.SecureStorage>(),
          remoteDatasource: gh<_i747.AuthRemoteDatasource>(),
          deviceLocation: gh<_i35.DeviceLocation>(),
        ));
    gh.lazySingleton<_i286.SubscriptionsRemoteDatasource>(
        () => _i286.SubscriptionRemoteDatasourceImpl(
              httpRequester: gh<_i172.HttpRequester>(),
              networkInfo: gh<_i172.InternetConnection>(),
              secureStorage: gh<_i815.SecureStorage>(),
            ));
    gh.lazySingleton<_i102.GetCurrentPositionUsecase>(() =>
        _i102.GetCurrentPositionUsecase(
            authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i1050.GetSavedUserUsecase>(() =>
        _i1050.GetSavedUserUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i755.LoginUsecase>(
        () => _i755.LoginUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i92.LogoutUsecase>(
        () => _i92.LogoutUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i140.RegisterUsecase>(() =>
        _i140.RegisterUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i1057.DeleteUserUsecase>(() =>
        _i1057.DeleteUserUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i523.RequestOTPUsecase>(() =>
        _i523.RequestOTPUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i807.VerifyEmailUsecase>(() =>
        _i807.VerifyEmailUsecase(authRepository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i421.ChangePasswordUsecase>(() =>
        _i421.ChangePasswordUsecase(repository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i891.DashboardUsecase>(
        () => _i891.DashboardUsecase(repository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i578.UpdateUserDetailUsecase>(() =>
        _i578.UpdateUserDetailUsecase(repository: gh<_i127.AuthRepository>()));
    gh.lazySingleton<_i745.AuthNotifier>(
      () => _i745.AuthNotifier(
        loginUsecase: gh<_i755.LoginUsecase>(),
        savedUserUsecase: gh<_i1050.GetSavedUserUsecase>(),
        registerUsecase: gh<_i140.RegisterUsecase>(),
        logoutUsecase: gh<_i92.LogoutUsecase>(),
        updateUserDetailUsecase: gh<_i578.UpdateUserDetailUsecase>(),
        deleteUserUsecase: gh<_i1057.DeleteUserUsecase>(),
        requestOTPUsecase: gh<_i523.RequestOTPUsecase>(),
        changePasswordUsecase: gh<_i421.ChangePasswordUsecase>(),
        verifyEmailUsecase: gh<_i807.VerifyEmailUsecase>(),
      ),
      dispose: (i) => i.onDone(),
    );
    gh.lazySingleton<_i531.SubscriptionsRepository>(
        () => _i232.SubscriptionRepositoryImpl(
              secureStorage: gh<_i815.SecureStorage>(),
              remoteDatasource: gh<_i286.SubscriptionsRemoteDatasource>(),
            ));
    gh.lazySingleton<_i641.AcceptRideUsecase>(() => _i641.AcceptRideUsecase(
        repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i787.CancelBookingUsecase>(() =>
        _i787.CancelBookingUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i489.CompleteBookingUsecase>(() =>
        _i489.CompleteBookingUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i230.CreateSubscriptionUsecase>(() =>
        _i230.CreateSubscriptionUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i349.FetchAddressCoordinateUsecase>(() =>
        _i349.FetchAddressCoordinateUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i82.FetchBookingUsecase>(() => _i82.FetchBookingUsecase(
        repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i843.FetchReportUsecase>(() => _i843.FetchReportUsecase(
        repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i362.FetchSubscriptionUsecase>(() =>
        _i362.FetchSubscriptionUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i522.FetchUserSubscriptionUsecase>(() =>
        _i522.FetchUserSubscriptionUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i284.ReportBookingUsecase>(() =>
        _i284.ReportBookingUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i465.StartBookingUsecase>(() => _i465.StartBookingUsecase(
        repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i186.UpdateReportUsecase>(() => _i186.UpdateReportUsecase(
        repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i257.FetchSinglebookingUsecase>(() =>
        _i257.FetchSinglebookingUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i325.FetchActivebookingUsecase>(() =>
        _i325.FetchActivebookingUsecase(
            repository: gh<_i531.SubscriptionsRepository>()));
    gh.lazySingleton<_i1071.SubscriptionsNotifier>(
        () => _i1071.SubscriptionsNotifier(
              createSubscriptionUsecase: gh<_i230.CreateSubscriptionUsecase>(),
              currentPositionUsecase: gh<_i102.GetCurrentPositionUsecase>(),
              fetchSubscriptionUsecase: gh<_i362.FetchSubscriptionUsecase>(),
              fetchUserSubscriptionUsecase:
                  gh<_i522.FetchUserSubscriptionUsecase>(),
              acceptRideUsecase: gh<_i641.AcceptRideUsecase>(),
              fetchBookingUsecase: gh<_i82.FetchBookingUsecase>(),
              fetchSinglebookingUsecase: gh<_i257.FetchSinglebookingUsecase>(),
              fetchActivebookingUsecase: gh<_i325.FetchActivebookingUsecase>(),
              cancelBookingUsecase: gh<_i787.CancelBookingUsecase>(),
              startBookingUsecase: gh<_i465.StartBookingUsecase>(),
              completeBookingUsecase: gh<_i489.CompleteBookingUsecase>(),
              reportBookingUsecase: gh<_i284.ReportBookingUsecase>(),
              fetchReportUsecase: gh<_i843.FetchReportUsecase>(),
              fetchAddressCoordinateUsecase:
                  gh<_i349.FetchAddressCoordinateUsecase>(),
            ));
    return this;
  }
}

class _$RegisterModule extends _i5.RegisterModule {}
