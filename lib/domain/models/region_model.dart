class RegionModel {
  final int? id;
  final String? name;


  RegionModel(
      {required this.id,
      required this.name,});

  factory RegionModel.fromJson(Map<String, dynamic> json) {

    return RegionModel(
        id: json['id']??'', 
        name: json['name']??'',);
  }
}
