import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../models/shift.dart';

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
      });
    } else {
      setState(() {
        currentLogIn = DateTime.parse(prefs.getString('currentLogIn')!);
        logOutHighlight = Colors.lightBlueAccent;
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
              Text('LogIn '),
              Expanded(
                child: Container(
                  child: Text(currentLogIn == null
                      ? ""
                      : DateFormat('hh:mm aa')
                          .format(currentLogIn!)
                          .toString()),
                  constraints: BoxConstraints(minHeight: 30),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border.all(color: logInHighlight)),
                ),
              ),
              SizedBox(width: 20),
              Text('LogOut '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(currentLogOut == null
                        ? ""
                        : DateFormat('hh:mm aa')
                            .format(currentLogOut!)
                            .toString()),
                    constraints: BoxConstraints(minHeight: 30),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(color: logOutHighlight)),
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
                } else {
                  prefs.setString(
                      'currentLogOut', DateTime.now().toIso8601String());
                  setState(() {
                    Shifts().addShift(Shift(
                        login: currentLogIn!,
                        logout: DateTime.now(),
                        logTime: DateTime.now().difference(currentLogIn!)));
                  });
                }
              },
              child: Icon(
                Icons.fingerprint,
                size: 40,
              )),
        ),
      ],
    );
  }
}
