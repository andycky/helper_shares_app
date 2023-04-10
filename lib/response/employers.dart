import 'dart:convert';

class Employer {
  final dynamic name;
  final dynamic count;
  final dynamic count_interview;
  final dynamic match;
  final dynamic mobile;
  final dynamic service;
  final dynamic N;
  final dynamic L;
  final dynamic S;
  final dynamic age;
  final dynamic D;
  final dynamic R;
  final dynamic H;
  final dynamic G;

  const Employer({
    required this.name,
    required this.count,
    required this.count_interview,
    required this.match,
    required this.mobile,
    required this.service,
    required this.N,
    required this.L,
    this.S,
    this.age,
    this.D,
    this.R,
    this.H,
    this.G,
  });

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      name: json['name'] as dynamic,
      count: json['count'] as dynamic,
      count_interview: json['count_interview'] as dynamic,
      match: json['match'] as dynamic,
      mobile: json['mobile'] as dynamic,
      service: json['service'] as dynamic,
      N: json['N'] as dynamic,
      L: json['L'] as dynamic,
      S: json['S'] as dynamic,
      age: json['age'] as dynamic,
      D: json['D2'] as dynamic,
      R: json['R'] as dynamic,
      H: json['H2'] as dynamic,
      G: json['G'] as dynamic,
    );
  }

  static List<Employer> parseEmployers(String responseBody) {

    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Employer>((json) => Employer.fromJson(json)).toList();
  }
}




class Employers {
  List<Employer> employers;

  Employers(
    this.employers
  );

  factory Employers.fromJson(dynamic jsonList) {
    print(jsonList.toString());
    var _jsonList = jsonList[0] as List;
    List<Employer> _employers = _jsonList.map((tagJson) => Employer.fromJson(tagJson)).toList();
    print(_employers.toString());
    return Employers(_employers);
  }
}