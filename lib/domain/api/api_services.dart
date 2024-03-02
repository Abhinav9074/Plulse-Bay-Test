import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pulse_bay/domain/api/api_config.dart';
import 'package:pulse_bay/domain/functions/shared_preference.dart';
import 'package:pulse_bay/domain/models/industry_model.dart';
import 'package:pulse_bay/domain/models/region_model.dart';
import 'package:pulse_bay/domain/models/tradies_model.dart';

class ApiServices {
  //Login function
  Future<bool> login(String email, String password) async {
    try {
      final response = await http
          .post(Uri.parse(ApiConfig.baseUrl + ApiConfig.login), body: {
        'email': email,
        'password': password,
        'firebase_token': 'sdsdasdfsdgsfvgedsrg3'
      });

      final data = json.decode(response.body);

      log(response.body);

      if (response.statusCode == 200) {
        SharedPreferenceFunction()
            .sharedInstance
            .setString('AuthToken', data['accessToken']);
        SharedPreferenceFunction()
            .sharedInstance
            .setString('UserName', data['fullName']);
        SharedPreferenceFunction()
            .sharedInstance
            .setString('Id', data['id'].toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error in login');
      log(e.toString());
      return false;
    }
  }

  //Logout function
  static Future<void> logOut() async {
    try {
      final data = await http
          .get(Uri.parse(ApiConfig.baseUrl + ApiConfig.logOut), headers: {
        'Authorization':
            'Bearer ${SharedPreferenceFunction().sharedInstance.getString('AuthToken')}'
      });

      log(data.statusCode.toString());
    } catch (e) {
      log('Error');
      log(e.toString());
    }
  }

  //Function to fetch all industry from api
  Future<List<IndustryModel>> getAllIndustries() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.baseUrl + ApiConfig.industries), headers: {
        'Authorization':
            'Bearer ${SharedPreferenceFunction().sharedInstance.getString('AuthToken')}'
      });

      log(response.body.toString());
      final data = json.decode(response.body);
      final List<dynamic> results = data['data'];
      return results.map((json) => IndustryModel.fromJson(json)).toList();
    } catch (e) {
      log('Error while fetching industry');
      log(e.toString());
      throw Exception(e);
    }
  }

  //Function to fetch all tradies from api
  Future<List<TradiesModel>> getAllTradies(location) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiConfig.baseUrl}${ApiConfig.traidies}&region=${location.toLowerCase().trim()}'));

      log(response.body.toString());
      final data = json.decode(response.body);
      final List<dynamic> results = data['data'];
      return results.map((json) => TradiesModel.fromJson(json)).toList();
    } catch (e) {
      log('Error while fetching tradies');
      log(e.toString());
      throw Exception(e);
    }
  }

  //Function to fetch all regions from api
  Future<List<RegionModel>> getAllRegions() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.baseUrl + ApiConfig.regions), headers: {
        'Authorization':
            'Bearer ${SharedPreferenceFunction().sharedInstance.getString('AuthToken')}'
      });

      log(response.body.toString());
      final data = json.decode(response.body);
      final List<dynamic> results = data['data'];
      return results.map((json) => RegionModel.fromJson(json)).toList();
    } catch (e) {
      log('Error while fetching regions');
      log(e.toString());
      throw Exception(e);
    }
  }
}
