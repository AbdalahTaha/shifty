import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../providers/shift.dart';
import 'package:provider/provider.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class CurrentShift extends StatefulWidget {
  const CurrentShift({Key? key}) : super(key: key);

  @override
  _CurrentShiftState createState() => _CurrentShiftState();
}

class _CurrentShiftState extends State<CurrentShift> {
  DateTime? currentLogIn;
  DateTime? currentLogOut;
  Color logInHighlight = Colors.transparent;
  Color logOutHighlight = Colors.transparent;
  @override
  void initState() {
    checkSharedPref();
    super.initState();
  }

  void checkSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final String? logIn = prefs.getString('currentLogIn');
    final String? logOut = prefs.getString('currentLogOut');
    if (prefs.getString('currentLogIn') == null) {
      setState(() {
        logInHighlight = Colors.lightBlueAccent;
        logOutHighlight = Colors.transparent;
      });
    } else {
      setState(() {
        currentLogIn = DateTime.parse(prefs.getString('currentLogIn')!);
        logOutHighlight = Colors.lightBlueAccent;
        logInHighlight = Colors.transparent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text('LogIn '),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      logInHighlight = Colors.lightBlueAccent;
                      logOutHighlight = Colors.transparent;
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          DateTime _dateTime = DateTime.now();
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close)),
                                ),
                                TimePickerSpinner(
                                  is24HourMode: false,
                                  normalTextStyle: const TextStyle(
                                      fontSize: 24, color: Colors.white38),
                                  highlightedTextStyle: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                  spacing: 50,
                                  itemHeight: 60,
                                  isForce2Digits: true,
                                  onTimeChange: (time) {
                                    _dateTime = time;
                                  },
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString('currentLogIn',
                                          _dateTime.toIso8601String());
                                      setState(() {
                                        currentLogIn = _dateTime;
                                      });
                                      checkSharedPref();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save')),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    child: Center(
                      child: Text(currentLogIn == null
                          ? ""
                          : DateFormat('hh:mm aa')
                              .format(currentLogIn!)
                              .toString()),
                    ),
                    constraints: const BoxConstraints(minHeight: 30),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(color: logInHighlight)),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const Text('LogOut '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: currentLogIn == null
                        ? null
                        : () {
                            setState(() {
                              logInHighlight = Colors.transparent;
                              logOutHighlight = Colors.lightBlueAccent;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  DateTime _dateTime = DateTime.now();
                                  return Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close)),
                                        ),
                                        TimePickerSpinner(
                                          is24HourMode: false,
                                          normalTextStyle: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white38),
                                          highlightedTextStyle: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                          spacing: 50,
                                          itemHeight: 60,
                                          isForce2Digits: true,
                                          onTimeChange: (time) {
                                            _dateTime = time;
                                          },
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              checkSharedPref();
                                              context
                                                  .read<Shifts>()
                                                  .addShift(Shift(
                                                    currentLogIn!
                                                        .toIso8601String(),
                                                    _dateTime.toIso8601String(),
                                                  ));
                                              prefs.clear();
                                              setState(() {
                                                currentLogIn = null;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Save')),
                                      ],
                                    ),
                                  );
                                });
                          },
                    child: Container(
                      child: Center(
                        child: Text(currentLogOut == null
                            ? ""
                            : DateFormat('hh:mm aa')
                                .format(currentLogOut!)
                                .toString()),
                      ),
                      constraints: const BoxConstraints(minHeight: 30),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          border: Border.all(color: logOutHighlight)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              onLongPress: () async {
                final prefs = await SharedPreferences.getInstance();
                if (currentLogIn == null) {
                  prefs.setString(
                      'currentLogIn', DateTime.now().toIso8601String());
                  setState(() {
                    currentLogIn = DateTime.now();
                  });
                  checkSharedPref();
                } else {
                  context.read<Shifts>().addShift(Shift(
                        currentLogIn!.toIso8601String(),
                        DateTime.now().toIso8601String(),
                      ));
                  prefs.clear();
                  setState(() {
                    currentLogIn = null;
                  });
                  checkSharedPref();
                }
              },
              child: const Icon(
                Icons.fingerprint,
                size: 40,
              )),
        ),
      ],
    );
  }
}
