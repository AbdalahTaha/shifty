import 'package:flutter/material.dart';
import '../widgets/daily_shift.dart';
import '../models/shift.dart';

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
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: Shifts().shifts.length,
              itemBuilder: (context, i) => DailyShift(Shifts().shifts[i])),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
