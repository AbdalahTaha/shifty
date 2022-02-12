import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
part 'shift.g.dart';

@RealmModel()
class _Shift {
  late final DateTime login;
  late final DateTime logout;
  // late Duration logTime;
  // Shift({required this.login, required this.logout, required this.logTime});
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
    _shifts.add(newShift);
    notifyListeners();
  }
}
