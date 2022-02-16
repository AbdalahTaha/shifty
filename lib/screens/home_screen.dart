import 'package:flutter/cupertino.dart';
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
  final ScrollController _controller = ScrollController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String balance = context.watch<Shifts>().calculateBalance();
    Future.delayed(Duration.zero).whenComplete(
        () => _controller.jumpTo(_controller.position.maxScrollExtent));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifty'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text("reset month?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  context.read<Shifts>().resetMonth();
                                  Navigator.pop(context);
                                },
                                child: const Text("reset")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No")),
                          ],
                        ));
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: balance[0] == '+' ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(10)),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: 'Shift Balance\n',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    TextSpan(
                        text: balance,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20))
                  ])),
            ),
            Consumer<Shifts>(
              builder: (context, shifts, child) {
                return Expanded(
                    child: ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  itemCount: shifts.allShifts.length,
                  itemBuilder: (context, i) =>
                      DailyShift(shifts.allShifts[i], i),
                ));
              },
            ),
            const CurrentShift(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
