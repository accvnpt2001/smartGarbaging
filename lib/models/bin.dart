import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bin {
  String id;
  String name;
  String address;
  String imageUrl;
  double lat;
  double long;
  List<int> organics;
  List<int> inorganics;
  List<int> recyclables;
  List<int> total;
  Bin({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.lat,
    required this.long,
    required this.organics,
    required this.inorganics,
    required this.recyclables,
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
      'organics': organics,
      'inorganics': inorganics,
      'recyclables': recyclables,
      'total': total,
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
      organics: map['organics'].cast<int>(),
      inorganics: map['inorganics'].cast<int>(),
      recyclables: map['recyclables'].cast<int>(),
      total: map['total'].cast<int>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bin.fromJson(String source) => Bin.fromMap(json.decode(source) as Map<String, dynamic>);
}
