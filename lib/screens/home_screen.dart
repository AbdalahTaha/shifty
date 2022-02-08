import 'package:flutter/material.dart';
import '../widgets/daily_shift.dart';
import '../models/shift.dart';
import '../widgets/current_shift.dart';

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
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Shifts().shifts.length,
                  itemBuilder: (context, i) => DailyShift(Shifts().shifts[i])),
            ),
            CurrentShift(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
