import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayCalendar extends StatelessWidget {
  const DayCalendar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 90,
        //width: MediaQuery.of(context).size.width * 0.90,
        child: Card(
          shadowColor: Colors.red,
          elevation: 10,
          color: Colors.redAccent,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'próximo partido',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today, size: 50),
                  //Expanded(
                  Text(
                    getDate(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDate() {
    return DateFormat("d 'de' MMMM 'de' yyyy").format(DateTime.now());
  }
}
