import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerApp extends StatefulWidget {
  @override
  _CountdownTimerAppState createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  Timer timer;
  var minute = 0;
  var seconds = 0;
  int totalTime;

  void startTimer() {
    final oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      totalTime = minute * 60 + seconds;
      setState(() {
        if (totalTime < 1) {
          timer.cancel();
        } else {
          if (seconds == 0) minute -= 1;
          totalTime -= 1;
          seconds = (totalTime % 60);
        }
      });
    });
  }

  void setSeconds(value) {
    setState(() {
      seconds = value;
    });
  }

  void setMinutes(value) {
    setState(() {
      minute = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.deepPurple),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Countdown Timer'),
        ),
        body: Center(
          child: Text(
            '$minute:$seconds',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              child: SimpleDialog(
                contentPadding: EdgeInsets.all(15),
                children: [
                  Text('Set your time'),
                  DropdownButton<int>(
                    value: minute,
                    icon: Text('Minute'),
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString()),
                      );
                    }),
                    onChanged: setMinutes,
                  ),
                  DropdownButton<int>(
                    value: seconds,
                    icon: Text('Seconds'),
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString()),
                      );
                    }),
                    onChanged: setSeconds,
                  ),
                  SizedBox(height: 15),
                  OutlinedButton(
                    child: Text('Start'),
                    onPressed: () {
                      startTimer();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          },
          child: Icon(Icons.alarm_add_outlined),
        ),
      ),
    );
  }
}
