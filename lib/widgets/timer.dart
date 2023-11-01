//TEMPORIZADOR: CUENTA ATRAS

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:futsal_match_manager/main.dart';
import 'package:futsal_match_manager/data.dart';
import 'dart:io';
import 'package:futsal_match_manager/scoreboard.dart';
//import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class MatchTimerButton extends StatefulWidget {
  const MatchTimerButton({super.key});

  @override
  _MatchTimerButtonState createState() => _MatchTimerButtonState();
}

class _MatchTimerButtonState extends State<MatchTimerButton> {
  int _secondsLeft = MyApp.matchMinutes * 60;
  Timer? _timer;
  final List _MinorityReportList = MyApp.MinorityReportList;

  reset Reseteo = reset();

  @override
  Widget build(BuildContext context) {
    final isRunning = _timer == null ? false : _timer!.isActive;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        score(isRunning),
        //clockState(isRunning) WIDGET QUE MUESTRA EL PLAY O EL PAUSE.
      ],
    );
  }

//**WIDGETS DE LA CLASE**/
  Widget clockState(bool _isRunning) {
    Icon _icon;

    if (_isRunning) {
      _icon = const Icon(
        Icons.pause,
        size: 18,
        color: Colors.red,
      );
    } else {
      _icon = const Icon(
        Icons.play_arrow,
        size: 18,
        color: Colors.green,
      );
    }
    return _icon;
  }

  Widget score(bool _isRunning) {
    // Variable para rastrear si la acción está en progreso
    bool _actionInProgress = false;

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: TextButton(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            timeNormalized(_secondsLeft),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Led",
              fontStyle: FontStyle.normal,
              fontSize: 150,
              color: Colors.redAccent,
            ),
          ),
        ),
        onPressed: () {
          if (_actionInProgress) {
            return; // Evitar que la acción se ejecute mientras está en progreso
          }

          setState(() {
            // Iniciar la acción
            _actionInProgress = true;
          });

          // Realiza la acción (por ejemplo, inicia o detiene un temporizador)
          if (_isRunning) {
            // Detener la acción
            stopTimer();
          } else {
            // Iniciar la acción
            startTimer();
          }

          setState(() {
            // La acción ha terminado, habilitar el botón nuevamente
            _actionInProgress = false;
          });
        },
      ),
    );
  }

//**FUNCIONES**/
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
          MyApp.timeReport =
              timeNormalized(_secondsLeft); //ACTUALIZO TIEMPO PARA REPORTE
        });
      } else {
        stopTimer();
        resetPeriod();
      }
    });
  }

  void stopTimer() {
    setState(() => _timer?.cancel());
  }

  String timeNormalized(int oldSeconds) {
    int min = oldSeconds ~/ 60;
    int sec = oldSeconds % 60;

    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

//?CUANDO ACABA UN PERIODO, SE RESETEA DOBLESPENALTIS y TIEMPO
  void resetPeriod() {
    String? txt;
    String? txtContent;

    //if (MyApp.matchPeriod == 1) {
    if (MyApp.matchPeriod == (MyApp.period)){
      txt = "FIN DE PARTIDO";
      txtContent = "";
      MyApp.endMatch = true;
    } else {
      txt = "FIN DE PERIODO";
      txtContent = "La pantalla se restablecerá";
    }
    _MinorityReportList.add(txt);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(txt!),
            content: Text(txtContent!),
            icon: const Icon(Icons.timer_off, size: 50, color: Colors.red));
      },
    );
//PARA PRUEBAS SE PONE EN MILLISECONDS
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //MyApp.matchPeriod--;
        MyApp.period++;
        MyApp.localFouls = 0;
        MyApp.guestFouls = 0;
        MyApp.localTimeOut = false;
        MyApp.guestTimeOut = false;
        MyApp.timeReport = "";
        _secondsLeft = MyApp.matchMinutes * 60;
///AQUI::CUANDO ACABE EL PARTIDO SE QUEDA TAL CUAL...A LA ESPERA DE QUITAR MANUALMENTE EL CRONO
        if( MyApp.endMatch == true) {
          //savePDF(_MinorityReportList); //V1
         /* Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Reseteo;*/
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
          //QUITADOS LOS 3. PORQUE CUANDO ACABA EL PARTIDO, SE QUEDA LA PANTALLA HASTA QUE PULSES BOTON ROJO
        }
        else{
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScoreBoard()),
          );
        }
       /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyApp.endMatch ? const Report() : const ScoreBoard()));*/
      });
    });
  }

  Future<void> savePDF(List<dynamic> _MinorityReportList) async {
    final pdf = pw.Document();

    // Formatear la fecha actual como año-mes-dia
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd');
    final formattedDate = formatter.format(now);

    // Nombre del archivo PDF con formato año-mes-dia.pdf
    final fileName = '$formattedDate.pdf';

    // Agregar el contenido del List<dynamic> al PDF
    for (final item in _MinorityReportList) {
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Text('$item'),
        ),
      );
    }

    // Guardar el PDF en el directorio de documentos del dispositivo
    final output = await getDownloadsDirectory();
    final file = File('$output/$fileName');
    await file.writeAsBytes(await pdf.save());
  }
}
