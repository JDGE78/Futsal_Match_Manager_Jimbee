import 'package:flutter/material.dart';
import 'package:futsal_match_manager/main.dart';

class TimeOuts extends StatefulWidget {
  const TimeOuts({super.key});

  @override
  _TimeOutsState createState() => _TimeOutsState();
}

class _TimeOutsState extends State<TimeOuts> {
  final List _MinorityReportList = MyApp.MinorityReportList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _handleLocalTimeOut(MyApp.localTimeOut),
        _handleGuestTimeOut(MyApp.guestTimeOut),
      ]),
    );
  }

  //**WIDGETS */

//? WINDGET SUMATORIO, INCLUYE EL MARCADOR
  Widget _handleLocalTimeOut(bool _timeOut) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      //height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: SizedBox(
            child: TextButton(
              onPressed: () {
                setState(() {
                  MyApp.localTimeOut = true;
                  _MinorityReportList.add(
                      '${MyApp.timeReport} - TIEMPO MUERTO de ${MyApp.teamName}');
                });
              },
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "TIMEOUT",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _timeOut ? Colors.green : Colors.white12,
          ),
        ),
      ]),
    );
  }

  Widget _handleGuestTimeOut(bool _timeOut) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      //height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _timeOut ? Colors.green : Colors.white12,
            ),
          ),
        ),
        SizedBox(
          child: TextButton(
            onPressed: () {
              setState(() {
                MyApp.guestTimeOut = true;
                _MinorityReportList.add(
                    '${MyApp.timeReport} - TIEMPO MUERTO de ${MyApp.rival}');
              });
            },
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "TIMEOUT",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  //**FUNCIONES */

  void _localTimeOut() {
    setState(() {
      MyApp.localTimeOut == true;
    });
  }

  void _guestTimeOut() {
    setState(() {
      MyApp.guestTimeOut == true;
    });
  }
}
