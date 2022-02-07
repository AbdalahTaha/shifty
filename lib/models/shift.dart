class Shift {
  final DateTime login;
  final DateTime logout;
  final Duration logTime;
  Shift({required this.login, required this.logout, required this.logTime});
}

class Shifts {
  final List<Shift> _shifts = [
    Shift(
        login: DateTime.now().subtract(const Duration(hours: 8)),
        logout: DateTime.now(),
        logTime: const Duration(hours: 8))
  ];
  List<Shift> get shifts {
    return [..._shifts];
  }

  addShift(Shift newShift) {
    _shifts.add(newShift);
  }
}
