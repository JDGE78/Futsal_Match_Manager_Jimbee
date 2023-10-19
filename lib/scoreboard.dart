import 'package:flutter/material.dart';
import 'package:futsal_match_manager/widgets/timer.dart';
import 'package:futsal_match_manager/widgets/matchgoals.dart';
import 'package:futsal_match_manager/widgets/handlescore.dart';
import 'package:futsal_match_manager/widgets/timeout.dart';
import 'package:futsal_match_manager/main.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  String localTeam = "";
  String guestTeam = "";

  int period = MyApp.period;

  @override

  Widget build(BuildContext context) {
    if (MyApp.isLocal) {
      localTeam = MyApp.teamName.toUpperCase();
      guestTeam = MyApp.rival.toUpperCase();
    } else {
      localTeam = MyApp.rival.toUpperCase();
      guestTeam = MyApp.teamName.toUpperCase();
    }
    return Column(children: [
      _topScore(),
      _centerScore(),
      const TimeOuts(),
      const MatchGoals(),
      HandleScore()
    ]);
  }

  //**WIDGETS **/
  //? BOTONES Y CUANTA ATRAS
  Widget _topScore() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return backtoMain();
              },
            );
          },
          child: const Icon(
            Icons.cancel_outlined,
            size: 40,
          ),
        ),
      ),
      const Expanded(
        flex: 6,
        child: MatchTimerButton(), // MARCADOR
      ),
      const Expanded(
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: null,/* () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return endMatch();
              },
            );
          },*/
          child: Icon(
            Icons.save,
            size: 40,
          ),
        ),
      ),
    ]);
  }

//?widgets LOCAL y VISITANTE y PERIODO
  Widget _centerScore() {
    if (MyApp.isLocal) {
      localTeam = MyApp.teamName.toUpperCase();
      guestTeam = MyApp.rival.toUpperCase();
    } else {
      localTeam = MyApp.rival.toUpperCase();
      guestTeam = MyApp.teamName.toUpperCase();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
              width: 2,
            ),
          ),
          child: Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(localTeam,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 38,
                      fontStyle: FontStyle.normal,
                      color: Colors.yellow)),
            ),
          ),
        ),

        _period(MyApp.matchPeriod),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
              width: 2,
            ),
          ),
          child: Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(guestTeam,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 38,
                      fontStyle: FontStyle.normal,
                      color: Colors.yellow)),
            ),
          ),
        ),
      ],
    );
  }

//? WIDGET PERIODO
  Widget _period(int score) {
    //updatePeriod();
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 8,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 2,
        ),
      ),
      child: Column(children: [
        const SizedBox(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'PERIODO',
              textAlign: TextAlign.end,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 12,
                color: Colors.green,
              ),
            ),
          ),
        ),
        SizedBox(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$period',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "LED",
                fontStyle: FontStyle.normal,
                fontSize: MediaQuery.of(context).size.width * 0.03, // Ajustar el tamaño en función del ancho de la pantalla
                color: Colors.greenAccent,
              ),
            ),
          ),

        ),
      ]),
    );
  }

  Widget backtoMain() {
    return AlertDialog(
      title: const Text("Advertencia"),
      content: const Text(
          "¿Seguro que desea volver a la pantalla anterior? Esto invalidaría los avances actuales."),
      actions: <Widget>[
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Sí"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget endMatch() {
    return AlertDialog(
      title: const Text("Partido finalizado"),
      content: const Text("¿Desea terminar el partido y revisar el log?"),
      actions: <Widget>[
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Sí"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  /*void updatePeriod() {
    setState(() {
      period = MyApp.period;
    });
  }*/

}
