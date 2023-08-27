import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  final List<String> reportList;

  ReportWidget(this.reportList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 10,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: ListView.builder(
        itemCount: reportList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              reportList[index],
              style: const TextStyle(
                fontFamily: "Orbitron",
                decoration: TextDecoration.none,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
