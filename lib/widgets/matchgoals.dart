import 'package:flutter/material.dart';
import 'package:futsal_match_manager/main.dart';
import 'package:futsal_match_manager/widgets/playerlist.dart';
import 'package:futsal_match_manager/data.dart';

class MatchGoals extends StatefulWidget {
  const MatchGoals({super.key});

  @override
  _MatchGoalsState createState() => _MatchGoalsState();
}

class _MatchGoalsState extends State<MatchGoals> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellow,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: TextButton(
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerList(
                                playerAction: PlayerAction.localGoal,
                              )), //PANTALLA DEL PREVIO
                    );*/
                    _incrementLocalGoal();
                  },
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontFamily: "Orbitron",
                        fontStyle: FontStyle.normal,
                        fontSize: 80,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 9),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              child: TextButton(
                onPressed: () {
                  _decreaseLocalGoal();
                },
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontStyle: FontStyle.normal,
                      fontSize: 80,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          alignment: Alignment.centerLeft,
          //padding: const EdgeInsets.only(left: 8),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              MyApp.localGoal.toString().padLeft(2, '0'),
              textAlign: TextAlign.left,
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "Orbitron",
                fontStyle: FontStyle.normal,
                fontSize: 150,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
      //Expanded(child: ReportWidget([_MinorityReportText])),
      Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          alignment: Alignment.centerRight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              MyApp.guestGoal.toString().padLeft(2, '0'),
              textAlign: TextAlign.right,
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "Orbitron",
                fontStyle: FontStyle.normal,
                fontSize: 150,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellow,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: TextButton(
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerList(
                                playerAction: PlayerAction.guestGoal,
                              )),
                    );*/
                    _incrementGuestGoal();
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontStyle: FontStyle.normal,
                      fontSize: 80,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 9),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: TextButton(
                  onPressed: () {
                    _decreaseGuestGoal();
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontStyle: FontStyle.normal,
                      fontSize: 80,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  //**FUNCIONES */

  void _incrementLocalGoal() {
    setState(() {
      MyApp.localGoal++;
    });
  }

  void _decreaseLocalGoal() {
    setState(() {
      if (MyApp.localGoal > 0) {
        MyApp.localGoal--;
      }
    });
  }

  void _incrementGuestGoal() {
    setState(() {
      MyApp.guestGoal++;
    });
  }

  void _decreaseGuestGoal() {
    setState(() {
      if (MyApp.guestGoal > 0) {
        MyApp.guestGoal--;
      }
    });
  }
}
