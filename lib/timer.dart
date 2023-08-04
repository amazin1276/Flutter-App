import 'package:flutter/material.dart';
import 'dart:async';

class TimerGetState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimerState();
  }
}

class TimerState extends State<TimerGetState> {
  @override
  int millisecond = 0, second = 0, minute = 0, hour = 0;
  bool isStart = false;
  bool isReset = false;
  String timer;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: Container(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: 200,
                width: double.infinity,
                child: Text(
                  Stopwatch(),
                  style: TextStyle(fontSize: 50),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Colors.red,
                  child: Text('Stop'),
                  onPressed: isStart
                      ? () {
                          setState(() {
                            isStart = false;
                          });
                        }
                      : null,
                ),
                RaisedButton(
                    color: Colors.blue,
                    child: Text('Reset'),
                    onPressed: !isStart
                        ? () {
                            if (!(timer == '00:00:00.00')) {
                              setState(() {
                                isReset = true;
                              });
                            }
                          }
                        : null),
              ],
            ),
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.green,
                  child: Text('Start'),
                  onPressed: isStart
                      ? null
                      : () {
                          setState(() {
                            isStart = true;
                          });
                        },
                ),
              ],
            )
          ],
        ),
      ),
    ));
    // TODO: implement build
    throw UnimplementedError();
  }
}
