import 'package:flutter/foundation.dart';

class Shift {
  final DateTime login;
  final DateTime logout;
  final Duration logTime;
  Shift({required this.login, required this.logout, required this.logTime});
}

class Shifts extends ChangeNotifier {
  final List<Shift> _shifts = [
    // Shift(
    //     login: DateTime.now().subtract(const Duration(hours: 8)),
    //     logout: DateTime.now(),
    //     logTime: const Duration(hours: 8))
  ];
  List<Shift> get allShifts {
    return [..._shifts];
  }

  addShift(Shift newShift) {
    print("shift added");
    print(newShift.logTime);
    _shifts.add(newShift);
    print(_shifts.length);
    notifyListeners();
  }
}
