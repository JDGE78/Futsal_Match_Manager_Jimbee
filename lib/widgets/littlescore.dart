import 'package:flutter/material.dart';

class LittleScore extends StatefulWidget {
  const LittleScore({super.key});

  @override
  _LittleScoreState createState() => _LittleScoreState();
}

class _LittleScoreState extends State<LittleScore> {
  @override
  Widget build(BuildContext context) {
    return const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      /*_littleScore('FALTAS', localFouls),
      _littleScore('TIMEOUT', localTimeOut),
      SizedBox(
        width: MediaQuery.of(context).size.width / 30,
      ),
      _littleScore('FALTAS', guestFouls),
      _littleScore('TIMEOUT', guestTimeOut),*/
    ]);
  }

  //**WIDGETS */
}
