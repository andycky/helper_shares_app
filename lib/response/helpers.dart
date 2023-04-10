import 'dart:convert';
import 'dart:ui';

class Helper {
  final String name;
  final String nname;
  final dynamic count;
  final dynamic count_interview;
  final dynamic match;
  final dynamic mobile;
  final dynamic image;
  final dynamic link;
  final String mark;
  final int color;
  final dynamic service;
  final dynamic N;
  final dynamic L;
  final dynamic S;
  final dynamic age;
  final dynamic D;
  final dynamic R;
  final dynamic H;
  final dynamic G;
  final dynamic employer;
  final dynamic employerS;

  const Helper({
    required this.name,
    required this.nname,
    required this.count,
    required this.count_interview,
    required this.match,
    required this.mobile,
    required this.image,
    required this.link,
    required this.mark,
    required this.color,
    required this.service,
    required this.N,
    required this.L,
    this.S,
    this.age,
    this.D,
    this.R,
    this.H,
    this.G,
    this.employer,
    this.employerS
  });

  factory Helper.fromJson(Map<String, dynamic> json) {
    return Helper(
      name: json['name'] as String,
      nname: json["name"].split("-").first.
      replaceFirst(json['mobile'].toString().substring(
          json['mobile'].toString().length-4,json['mobile'].toString().length),""),
      count: json['count'] ?? "" as dynamic,
      count_interview: json['count_interview'] ?? "" as dynamic,
      match: json['match'] ?? "" as dynamic,
      mobile: json['mobile'] as dynamic,
      image: json['image'] as dynamic,
      link: json['link'] as dynamic,
      mark: json['mark'] as String,
      color: int.parse(json['color'].toString().replaceAll("#","0x")),
      service: json['service'] as dynamic,
      N: json['N'] as dynamic,
      L: json['L'] as dynamic,
      S: json['S'] as dynamic,
      age: json['age'] as dynamic,
      D: json['D2'] as dynamic,
      R: json['R'] as dynamic,
      H: json['H2'] as dynamic,
      G: json['G'] as dynamic,
      employer: json['employer'] as dynamic,
      employerS: json['employerS'] as dynamic,
    );
  }

  static List<Helper> parseHelpers(String responseBody) {

    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Helper>((json) => Helper.fromJson(json)).toList();
  }
}




class Helpers {
  List<Helper> helpers;

  Helpers(
    this.helpers
  );

  factory Helpers.fromJson(dynamic jsonList) {
    print(jsonList.toString());
    var _jsonList = jsonList[0] as List;
    List<Helper> _helpers = _jsonList.map((tagJson) => Helper.fromJson(tagJson)).toList();
    print(_helpers.toString());
    return Helpers(_helpers);
  }
}