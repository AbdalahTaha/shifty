// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Shift extends _Shift with RealmObject {
  Shift(
    String login,
    String logout,
  ) {
    RealmObject.set(this, 'login', login);
    RealmObject.set(this, 'logout', logout);
  }

  Shift._();

  @override
  String get login => RealmObject.get<String>(this, 'login') as String;
  @override
  set login(String value) => throw RealmUnsupportedSetError();

  @override
  String get logout => RealmObject.get<String>(this, 'logout') as String;
  @override
  set logout(String value) => throw RealmUnsupportedSetError();

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Shift._);
    return const SchemaObject(Shift, [
      SchemaProperty('login', RealmPropertyType.string),
      SchemaProperty('logout', RealmPropertyType.string),
    ]);
  }
}
