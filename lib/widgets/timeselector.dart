import 'package:flutter/material.dart';
import 'package:futsal_match_manager/main.dart';

class TimeSelector extends StatefulWidget {
  final int initialSeconds;

  TimeSelector({super.key, required this.initialSeconds});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = widget.initialSeconds;
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;

    return Container(
      height: MediaQuery.of(context).size.width / 30,
      width: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              onPressed: () => {_delMinutes(5)},
              child: const Icon(Icons.arrow_left_rounded,
                  size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(width: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              onPressed: () => {_addMinutes(5)},
              child: const Icon(Icons.arrow_right_rounded,
                  size: 50, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _addMinutes(int minutes) {
    setState(() {
      _seconds += minutes * 60;
      MyApp.matchMinutes += minutes;
    });
  }

  void _delMinutes(int minutes) {
    if (_seconds * 60 >= 5) {
      setState(() {
        _seconds -= minutes * 60;
        MyApp.matchMinutes -= minutes;
      });
    }
  }
}
