import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Study extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudyState();
  }
}

class StudyState extends State<Study> {
  DateTime now = DateTime.now();
  DateTime _selectedDay;

// Color型　変数 ---------------------------------------------------------------
  Color themeColor = Colors.orange;
  List<Color> subjectColors = [
    Colors.red.shade300,
    Colors.blue.shade300,
    Colors.purple.shade300,
    Colors.green.shade300,
    Colors.yellow.shade300,
  ];
  List<Color> selectedSubjectColors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.purple.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
  ];

// String型　変数 --------------------------------------------------------------
  String title;
  String timer;
  String totalTimer = '00:00:00';
  List<String> timers = [
    '',
    '',
    '',
    '',
    '',
  ];
  List<String> subjectTitles = [
    '国語',
    '数学',
    '英語',
    '理科',
    '社会',
  ];

// int型　変数 -----------------------------------------------------------------
  int subjectIndex = 0;
  int selectedPage = 0;
  int selectedTab = 0;
  int millisecond = 0, second = 0, minute = 0, hour = 0;
  int ttlMillisecond = 0, ttlSecond = 0, ttlminute = 0, ttlhour = 0;
  List<int> milliseconds = [
    0,
    0,
    0,
    0,
    0,
  ];
  List<int> seconds = [
    0,
    0,
    0,
    0,
    0,
  ];
  List<int> minutes = [
    0,
    0,
    0,
    0,
    0,
  ];
  List<int> hours = [
    0,
    0,
    0,
    0,
    0,
  ];
  List<int> subjectTimers = [
    0,
    0,
    0,
    0,
    0,
  ];

// bool型　変数 ----------------------------------------------------------------
  bool isStart = false;
  bool isReset = false;
  List<bool> isSubjects = [
    false,
    false,
    false,
    false,
    false,
  ];

// Tab型　変数 -----------------------------------------------------------------
  static const List<Tab> myTabs = [
    Tab(
      text: '日間',
    ),
    Tab(
      text: '週間',
    ),
    Tab(
      text: '月間',
    ),
  ];

// String型　関数 --------------------------------------------------------------
  String GetToDayUntilMonth() {
    return '1月1日';
    // return DateFormat.MEd('ja').format(DateTime.now()).toString();
  }

  String Stopwatch() {
    String _convertTwoDigits(int number) {
      return number >= 10 ? "$number" : "0$number";
    }

    Timer(Duration(milliseconds: 1), () {
      if (isStart) {
        setState(() {
          ++millisecond;
        });
      }
    });

    if (59 < millisecond) {
      setState(() {
        ++second;
        millisecond = 0;
      });
    }
    if (59 < second) {
      setState(() {
        ++minute;
        second = 0;
      });
    }
    if (59 < minute) {
      setState(() {
        ++hour;
        minute = 0;
      });
    }

    if (isReset) {
      setState(() {
        milliseconds[subjectIndex] += millisecond;
        seconds[subjectIndex] += second;
        minutes[subjectIndex] += minute;
        hours[subjectIndex] += hour;
        ttlMillisecond += millisecond;
        ttlSecond += second;
        ttlminute += minute;
        ttlhour += hour;

        if (59 < ttlMillisecond) {
          ++ttlSecond;
          ttlMillisecond = 0;
        }
        if (59 < ttlSecond) {
          ++ttlSecond;
          ttlSecond = 0;
        }
        if (59 < ttlminute) {
          ++ttlhour;
          ttlminute = 0;
        }

        if (59 < milliseconds[subjectIndex]) {
          ++seconds[subjectIndex];
          milliseconds[subjectIndex] = 0;
        }
        if (59 < seconds[subjectIndex]) {
          ++minutes[subjectIndex];
          seconds[subjectIndex] = 0;
        }
        if (59 < minutes[subjectIndex]) {
          ++hours[subjectIndex];
          minutes[subjectIndex] = 0;
        }

        String ttlA = _convertTwoDigits(ttlhour);
        String ttlB = ':' + _convertTwoDigits(ttlminute);
        String ttlC = ':' + _convertTwoDigits(ttlSecond);
        String ttlD = '.' + _convertTwoDigits(ttlMillisecond);

        String a = _convertTwoDigits(hours[subjectIndex]);
        String b = ':' + _convertTwoDigits(minutes[subjectIndex]);
        String c = ':' + _convertTwoDigits(seconds[subjectIndex]);
        String d = '.' + _convertTwoDigits(milliseconds[subjectIndex]);

        totalTimer = a + b + c;
        timers[subjectIndex] = a + b + c;
        millisecond = 0;
        second = 0;
        minute = 0;
        hour = 0;
        isReset = false;
      });
    }

    String _millisecond = '.' + _convertTwoDigits(millisecond);
    String _second = ':' + _convertTwoDigits(second);
    String _minute = ':' + _convertTwoDigits(minute);
    String _hour = _convertTwoDigits(hour);
    setState(() {
      timer = _hour + _minute + _second + _millisecond;
    });
    return timer;
  }

