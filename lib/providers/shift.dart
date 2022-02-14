import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
part 'shift.g.dart';

@RealmModel()
class _Shift {
  late final String login;
  late final String logout;
  // late Duration logTime;
  // Shift({required this.login, required this.logout, required this.logTime});
}

class Shifts extends ChangeNotifier {
  Realm? realm;
  List<Shift> _shifts = [
    // Shift(
    //     login: DateTime.now().subtract(const Duration(hours: 8)),
    //     logout: DateTime.now(),
    //     logTime: const Duration(hours: 8))
  ];

  Shifts() {
    print("here");

    final config = Configuration([Shift.schema]);
    realm = Realm(config);
    if (realm != null && _shifts.isEmpty) {
      print("realm is not null");
      _shifts = realm!.all<Shift>().toList();
      notifyListeners();
    }
  }

  List<Shift> get allShifts {
    return [..._shifts];
  }

  addShift(Shift newShift) {
    print("yes");
    _shifts.add(newShift);
    realm!.write(() {
      realm!.add(newShift);
    });
    _shifts = realm!.all<Shift>().toList();
    notifyListeners();
  }

  String calculateBalance() {
    Duration balance = Duration.zero;
    for (Shift shift in _shifts) {
      balance = balance +
          DateTime.parse(shift.logout).difference(
              DateTime.parse(shift.login).subtract(Duration(hours: 8)));
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(balance.inMinutes.remainder(60));
    return "${twoDigits(balance.inHours)}:$twoDigitMinutes";
  }
}
