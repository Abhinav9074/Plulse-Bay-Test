import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_bloc.dart';
import 'package:pulse_bay/application/login_bloc/login_bloc.dart';
import 'package:pulse_bay/application/region_bloc/region_bloc.dart';
import 'package:pulse_bay/application/splash_bloc/splash_bloc.dart';
import 'package:pulse_bay/application/tradie_bloc/traide_bloc.dart';
import 'package:pulse_bay/domain/functions/shared_preference.dart';
import 'package:pulse_bay/presentation/config/routes.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceFunction().createSharedInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers:
    [
      BlocProvider(create: (context)=>SplashBloc()),
      BlocProvider(create: (context)=>LoginBloc()),
      BlocProvider(create: (context)=>HomeBloc()),
      BlocProvider(create: (context)=>TradieBloc()),
      BlocProvider(create: (context)=>RegionBloc()),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/splash',
    ));
  }
}