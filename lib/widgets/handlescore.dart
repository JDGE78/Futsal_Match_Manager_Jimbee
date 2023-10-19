//? CLASE DE CONTROL DE FALTAS Y TIMEOUTS, CON SUMATORIO

import 'package:flutter/material.dart';
import 'package:futsal_match_manager/data.dart';
import 'package:futsal_match_manager/main.dart';
//import 'package:futsal_match_manager/widgets/playerlist.dart';

class HandleScore extends StatefulWidget {
  @override
  _HandleScoreState createState() => _HandleScoreState();
}

class _HandleScoreState extends State<HandleScore> {
  int _localYellowsCards = MyApp.localYellowsCards;
  int _localRedCards = MyApp.localRedCards;
  int _guestYellowsCards = MyApp.guestYellowsCards;
  int _guestRedCards = MyApp.guestRedCards;
//* PARA INFORME DE EVENTOS
  final List _MinorityReportList = MyApp.MinorityReportList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _handleScore('FALTAS', 'localFouls', MyApp.localFouls),
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: _handleLocalCards(),
        ),
        _handleGuestCards(),
        _handleScore('FALTAS', 'guestFouls', MyApp.guestFouls),
      ]),
    );
  }

  //**WIDGETS */

//? WINDGET SUMATORIO, INCLUYE EL MARCADOR
  Widget _handleScore(String txt, String posVar, int score) {
    return Container(
      width: MediaQuery.of(context).size.width / 4.2,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 26,
            height: MediaQuery.of(context).size.height / 10,
            child: FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                onPressed: () {
                  _decrease(posVar);
                },
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontStyle: FontStyle.normal,
                      fontSize: 50,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FittedBox(
            child: Column(
              children: [_littleScore(txt, score, false)],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 24,
            height: MediaQuery.of(context).size.height / 10,
            child: TextButton(
              onPressed: () {
                _increment(posVar);
              },
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "+",
                  style: TextStyle(
                    fontFamily: "Orbitron",
                    fontStyle: FontStyle.normal,
                    fontSize: 50,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// ? WIDGET PEQUEÑO MARCADOR DE FALTAS Y TIMEOUT, UNICAMENTE TEXTOS
  Widget _littleScore(String txt, int score, bool showScore) {
    //**SHOWCASE MUESTRA O NO EL Nº DE FALTAS */
    return Column(children: [
      showScore
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                txt,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  color: Colors.yellow,
                ),
              ),
            )
          : _double_Penalty(score)
    ]);
  }

//?WIDGET 5 LEDS PARA DOBLES PENALYS
  Widget _double_Penalty(int foul) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (var i = 1; i <= 5; i++)
        Container(
          margin: const EdgeInsets.fromLTRB(8,0,0,0),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: foul == 5
                ? Colors.red
                : i <= foul
                    ? Colors.green
                    : Colors.white12,
            shape: BoxShape.circle,
          ),
        ),
    ]);
  }

  Widget _handleLocalCards() {
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: TextButton(
                onPressed: ()  {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerList(
                              playerAction: PlayerAction.localYellow,
                            )), //PANTALLA DEL PREVIO
                  );*/
                  _increment("localYellowsCards");
                },
                onLongPress: () {
                  _decrease("localYellowsCards");
                },
                child: Image.asset('assets/images/tarjetaamarilla.png',
                    height: 50),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$_localYellowsCards',
                style: const TextStyle(
                  fontFamily: "Orbitron",
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
            ),
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                ' | ',
                style: TextStyle(
                  fontFamily: "Orbitron",
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$_localRedCards',
                style: const TextStyle(
                  fontFamily: "Orbitron",
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: TextButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerList(
                              playerAction: PlayerAction.localRed,
                            )), //PANTALLA DEL PREVIO
                  );*/
                  _increment("localRedCards");
                },
                onLongPress: () {
                  _decrease("localRedCards");
                },
                child: Image.asset('assets/images/tarjetaroja.png', height: 50),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _handleGuestCards() {
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: TextButton(
                onPressed: () {
                  /*()Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerList(
                              playerAction: PlayerAction.guestYellow,
                            )), //PANTALLA DEL PREVIO
                  );*/
                  _increment("guestYellowsCards");
                },
                onLongPress: () {
                  _decrease("guestYellowsCards");
                },
                child: Image.asset('assets/images/tarjetaamarilla.png',
                    height: 50),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$_guestYellowsCards',
                style: const TextStyle(
                  fontFamily: "Orbitron",
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
            ),
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                ' | ',
                style: TextStyle(
                  fontFamily: "Orbitron",
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$_guestRedCards',
                style: const TextStyle(
                  fontFamily: "Orbitron",
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: TextButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerList(
                              playerAction: PlayerAction.guestRed,
                            )), //PANTALLA DEL PREVIO
                  );*/
                  _increment("guestRedCards");
                },
                onLongPress: () {
                  _decrease("guestRedCards");
                },
                child: Image.asset('assets/images/tarjetaroja.png', height: 50),
              ),
            ),
          ]),
        ],
      ),
    );
  }

//**FUNCIONES */
//**FALTAS */
  void _increment(String posVar) {
    setState(() {
      switch (posVar) {
        case "localFouls":
          if (MyApp.localFouls < 5) {
            MyApp.localFouls++;
            /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerList(
                        playerAction: PlayerAction.localFoul,
                      )),
            );*/
            if (MyApp.localFouls == 5) {
              _MinorityReportList.add(generateAction(PlayerAction.localDouble,
                  MyApp.timeReport, 0, MyApp.rival, true));
            }
          }
          break;
        case "guestFouls":
          if (MyApp.guestFouls < 5) {
            MyApp.guestFouls++;
            /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerList(
                        playerAction: PlayerAction.guestFoul,
                      )),
            );*/
            if (MyApp.guestFouls == 5) {
              _MinorityReportList.add(generateAction(PlayerAction.guestDouble,
                  MyApp.timeReport, 0, MyApp.teamName, true));
            }
          }
          break;

        case "localYellowsCards":
          MyApp.localYellowsCards++;
          break;
        case "localRedCards":
          MyApp.localRedCards++;
          break;

        case "guestYellowsCards":
          MyApp.guestYellowsCards++;
          break;
        case "guestRedCards":
          MyApp.guestRedCards++;
          break;
      }
    });
    updateData();
  }

  void _decrease(String posVar) {
    setState(() {
      switch (posVar) {
        case "localFouls":
          if (MyApp.localFouls > 0) {
            MyApp.localFouls--;
          }
          break;
        case "guestFouls":
          if (MyApp.guestFouls > 0) {
            MyApp.guestFouls--;
          }
          break;
//TARJETAS LOCAL
        case "localYellowsCards":
          if (MyApp.localYellowsCards > 0) {
            MyApp.localYellowsCards--;
          }
          break;
        case "localRedCards":
          if (MyApp.localRedCards > 0) {
            MyApp.localRedCards--;
          }
          break;
//TARJETAS GUEST
        case "guestYellowsCards":
          if (MyApp.guestYellowsCards > 0) {
            MyApp.guestYellowsCards--;
          }
          break;
        case "guestRedCards":
          if (MyApp.guestRedCards > 0) {
            MyApp.guestRedCards--;
          }
          break;

      }
    });
    updateData();
  }

  void updateData() {
    setState(() {
      _localYellowsCards = MyApp.localYellowsCards;
      _localRedCards = MyApp.localRedCards;
      _guestYellowsCards = MyApp.guestYellowsCards;
      _guestRedCards = MyApp.guestRedCards;
      //_MinorityReportList = MyApp.MinorityReportList;
    });
  }
}
