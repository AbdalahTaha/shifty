import 'package:flutter/material.dart';
import '../providers/shift.dart';
import 'package:intl/intl.dart';

class DailyShift extends StatelessWidget {
  final Shift shift;
  const DailyShift(this.shift, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Day#1"),
        const SizedBox(width: 30),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DateFormat('hh:mm aa').format(shift.login).toString()),
          ),
        ),
        const SizedBox(width: 40),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DateFormat('hh:mm aa').format(shift.logout).toString()),
          ),
        )
      ],
    );
  }
}
