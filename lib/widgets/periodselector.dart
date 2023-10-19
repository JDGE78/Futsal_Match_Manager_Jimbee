import 'package:flutter/material.dart';
import 'package:futsal_match_manager/main.dart';

class PeriodSelector extends StatefulWidget {
  final int periods;

  const PeriodSelector({super.key, required this.periods});

  @override
  _PeriodSelectorState createState() {
    return _PeriodSelectorState();
  }
}

class _PeriodSelectorState extends State<PeriodSelector> {
  int _matchPeriod = MyApp.matchPeriod;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 30,
      width: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              onPressed: () => _delPeriod(),
              child: const Icon(Icons.arrow_left_rounded,
                  size: 50, color: Colors.white),
            ),
          ),
          SizedBox(
              child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$_matchPeriod',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )),
          SizedBox(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TextButton(
                onPressed: () => _addPeriod(),
                child: const Icon(Icons.arrow_right_rounded,
                    size: 50, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addPeriod() {
    setState(() {
      MyApp.matchPeriod += 1;
    });
    updateMatchPeriod();
  }

  void _delPeriod() {
    if (MyApp.matchPeriod > 1) {
      setState(() {
        MyApp.matchPeriod -= 1;
      });
      updateMatchPeriod();
    }
  }

  void updateMatchPeriod() {
    setState(() {
      _matchPeriod = MyApp.matchPeriod;
    });
  }
}
