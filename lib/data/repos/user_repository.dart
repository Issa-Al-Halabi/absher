import 'package:absher/core/api_const.dart';
import 'package:absher/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:absher/models/params/otp_confirm_params.dart';
import 'package:absher/models/params/sign_up_params.dart';
import 'package:absher/models/sign_up_response.dart';
import 'package:dartz/dartz.dart';

import '../../models/login_response.dart';
import '../../models/otp_verify_response.dart';
import '../../models/params/login_params.dart';

class UserRepository {
  Future<Either<String, LoginResponse>> authenticate({
    LoginParams? loginParams
  }) async {
  return  BaseApiClient.post<LoginResponse>(
        url: ApiConst.login,
        queryParameters: {"phone": loginParams?.phone
        ,"password":loginParams?.password},
        converter: (e) {
          return LoginResponse.fromJson(e['data']);
        });
  }

  Future<void> deleteToken() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }

  Future<Either<String, OtpVerifyResponse>> signUpPhoneNumber(
      String phoneNumber) async {
    return BaseApiClient.post<OtpVerifyResponse>(
        url: ApiConst.signUpPhoneNumber,
        queryParameters: {"phone": phoneNumber},
        converter: (e) {
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
}
