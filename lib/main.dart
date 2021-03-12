import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo sqlite quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 1;
 //DBHelper 클래스 가져오기
  DBHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = new DBHelper();
  }

/*
  //다음 버튼을 통해 다음 문제로 넘어갈 수 있도록 Count 할 것. 이 때 _index 의 최대 숫자가 문제 갯수를 넘지 않도록 한다.
  void _incrementCounter() {
    setState(() {

      if (_index > 0 && _index <
          ) {
        _index++;
      } else {
        print('마지막 문제입니다.');
      }
    });
  }

  //이전 버튼을 통해 이전 문제로 넘어갈 수 있도록 Count.
  void _decrementCounter() {
    setState(() {
      if (_index > 0 && _index < quizcount
      ) {
        _index--;
      } else {
        print('첫번째 문제입니다.');
      }
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),

        //문제 갯수 만큼 페이지 인덱스를 만든다
        //문제, <보기>, 선지(1,2,3,4,5) 를 한 화면에 띄운다.
        //문제를 풀 때마다 다음 페이지로 넘어간다.
        //다음 페이지가 없으면 최종 제출 버튼을 누른다.
        body: Center(
          child: ListView(
            children: <Widget>[
              //페이지 번호랑 문제는 붙여서 나옴.
              Row(
                children: [
                  //페이지 번호
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '$_index',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),

                  //문제
                  Expanded(
                    child: FutureBuilder(
                        future: _dbHelper.queryQuestion(),
                        builder: (context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          return Text(
                            '${snapshot.data}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1, // 문제 내용. 예를 들어 $question
                          );
                        }),
                  ),
                ],
              ),

              //보기섹션
              Center(
                child: Text(
                  '<보기>',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: FutureBuilder(
                    future: _dbHelper.queryBodyQ(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      return Text('${snapshot.data}');
                    }),
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
              ),

              //선지 섹션
              Row(
                children: [
                  TextButton(
                    child: Text(
                      '①',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      print('1번 선지 선택');
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FutureBuilder(
                          future: _dbHelper.queryFirstQ(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                            return Text('${snapshot.data}');
                          }),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  TextButton(
                    child: Text(
                      '②',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      print('2번 선지 선택');
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FutureBuilder(
                          future: _dbHelper.querySecondQ(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                            return Text('${snapshot.data}');
                          }),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  TextButton(
                    child: Text(
                      '③',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      print('3번 선지 선택');
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FutureBuilder(
                          future: _dbHelper.queryThirdQ(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                            return Text('${snapshot.data}');
                          }),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  TextButton(
                    child: Text(
                      '④',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      print('4번 선지 선택');
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FutureBuilder(
                          future: _dbHelper.queryForthQ(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                            return Text('${snapshot.data}');
                          }),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  TextButton(
                    child: Text(
                      '⑤',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      print('5번 선지 선택');
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FutureBuilder(
                          future: _dbHelper.queryFifthQ(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                            return Text('${snapshot.data}');
                          }),
                    ),
                  ) //예를 들면 $first_q
                ],
              ),

              //다음 / 이전 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    child: Text('이전 문제'),
                    onPressed: () {
                      _index--;
                      print(_index);
                    },
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _index++;
                        print(_index);
                      },
                      child: Text('다음 문제'))
                ],
              ),
            ],
          ),
        ));
  }
}
