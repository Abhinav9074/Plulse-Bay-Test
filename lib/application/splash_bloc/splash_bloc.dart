import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/splash_bloc/splash_event.dart';
import 'package:pulse_bay/application/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {

    //delay time for displaying splash screen
    Timer(const Duration(seconds: 5), () {
      add(SplashLoadedEvent());
    });

    //emit loaded state to end the splash screen
    on<SplashLoadedEvent>((event, emit){
      emit(SplashLoadedState());
    });
  }
}
