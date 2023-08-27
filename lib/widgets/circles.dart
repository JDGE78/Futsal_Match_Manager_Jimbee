import 'package:flutter/material.dart';
import 'package:futsal_match_manager/main.dart';

class DoublePenalty extends StatefulWidget {
  @override
  _DoublePenaltyState createState() => _DoublePenaltyState();
}

class _DoublePenaltyState extends State<DoublePenalty> {
  @override
  Widget build(BuildContext context) {
    List<Widget> circulos = [];

    for (int i = 0; i < 5; i++) {
      Color color = i < MyApp.localFouls
          ? i == 4
              ? Colors.red
              : Colors.green
          : Colors.white10;

      circulos.add(
        Container(
          width: 16,
          height: 16,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      );
    }

    return Row(children: circulos);
  }
}
