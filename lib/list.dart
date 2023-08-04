import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_0/Database/sample.dart';
import 'timer.dart';
import 'study.dart';

/*
List<ToDo> ToDoLists(){

  list:{
    debug:{
      教科選択が正しくできてない
    }

    others:{

    }
  }
}
*/

void main() {
  runApp(SetUp());
  initializeDateFormatting('ja');
  var format = new DateFormat.yMMMd('ja');
  var date = format.format(new DateTime.now());
}

class SetUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List(Version: 3.4.2)',
      home: lists(),
      routes: <String, WidgetBuilder>{
        '/timer': (context) => TimerGetState(),
        '/study': (context) => Study(),
        '/db': (context) => SampleGetState(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class lists extends StatefulWidget {
  @override
  listsState createState() => listsState();
}

class listsState extends State<lists> {
  List<String> widgetName = [
    'Timer',
    'Study',
    'Database',
  ];
  List<String> routesName = [
    '/timer',
    '/study',
    '/db',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lists Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: widgetName.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(routesName[index]);
                    },
                    title: Text(widgetName[index]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
