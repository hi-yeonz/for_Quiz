import 'dart:convert';

//Sample Quiz 클래스
class SampleQuiz {
  // ignore: non_constant_identifier_names
  final int QN;
  // ignore: non_constant_identifier_names
  final String Question;
  // ignore: non_constant_identifier_names
  final String BodyQ;
  // ignore: non_constant_identifier_names
  final String FirstQ;
  // ignore: non_constant_identifier_names
  final String SecondQ;
  // ignore: non_constant_identifier_names
  final String ThirdQ;
  // ignore: non_constant_identifier_names
  final String ForthQ;
  // ignore: non_constant_identifier_names
  final String FifthQ;

  SampleQuiz({
    // ignore: non_constant_identifier_names
    this.QN,
    // ignore: non_constant_identifier_names
    this.Question,
    // ignore: non_constant_identifier_names
    this.BodyQ,
    // ignore: non_constant_identifier_names
    this.FirstQ,
    // ignore: non_constant_identifier_names
    this.SecondQ,
    // ignore: non_constant_identifier_names
    this.ThirdQ,
    // ignore: non_constant_identifier_names
    this.ForthQ,
    // ignore: non_constant_identifier_names
    this.FifthQ,
  });

//Map 형식의 데이터를 Json 형식으로 바꿔줌.
//Json : 데이터를 저장 및 전송할 때 데이터를 표현하는 형식

  factory SampleQuiz.fromRawJson(String str) => SampleQuiz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SampleQuiz.fromJson(Map<String, dynamic> json) => new SampleQuiz(
        QN: json['QN'],
        Question: json['Question'],
        BodyQ: json['BodyQ'],
        FirstQ: json['FirstQ'],
        SecondQ: json['SecondQ'],
        ThirdQ: json['ThirdQ'],
        ForthQ: json['ForthQ'],
        FifthQ: json['FifthQ'],
      );

  Map<String, dynamic> toJson() => {
    'QN':QN,
    'Question': Question,
    'BodyQ': BodyQ,
    'FirstQ': FirstQ,
    'SecondQ': SecondQ,
    'ThirdQ': ThirdQ,
    'ForthQ': ForthQ,
    'FifthQ': FifthQ,
  };
}