// int型　関数 -----------------------------------------------------------------

// void型　関数 ----------------------------------------------------------------

/*










*/

// Widget型　変数 --------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(25),
          color: Colors.white60,
          child: SelectPage(selectedPage)),
    );
  }

  Widget ShowError(String nameOfFuncion) {
    return Container(
      height: 100,
      color: Colors.redAccent[700],
      alignment: Alignment.center,
      child: Text('You have got an error on "$nameOfFunction" funcion',
          style: TextStyle(
            color: Colors.yellow,
          )),
    );
  }

  Widget Space(String darkerOrLighter, bool isBigger) {
    final double fontSize = isBigger ? 100 : 40;

    if (darkerOrLighter == 'darker') {
      return Stack(
        children: <Widget>[
          Container(
            height: fontSize,
            color: Colors.white24,
          )
        ],
      );
    } else if (darkerOrLighter == 'lighter') {
      return Stack(
        children: <Widget>[Container(height: fontSize, color: Colors.white60)],
      );
    } else {
      return ShowError('Space');
    }
  }

  Widget GrayLine() {
    return Container(
      color: Colors.black38,
      height: 1,
      width: double.infinity,
    );
  }

  Widget SelectPage(int index) {
    setState(() {
      if (index == 0)
        return title = '記録';
      else if (index == 1) return title = 'タイマー';
    });

    if (index == 0) {
      return SafeArea(
        child: ListView(
          children: <Widget>[
            Top(),
            TopTab(),
            Calender(),
            Space('darker', false),
            GrayLine(),
            _tabBar(),
            Per(selectedTab),
          ],
        ),
      );
    } else if (index == 1) {
      return SafeArea(
          child: ListView(
        children: [
          Top(),
          TopTab(),
          WStopwatch(),
        ],
      ));
    }
    return ShowError('SelectPage');
  }

  final List<Tab> topTabs = [
    Tab(
      text: '記録',
    ),
    Tab(
      text: 'タイマー',
    ),
  ];
  Widget TopTab() {
    return Column(
      children: <Widget>[
        DefaultTabController(
          length: 2,
          child: TabBar(
            tabs: topTabs,
            indicatorColor: Colors.orange,
            labelColor: Colors.black87,
            onTap: (int index) {
              setState(() {
                selectedPage = index;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget Top() {
    return Container(
      height: 35,
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
          Text(title, style: TextStyle(fontSize: 25)),
        ],
      ),
    );
  }

  Widget Calender() {
    return Container(
      color: Colors.white24,
      child: TableCalendar<DateTime>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: now,
        calendarFormat: CalendarFormat.month,
      ),
    );
  }

  Widget _tabBar() {
    return Column(
      children: <Widget>[
        Container(
            child: DefaultTabController(
                length: myTabs.length,
                child: Ink(
                  child: TabBar(
                    onTap: (Tab) {
                      setState(() {
                        selectedTab = Tab;
                      });
                    },
                    tabs: myTabs,
                    indicatorColor: Colors.orange,
                    labelColor: Colors.black87,
                  ),
                )))
      ],
    );
  }

  List<StudyChartModel> _dayOfTheWeek;
  List<StudyChartModel> _perWeek;

  List<StudyChartModel> GetChartDataPerWeek() {
    final List<StudyChartModel> chartData = [
      StudyChartModel('月', 1),
      StudyChartModel('火', 2),
      StudyChartModel('水', 3),
      StudyChartModel('木', 4),
      StudyChartModel('金', 5),
      StudyChartModel('土', 6),
      StudyChartModel('日', 7),
    ];
    return chartData;
  }

  List<StudyChartModel> GetChartDataPer() {
    List<StudyChartModel> chartData = [
      StudyChartModel('勉強', 1),
      StudyChartModel('休憩', 2),
      StudyChartModel('その他', 3),
    ];
    return chartData;
  }

  void initState() {
    _dayOfTheWeek = GetChartDataPer();
    _perWeek = GetChartDataPerWeek();
    super.initState();
  }

  Widget Per(int _selectedTab) {
    // 日間
    if (_selectedTab == 0) {
      return PerDay();
      // 週間
    } else if (_selectedTab == 1) {
      return PerWeek();
      // 月間
    } else if (_selectedDay == 2) {
      return PerMonth();
    }
    return ShowError('Per');
  }

  Widget WSubject(int index, bool B) {
    List<String> subjects = [
      '国語',
      '数学',
      '英語',
      '理科',
      '社会',
    ];
    Widget _return() {
      if (B) {
        return Card(
          color: Colors.grey.shade200,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  color: subjectColors[index],
                  width: 70,
                  child: Text(
                    subjects[index],
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Container(
                  width: 10,
                ),
                Container(
                  child: Text(
                    timers[index],
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container(
          height: 0,
          width: 0,
        );
      }
    }

    return _return();
  }

  Widget PerDay() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Space('lighter', false),
          Text(
            GetToDayUntilMonth(),
            style: TextStyle(fontSize: 12),
          ),
          Space('lighter', false),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '合計勉強時間',
                    style: TextStyle(fontSize: 15, color: Colors.orange),
                  ),
                  Text(
                    totalTimer,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Container(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '最大集中時間',
                    style: TextStyle(fontSize: 15, color: Colors.orange),
                  ),
                  Text(
                    '00:00:00',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
          Space('lighter', false),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '開始時間',
                    style: TextStyle(fontSize: 15, color: Colors.orange),
                  ),
                  Text(
                    '00:00:00',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              Container(
                width: 75,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '終了時間',
                    style: TextStyle(fontSize: 15, color: Colors.orange),
                  ),
                  Text(
                    '00:00:00',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ],
          ),
          Container(
            height: 100,
            color: Colors.white24,
          ),
          GrayLine(),
          Space('lighter', false),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.format_align_center,
                color: themeColor,
              ),
              Text(
                '  科目別勉強量',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Space('lighter', false),
          WSubject(0, isSubjects[0]),
          WSubject(1, isSubjects[1]),
          WSubject(2, isSubjects[2]),
          WSubject(3, isSubjects[3]),
          WSubject(4, isSubjects[4]),
          Space('lighter', true),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.pie_chart_outline_rounded,
                size: 20,
                color: themeColor,
              ),
              Text(
                '  曜日別勉強時間 ',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ],
          ),
          Space('lighter', false),
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<StudyChartModel, String>(
                dataSource: _dayOfTheWeek,
                xValueMapper: (StudyChartModel data, _) => data.continent,
                yValueMapper: (StudyChartModel data, _) => data.studyInHour,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget PerWeek() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  Widget PerMonth() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }

  Widget WStopwatch() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: (!isStart &&
                                !(subjectIndex == 0) &&
                                (timer == '00:00:00.00'))
                            ? Colors.black87
                            : Colors.black54,
                      ),
                      onPressed: (!isStart &&
                              !(subjectIndex == 0) &&
                              !(timer == '00:00:00.00'))
                              
                              // True
                          ? () {
                              setState(() {
                                --subjectIndex;
                              });
                            }

                            // False
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const Text(
                                          '他の教科を選択するには"Reset"ボタンをタップしてください')));
                            }),
                  Text(
                    subjectTitles[subjectIndex],
                    style: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: (!isStart &&
                                !(subjectIndex == 4) &&
                                (timer == '00:00:00.00'))

                            // True
                            ? Colors.black87

                            // False
                            : Colors.black54,
                      ),
                      onPressed: (!isStart &&
                              !(subjectIndex == 4) &&
                              !(timer == '00:00:00.00'))

                          // True
                          ? () {
                              setState(() {
                                ++subjectIndex;
                              });
                            }

                          // False
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const Text(
                                          '他の教科を選択するには"Reset"ボタンをタップしてください。')));
                            })
                ],
              ),
            ),
          ),
          Space('lighter', true),
          Text(
            Stopwatch(),
            style: TextStyle(
                fontSize: 50, color: isStart ? Colors.black87 : Colors.black54),
          ),
          Space('lighter', true),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                color: Colors.red,
                child: Text('Stop'),
                onPressed: isStart

                    // True
                    ? () {
                        setState(() {
                          isStart = false;
                        });
                      }

                    // False
                    : null,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: Text('Reset'),
                  onPressed: !isStart

                      // True
                      ? () {
                          if (!(timer == '00:00:00.00')) {
                            setState(() {
                              isReset = true;
                              isSubjects[subjectIndex] = true;
                            });
                          }
                        }

                      // False
                      : null),
            ],
          ),
          Space('lighter', false),
          RaisedButton(
            color: Colors.green,
            child: Text('Start'),
            onPressed: isStart

                // True
                ? null

                // False
                : () {
                    setState(() {
                      isStart = true;
                      isSubjects[subjectIndex] = true;
                    });
                  },
          ),
        ],
      ),
    );
  }

// ------------------------------------------------------------- ^ widgets
}

class StudyChartModel {
  final String continent;
  final double studyInHour;
  StudyChartModel(this.continent, this.studyInHour);
}

/*
SfCartesianChart(
              series: <CartesianSeries>[
                ColumnSeries<StudyChartModel, String>(
                    dataSource: _chartData,
                    xValueMapper: (StudyChartModel studyInHour, _) =>
                        studyInHour.continent,
                    yValueMapper: (StudyChartModel studyInHour, _) =>
                        studyInHour.studyInHour)
              ],
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
            ),
   
  StudyDatabase({
    this.DBtimers,
    this.DBsubjectTimers,
    this.DBmilliseconds,
    this.DBseconds,
    this.DBminutes,
    this.DBhours,
  });
  
  Map<String, dynamic> ToMap() {}
*/
