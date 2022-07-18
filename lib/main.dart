import 'package:flutter/material.dart';

String convertToTwoDigitString(int value) {
  if (value < 10) {
    return "0$value";
  } else {
    return value.toString();
  }
}

class StopWatchDisplay extends StatelessWidget {
  const StopWatchDisplay(
      {required this.hours,
      required this.minutes,
      required this.seconds,
      super.key});

  final int hours;
  final int minutes;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    var hourString = convertToTwoDigitString(hours);
    var minuteString = convertToTwoDigitString(minutes);
    var secondString = convertToTwoDigitString(seconds);
    var displayString = "$hourString:$minuteString:$secondString";
    return Text(displayString, style: const TextStyle(fontSize: 64.0));
  }
}

class StopWatchDisplayAllTimes extends StatelessWidget {
  const StopWatchDisplayAllTimes(
      {required this.allTimes, super.key});

  final List allTimes;

  @override
  Widget build(BuildContext context) {
    var displayString = "";
    for (var i=0;i<allTimes.length;i++){
      var timeList = allTimes[i];
      var hours = timeList[0];
      var minutes = timeList[1];
      var seconds = timeList[2];
      var hourString = convertToTwoDigitString(hours);
      var minuteString = convertToTwoDigitString(minutes);
      var secondString = convertToTwoDigitString(seconds);
      displayString = displayString + "Time ${i+1}=     $hourString:$minuteString:$secondString\n";
    }

    return Text(displayString, style: const TextStyle(fontSize: 64.0));
  }
}

class StopWatchPause extends StatelessWidget {
  const StopWatchPause({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.lightGreen,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.pause,
        size: 35.0,
      ),
    );
  }
}

class StopWatchStart extends StatelessWidget {
  const StopWatchStart({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.lightGreen,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.play_arrow,
        size: 35.0,
      ),
    );
  }
}

class StopWatchStop extends StatelessWidget {
  const StopWatchStop({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.lightGreen,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.stop_sharp,
        size: 35.0,
      ),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  final allTimes = [];
  final Stopwatch _stopWatch = Stopwatch();

  void _startStopWatch() {
    _stopWatch.start();
  }

  void _pauseStopWatch() {
    setState(() {
      var totalSeconds = _stopWatch.elapsedMilliseconds ~/ 1000;
      var totalMinutes = totalSeconds ~/ 60;
      var totalHours = totalMinutes ~/ 60;
      _hours = totalHours;
      _minutes = totalMinutes - (totalHours * 60);
      _seconds = totalSeconds - (totalMinutes * 60);
      _stopWatch.stop();
    });
  }

  void _stopStopWatch() {
    setState(() {
      var totalSeconds = _stopWatch.elapsedMilliseconds ~/ 1000;
      var totalMinutes = totalSeconds ~/ 60;
      var totalHours = totalMinutes ~/ 60;
      _hours = totalHours;
      _minutes = totalMinutes - (totalHours * 60);
      _seconds = totalSeconds - (totalMinutes * 60);
      allTimes.add([_hours, _minutes, _seconds]);
      _stopWatch.reset();
      _hours = _minutes = _seconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          const SizedBox(width: 40),
          StopWatchDisplay(hours: _hours, minutes: _minutes, seconds: _seconds),
          StopWatchStart(onPressed: _startStopWatch),
          StopWatchPause(onPressed: _pauseStopWatch),
          StopWatchStop(onPressed: _stopStopWatch),
          ]
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          const SizedBox(width: 40),
          StopWatchDisplayAllTimes(allTimes: allTimes)
        ]
        )
      ],
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Stop Watch Application'),
        ),
        body: const Center(
          child: StopWatch(),
        ),
      ),
    ),
  );
}
