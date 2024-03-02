import 'package:pulse_bay/presentation/screens/home/screens/home_screen.dart';
import 'package:pulse_bay/presentation/screens/login/screens/login_screen.dart';
import 'package:pulse_bay/presentation/screens/splash/screens/splash_screen.dart';
import 'package:pulse_bay/presentation/screens/tradies/screens/tradies_screen.dart';

final routes = {
  '/splash': (context) => const SplashScreen(),
  '/login': (context) =>  LoginScreen(),
  '/' : (context) =>  HomeScreen(),
  '/tradies' : (context) => const TradiedScreen(),
};
