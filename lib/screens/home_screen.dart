import 'package:flutter/material.dart';
import '../widgets/daily_shift.dart';
import '../providers/shift.dart';
import '../widgets/current_shift.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifty'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.timelapse))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<Shifts>(
              builder: (context, shifts, child) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: shifts.allShifts.length,
                      itemBuilder: (context, i) =>
                          DailyShift(shifts.allShifts[i])),
                );
              },
            ),
            CurrentShift(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
