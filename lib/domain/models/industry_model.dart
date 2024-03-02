import 'dart:developer';

class IndustryModel {
  final int? id;
  final String? name;
  final String? icon;
  final String? description;

  IndustryModel(
      {required this.id,
      required this.name,
      required this.icon,
      required this.description});

  factory IndustryModel.fromJson(Map<String, dynamic> json) {
    log(json['name']);
    return IndustryModel(
        id: json['id']??'', 
        name: json['name']??'', 
        icon: json['icon']??'', 
        description: json['description']??'');
  }
}
