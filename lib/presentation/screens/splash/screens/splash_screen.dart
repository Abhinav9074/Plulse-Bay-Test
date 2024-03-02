import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_event.dart';
import 'package:pulse_bay/application/region_bloc/region_bloc.dart';
import 'package:pulse_bay/application/region_bloc/region_event.dart';
import 'package:pulse_bay/application/splash_bloc/splash_bloc.dart';
import 'package:pulse_bay/application/splash_bloc/splash_state.dart';
import 'package:pulse_bay/application/tradie_bloc/tradie_event.dart';
import 'package:pulse_bay/application/tradie_bloc/traide_bloc.dart';
import 'package:pulse_bay/domain/functions/shared_preference.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if(state is SplashLoadedState){
            if(SharedPreferenceFunction().sharedInstance.getString('AuthToken')==null||SharedPreferenceFunction().sharedInstance.getString('AuthToken')!.isEmpty){
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }else{
              BlocProvider.of<HomeBloc>(context).add(HomeDataFetchEvent());
              BlocProvider.of<RegionBloc>(context).add(RegionFetchEvent());
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          }
        },
        child: Center(
          child: Image.asset('assets/logo/logo.png'),
        ),
      ),
    );
  }
}
