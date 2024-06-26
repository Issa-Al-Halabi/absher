import 'dart:async';

import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:absher/models/login_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  LoginResponse? loginResponse;
  bool loggedIn = true;
  AuthenticationBloc(
    this.userRepository,
  ) : super(AuthenticationUninitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AppStarted) {
        final bool hasToken = await userRepository.hasToken();
        await Future.delayed(const Duration(seconds: 4)).then((value) {
          if (hasToken) {
            loginResponse = DataStore.instance.userInfo;
            emit(AuthenticationAuthenticated());
          } else {
            if (loggedIn == false) {
              emit(AuthenticationGuest());
            } else {
              emit(AuthenticationUnauthenticated());
            }
          }
        });
      }

      if (event is LoggedIn) {
        loggedIn = true;
        DataStore.instance.setToken(event.loginResponse.token);
        DataStore.instance.setUserInfo(event.loginResponse);
        loginResponse = event.loginResponse;
        emit(AuthenticationAuthenticated());
      }
      if (event is LoggedGuest) {
        loggedIn = false;
        emit(AuthenticationGuest());
      }
      if (event is LoggedOut) {
        userRepository.deleteToken();
        DataStore.instance.deleteUserInfo();
        emit(AuthenticationLoggedOut());
      }
    });
  }
}
