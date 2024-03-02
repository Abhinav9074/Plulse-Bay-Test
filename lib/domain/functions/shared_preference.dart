import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFunction {

  //Creating Singleton
  SharedPreferenceFunction._internal();
  static SharedPreferenceFunction instance =
      SharedPreferenceFunction._internal();
  factory SharedPreferenceFunction() {
    return instance;
  }

  late SharedPreferences sharedInstance;

  //Creating instance of shared pref for future use
  Future<void>createSharedInstance()async{
    sharedInstance = await SharedPreferences.getInstance();
    log('Instance Created');
  }
}
