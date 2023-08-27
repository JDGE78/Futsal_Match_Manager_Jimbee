/// PANTALLA DE SELECCIÓN ENTRE LOCAL O VISITANTE,
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:futsal_match_manager/widgets/timeselector.dart';
import 'package:futsal_match_manager/widgets/periodselector.dart';
import 'package:futsal_match_manager/widgets/sideselector.dart';
import 'main.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _rivalController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  final placeFocusNode = FocusNode();
  final rivalFocusNode = FocusNode();
  final timeFocusNode = FocusNode();

  late TimeOfDay _time;
  DateTime now = DateTime.now();

  var tempTime, tempMinutes;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _time = TimeOfDay.now();
    //MyApp.matchTime = getDate();
    _timeController.text = MyApp.matchTime;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        shadowColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.04,
        backgroundColor: Colors.black26,
        centerTitle: true,
        title: const SizedBox(
          height: 12,
          child: Text(
            "Previa del partido",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),*/ //quitado por error de tamaño de pantalla
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fondo.jpg'),
              alignment: Alignment.center,
              opacity: 0.1,
              fit: BoxFit.cover),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(178, 166, 14, 14),
              Color.fromARGB(255, 166, 14, 14),
              Colors.white
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      MyApp.matchTime,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 30,
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
            ), // FECHA
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: SizedBox(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Rival',
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
                ),
                Container(
                  height: MediaQuery.of(context).size.width / 30,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    focusNode: rivalFocusNode,
                    controller: _rivalController,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        EnableDismissible();
                        MyApp.rival = value;
                      });
                    },
                     // Bloquea el texto en mayúsculas
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Nombre del equipo',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ), //NOMBRE DEL RIVAL
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Lugar del partido  ',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 20,
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
                Container(
                  height: MediaQuery.of(context).size.width / 30,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    focusNode: placeFocusNode,
                    controller: _placeController,
                    onChanged: (value) {
                      setState(() {
                        EnableDismissible();
                        MyApp.matchPlace = value;
                        if (!placeFocusNode.hasFocus) {
                          // Ocultar el teclado si no tiene el foco
                          FocusScope.of(context).unfocus();
                        }
                      });
                    },
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese el lugar',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Hora',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 20,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 30,
                    width: MediaQuery.of(context).size.width / 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        _time = (await showTimePicker(
                          context: context,
                          initialTime: _time,
                        ))!;

                        _timeController.text = _time.format(context);
                        MyApp.matchHour = _timeController.text;
                        EnableDismissible();
                        if (!timeFocusNode.hasFocus) {
                          // Ocultar el teclado si no tiene el foco
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          focusNode: timeFocusNode,
                          enabled: false,
                          textAlign: TextAlign.center,
                          controller: _timeController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: SizedBox(
                    child: Text(
                      'Númerio de periodos',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 20,
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
                PeriodSelector(periods: 2),
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: SizedBox(
                    child: Text(
                      'Duración del periodo',
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
                TimeSelector(initialSeconds: (MyApp.matchMinutes * 60)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EnableDismissible() ? SideSelector() : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

//**FUNCIONES */
//?SI ESTÁN TODOS LOS CAMPOS CON DATA, APARECE EL DISMISSIBLE
  bool EnableDismissible() {
    if (_placeController.text.isNotEmpty &&
        _rivalController.text.isNotEmpty &&
        _timeController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String getDate() {
    return DateFormat("dd 'de' MMMM 'de' y", "es_ES").format(DateTime.now());
  }

}
