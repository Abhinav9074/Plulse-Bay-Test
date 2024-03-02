import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/login_bloc/login_event.dart';
import 'package:pulse_bay/application/login_bloc/login_state.dart';
import 'package:pulse_bay/domain/api/api_services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoggedInEvent>((event, emit) async {
      emit(LoginLoadingState());
      final ApiServices service = ApiServices();
      if (await service.login(event.email, event.password) == true) {
        emit(LoginSuccessState());
      } else {
        emit(LoginFailedState());
      }
    });
  }
}
