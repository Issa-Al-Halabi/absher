import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:bloc/bloc.dart';

import '../../data/repos/user_repository.dart';
import '../../models/params/login_params.dart';
import '../authentication_bloc/authentication_event.dart';
import '../authentication_bloc/authertication_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginParams loginParams = LoginParams();

  LoginBloc(this.userRepository, this.authenticationBloc) : super(LoginInit()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        emit(LoginLoading());
        final response =
            await userRepository.authenticate(loginParams: event.loginParams);
        response.fold((l) {
          emit(LoginError(l));
        }, (r) {
          authenticationBloc.add(LoggedIn(loginResponse: r));
          emit(LoginConfirmed());
        });
      }

      if (event is CheckForTermsAcceptance) {
        if (!DataStore.instance.termsViewed) {
          emit(TermsAcceptRequired());
        }
      }
    });
  }
}
