import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BinModel {
  String id;
  double lat;
  double long;
  String urlImage;
  int percentRub;
  String description;
  BinModel({
    required this.id,
    required this.lat,
    required this.long,
    required this.urlImage,
    required this.percentRub,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lat': lat,
      'long': long,
      'urlImage': urlImage,
      'percentRub': percentRub,
      'description': description,
    };
  }

  factory BinModel.fromMap(Map<String, dynamic> map) {
    return BinModel(
      id: map['id'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
      urlImage: map['urlImage'] as String,
      percentRub: map['percentRub'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BinModel.fromJson(String source) => BinModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
