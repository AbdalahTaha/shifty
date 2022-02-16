import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
part 'shift.g.dart';

@RealmModel()
class _Shift {
  late final String login;
  late final String logout;
}

class Shifts extends ChangeNotifier {
  late Realm realm;
  List<Shift> _shifts = [];

  Shifts() {
    init();
    if (_shifts.isEmpty) {
      _shifts = realm.all<Shift>().toList();
      notifyListeners();
    }
  }
  init() {
    final config = Configuration([Shift.schema]);
    realm = Realm(config);
  }

  List<Shift> get allShifts {
    return [..._shifts];
  }

  addShift(Shift newShift) {
    realm.write(() {
      realm.add(newShift);
    });
    _shifts.add(newShift);
    notifyListeners();
  }

  deleteShift(Shift shift) {
    _shifts.remove(shift);
    notifyListeners();
    realm.write(() {
      realm.delete(shift);
    });
  }

  void resetMonth() async {
    realm.write(() => realm.deleteMany(_shifts));
    _shifts.clear();
    notifyListeners();
  }

  void deleteDB() {
    realm.close();
    Realm.deleteRealm(realm.config.path);
    _shifts.clear();
    init();
    notifyListeners();
  }

  String calculateBalance() {
    Duration balance = Duration.zero;
    for (Shift shift in _shifts) {
      balance = balance +
          DateTime.parse(shift.logout).difference(DateTime.parse(shift.login)) -
          const Duration(hours: 8);
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(balance.inMinutes.abs().remainder(60));
    return "${balance.inHours.sign >= 0 ? '+' : '-'}${twoDigits(balance.inHours.abs())}:$twoDigitMinutes";
  }
}
