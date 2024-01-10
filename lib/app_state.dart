import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _installedList = prefs.getStringList('ff_installedList')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _installedList;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_testObject')) {
        try {
          _testObject = jsonDecode(prefs.getString('ff_testObject') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _test = '';
  String get test => _test;
  set test(String _value) {
    _test = _value;
  }

  List<dynamic> _installedList = [];
  List<dynamic> get installedList => _installedList;
  set installedList(List<dynamic> _value) {
    _installedList = _value;
    prefs.setStringList(
        'ff_installedList', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToInstalledList(dynamic _value) {
    _installedList.add(_value);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromInstalledList(dynamic _value) {
    _installedList.remove(_value);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromInstalledList(int _index) {
    _installedList.removeAt(_index);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void updateInstalledListAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _installedList[_index] = updateFn(_installedList[_index]);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInInstalledList(int _index, dynamic _value) {
    _installedList.insert(_index, _value);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  dynamic _testObject;
  dynamic get testObject => _testObject;
  set testObject(dynamic _value) {
    _testObject = _value;
    prefs.setString('ff_testObject', jsonEncode(_value));
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
