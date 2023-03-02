import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BinDetail {
  List<int> organics;
  List<int> inorganics;
  List<int> recyclables;
  BinDetail({
    required this.organics,
    required this.inorganics,
    required this.recyclables,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organics': organics,
      'inorganics': inorganics,
      'recyclables': recyclables,
    };
  }

  factory BinDetail.fromMap(Map<String, dynamic> map) {
    return BinDetail(
      organics: map['organics'].cast<int>(),
      inorganics: map['inorganics'].cast<int>(),
      recyclables: map['recyclables'].cast<int>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BinDetail.fromJson(String source) => BinDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
