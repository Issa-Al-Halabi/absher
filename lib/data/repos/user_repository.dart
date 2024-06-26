
import 'package:absher/core/api_const.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:absher/models/params/otp_confirm_params.dart';
import 'package:absher/models/params/forget_password_params.dart';
import 'package:absher/models/params/sign_up_params.dart';
import 'package:absher/models/sign_up_response.dart';
import 'package:dartz/dartz.dart';

import '../../core/firebase_notifications_handler.dart';
import '../../models/login_response.dart';
import '../../models/otp_verify_response.dart';
import '../../models/params/login_params.dart';
import '../../models/params/reset_password_params.dart';

class UserRepository {
  Future<Either<String, LoginResponse>> authenticate(
      {LoginParams? loginParams}) async {
    String? token= await FirebaseNotificationsHandler().refreshFcmToken();
    return BaseApiClient.post<LoginResponse>(
        url: ApiConst.login,
        queryParameters: {
          "password": loginParams?.password,
          "phone": loginParams?.phone,
          "device_token":token
        },
        converter: (e) {
          return LoginResponse.fromJson(e['data']);
        });
  }

  void deleteToken() async {
    DataStore.instance.deleteToken();
  }

  Future<bool> hasToken() async {
    return DataStore.instance.hasToken;
  }

  void saveToken(String token) {
    DataStore.instance.setToken(token);
  }
  Future<Either<String, OtpVerifyResponse>> signUpPhoneNumber(
      String phoneNumber) async {
    return BaseApiClient.post<OtpVerifyResponse>(
        url: ApiConst.signUpPhoneNumber,
        queryParameters: {"phone": phoneNumber},
        converter: (e) {
          print(OtpVerifyResponse.fromJson(e['data']));
          return OtpVerifyResponse.fromJson(e['data']);
        });
  }
  Future<Either<String, bool>> confirmOtp(
      OtpConfirmParams? otpConfirmParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.signUpVerifyOtp,
        queryParameters: otpConfirmParams?.toJson(),
        converter: (e) {
          return true;
        });
  }

  Future<Either<String, SignUpResponse>> signUp(
      SignUpParams? signUpParams) async {
    return BaseApiClient.post<SignUpResponse>(
        url: ApiConst.signUpRegister,
        queryParameters: signUpParams?.toJson(),
        converter: (e) {
          return SignUpResponse.fromJson(e['data']);
        });
  }

  Future<Either<String, OtpVerifyResponse>> forgetPasswordGenerateOtp(
      String phoneNumber) async {
    return BaseApiClient.post<OtpVerifyResponse>(
        url: ApiConst.forgetPasswordGenerateOtp,
        queryParameters: {"phone": phoneNumber},
        converter: (e) {
          return OtpVerifyResponse.fromJson(e['data']);
        });
  }
  Future<Either<String, bool>> forgetPassword(
      ForgetPasswordParams forgetPasswordParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.forgetPassword,
        queryParameters: forgetPasswordParams.toJson(),
        converter: (e) {
          return true;
        });
  }
  Future<Either<String, bool>> resetPassword(
      ResetPasswordParams forgetPasswordParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.resetPassword,
        queryParameters: forgetPasswordParams.toJson(),
        converter: (e) {
          return true;
        });
  }
}
