// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Shift extends _Shift with RealmObject {
  Shift(
    DateTime login,
    DateTime logout,
  ) {
    RealmObject.set(this, 'login', login);
    RealmObject.set(this, 'logout', logout);
  }

  Shift._();

  @override
  DateTime get login => RealmObject.get<DateTime>(this, 'login') as DateTime;
  @override
  set login(DateTime value) => throw RealmUnsupportedSetError();

  @override
  DateTime get logout => RealmObject.get<DateTime>(this, 'logout') as DateTime;
  @override
  set logout(DateTime value) => throw RealmUnsupportedSetError();

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Shift._);
    return const SchemaObject(Shift, [
      SchemaProperty('login', RealmPropertyType.timestamp),
      SchemaProperty('logout', RealmPropertyType.timestamp),
    ]);
  }
}
