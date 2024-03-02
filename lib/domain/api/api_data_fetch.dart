
import 'package:flutter/material.dart';
import 'package:pulse_bay/domain/api/api_services.dart';
import 'package:pulse_bay/domain/models/industry_model.dart';
import 'package:pulse_bay/domain/models/region_model.dart';
import 'package:pulse_bay/domain/models/tradies_model.dart';

ValueNotifier<List<IndustryModel>> industryList = ValueNotifier([]);
ValueNotifier<List<TradiesModel>> tradiesList = ValueNotifier([]);
ValueNotifier<List<RegionModel>> regionList = ValueNotifier([]);

//set all industry in value listenable builder
Future<void> fetchIndustry()async{

  final ApiServices service = ApiServices();
  industryList.value.clear();
  industryList.value = await service.getAllIndustries();
}

Future<void> fetchTradies(String location)async{

  final ApiServices service = ApiServices();
  industryList.value.clear();
  tradiesList.value = await service.getAllTradies(location);
}

Future<void> fetchRegions()async{

  final ApiServices service = ApiServices();
  industryList.value.clear();
  regionList.value = await service.getAllRegions();
}