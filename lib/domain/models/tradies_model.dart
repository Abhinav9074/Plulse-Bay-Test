import 'dart:developer';

class TradiesModel {
  final int? id;
  final int? rating;
  final String? name;
  final String? email;
  final String? region;
  final String? logo;
  final String? industry;

  TradiesModel(
      {required this.id,
      required this.rating,
      required this.name,
      required this.email,
      required this.region,
      required this.logo,
      required this.industry});

  factory TradiesModel.fromJson(Map<String, dynamic> json) {
    return TradiesModel(
        id: json['id']??0,
        rating: json['rating']??0,
        name: json['business_name']??'',
        email: json['email']??'',
        region: json['region']??'',
        logo: json['logo']??'',
        industry: json['industry']['name']??'');
  }
}
