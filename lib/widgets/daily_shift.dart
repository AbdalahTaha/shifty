import 'package:flutter/material.dart';
import '../providers/shift.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyShift extends StatelessWidget {
  final Shift shift;
  final int index;
  const DailyShift(this.shift, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Day#${(index + 1).toString().padLeft(2, "0")}"),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DateFormat('hh:mm aa')
                .format(DateTime.parse(shift.login))
                .toString()),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DateFormat('hh:mm aa')
                .format(DateTime.parse(shift.logout))
                .toString()),
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("Delete Shift?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              context.read<Shifts>().deleteShift(shift);
                              Navigator.pop(context);
                            },
                            child: const Text("Delete")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                      ],
                    ));
          },
          icon: const Icon(Icons.delete),
        )
      ],
    );
  }
}
