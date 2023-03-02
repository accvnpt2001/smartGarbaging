import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bin {
  String id;
  String name;
  String address;
  String imageUrl;
  double lat;
  double long;
  int organic;
  int inorganic;
  int recyclable;
  int total;
  Bin({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.lat,
    required this.long,
    required this.organic,
    required this.inorganic,
    required this.recyclable,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'address': address,
      'image': imageUrl,
      'lat': lat,
      'long': long,
      'organics': organic,
      'inorganics': inorganic,
      'recyclables': recyclable,
    };
  }

  factory Bin.fromMap(Map<String, dynamic> map) {
    return Bin(
      id: map['_id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      imageUrl: map['image'] as String,
      lat: map['lat'].toDouble(),
      long: map['long'].toDouble(),
      organic: map['organic'],
      inorganic: map['inorganic'],
      recyclable: map['recyclable'],
      total: (map['organic'] + map['inorganic'] + map['recyclable']) ~/ 3,
    );
  }

  factory Bin.fromMapUserId(Map<String, dynamic> map) {
    return Bin(
      id: map['binId'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      imageUrl: map['image'] as String,
      lat: map['lat'].toDouble(),
      long: map['long'].toDouble(),
      organic: map['organic'],
      inorganic: map['inorganic'],
      recyclable: map['recyclable'],
      total: (map['organic'] + map['inorganic'] + map['recyclable']) ~/ 3,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bin.fromJson(String source) => Bin.fromMap(json.decode(source) as Map<String, dynamic>);
}
