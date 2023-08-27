import 'package:flutter/material.dart';
import 'package:futsal_match_manager/data.dart';
import 'package:futsal_match_manager/main.dart';
import 'package:futsal_match_manager/scoreboard.dart';

class SideSelector extends StatefulWidget {
  const SideSelector({super.key});

  @override
  _SideSelectorState createState() => _SideSelectorState();
}

class _SideSelectorState extends State<SideSelector> {
  final List _MinorityReportList = MyApp.MinorityReportList;


  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        children: [
          FittedBox(child: Image.asset('assets/images/local.png', height: 150)),
          const SizedBox(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'LOCAL',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 24,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(64.0),
        child: Dismissible(
          key: const Key('side'),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              MyApp.isLocal = true;
            } else if (direction == DismissDirection.startToEnd) {
              MyApp.isLocal = false;
            }
            addHeaderReport();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ScoreBoard()), //PANTALLA DEL PREVIO
            );
          },
          child: Expanded(
            child: SizedBox(
              //color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max, // Hace que el Row tome todo el espacio vertical disponible
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_left_rounded,
                      size: 50, color: Colors.white),
                  Image.asset('assets/images/logoteam.png',
                      width: 80, height: 80),
                  const Icon(Icons.arrow_right_rounded,
                      size: 50, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
      Column(
        children: [
          Image.asset('assets/images/visitante.png', height: 150),
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'VISITANTE',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 24,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  void addHeaderReport() {
    _MinorityReportList.add(
        'Informe de ${MyApp.teamName} contra ${MyApp.rival}');
    _MinorityReportList.add('Fecha:  ${MyApp.matchTime}');
    _MinorityReportList.add('Lugar:  ${MyApp.matchPlace}');
    _MinorityReportList.add('Hora del partido: ${MyApp.matchHour}');
    _MinorityReportList.add(MyApp.isLocal ? 'Local' : 'Visitante');
    _MinorityReportList.add('_____________________________________');
  }
}
