import 'dart:io';
import 'package:flutter/services.dart';
import 'sample_quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//문제, <보기>, 선지(1,2,3,4,5) 를 한 화면에 띄운다.
//DB 행 : 문제번호, 보기, 선지1, 2, 3, 4, 5

//데이터베이스
class DBHelper {
  static final String tablename = 'Sample_Quiz';

  DBHelper._();

  static final DBHelper instance = DBHelper._();

  factory DBHelper() => instance;
  static Database _database;


  // _database 의 값이 비어있지 않으면 _database 값을 반환
  // _database 의 값이 비어있으면 initDB 클라스에서 값을 받아 데이터 반환
  // Database 에 반환된 값을 저장
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  //데이터베이스 초기화
  initDB() async {
    //getApplicationDocumentsDirectory() : 적당한 위치에 경로 생성
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'sample_quiz.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      ByteData data = await rootBundle.load('assets/sample_quiz.db');
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
      //await db.execute(
      //    'CREATE TABLE $tablename (QN INTEGER PRIMARY KEY, Question TEXT, BodyQ TEXT, FirstQ TEXT, SecondQ TEXT, ThirdQ TEXT, ForthQ TEXT, FifthQ TEXT)');
    });
  }

  //return value is the QN(question number) of the inserted row.
  //문제 번호 파악
  Future<int> insert(Map<String, dynamic> column) async {
    Database db = await instance.database;
    return await db.insert(tablename, column);
  }

  //All of the rows are returned as a list of maps, each map is a key-value list of columns
  //표의 한 줄씩 List 로 얻음.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tablename);
  }

  //문제 번호가 1번인 줄 빼오기
  Future<int> update(Map<String, dynamic> column) async {
    Database db = await instance.database;
    // ignore: non_constant_identifier_names
    int QN = column['QN'];
    return await db.update(tablename, column, where: '$QN = ?', whereArgs: [QN]);
  }

  //Future 로 선택하기. Question 선택
  Future<List<Map<String, dynamic>>> queryQuestion() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT Question FROM $tablename WHERE QN = ?', [1]);
  }

  // 보기
  Future<List<Map<String, dynamic>>> queryBodyQ() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT BodyQ FROM $tablename WHERE QN = ?', [1]);
  }

  //1번 선지
  Future<List<Map<String, dynamic>>> queryFirstQ() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT FirstQ FROM $tablename WHERE QN = ?', [1]);
  }
  //2번선지
  Future<List<Map<String, dynamic>>> querySecondQ() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT SecondQ FROM $tablename WHERE QN = ?', [1]);
  }
  //3번 선지
  Future<List<Map<String, dynamic>>> queryThirdQ() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT ThirdQ FROM $tablename WHERE QN = ?', [1]);
  }
  //4번 선지
  Future<List<Map<String, dynamic>>> queryForthQ() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT ForthQ FROM $tablename WHERE QN = ?', [1]);
  }
  //5번 선지
  Future<List<Map<String, dynamic>>> queryFifthQ() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT FifthQ FROM $tablename WHERE QN = ?', [1]);
  }


  //Create
  createData(SampleQuiz quiz) async {
    final db = await database;
    var res = await db.insert(tablename, quiz.toJson());
    return res;
  }

  //read
  // ignore: non_constant_identifier_names
  getQuiz(int QN) async {
    final db = await database;
    var res = await db.query(tablename, where: 'QN = ?', whereArgs: [QN]);
    return res.isNotEmpty ? SampleQuiz.fromJson(res.first) : Null;
  }

  //한 cell 만 선택해보자
  getQuestion() async {
    final db = await database;
    var res = await db
        .query('SELECT BodyQ FROM sample_quiz WHERE QN=?', whereArgs: [3]);
    return res.isNotEmpty ? true : false;
  }

  // READ ALL DATA
  getAllQuiz() async {
    final db = await database;
    var res = await db.query(tablename);
    List<SampleQuiz> list =
        res.isNotEmpty ? res.map((c) => SampleQuiz.fromJson(c)).toList() : [];
    return list;
  }

// Update Quiz
  updateQuiz(SampleQuiz quiz) async {
    final db = await database;
    var res = await db.update(tablename, quiz.toJson(),
        where: 'QN = ?', whereArgs: [quiz.QN]);
    return res;
  }

// Delete Quiz
  // ignore: non_constant_identifier_names
  deleteQuiz(int QN) async {
    final db = await database;
    db.delete(tablename, where: 'QN = ?', whereArgs: [QN]);
  }

// Delete All Todos
  deleteAllTodos() async {
    final db = await database;
    db.rawDelete('Delete from $tablename');
  }

  //행 갯수 세기
  Future getCount() async {
    var db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tablename'));
  }
}
