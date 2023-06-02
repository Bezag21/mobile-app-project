import '../../../application/auth/bloc/authentication_bloc.dart';
import '../../../infrastructure/auth/login_repository.dart';
import '/infrastructure/core/sharedPref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/signin_form/signin_form_event.dart';
import '../../../application/signin_form/signin_form_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  SharedPref pref = SharedPref();
  LoginRepo loginRepo = LoginRepo();

  AuthBloc() : super(Idle()) {
    on<LoginEvent>(_onLogin);
  }

  void _onLogin(LoginEvent event, Emitter emit) async {
    emit(LoggingIn());

    try {
      final response = await loginRepo.login(event.loginDomain);
      await pref.saveName(response.username.toString());
      await pref.saveToken(response.token.toString());
      await pref.saveRole(response.role.toString());
      emit(LoginSuccessful());
    } catch (error) {
      emit(LoginFailed());
    }
  }
}
