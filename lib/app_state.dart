import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
  set test(String value) {
    _test = value;
  }

  List<dynamic> _installedList = [];
  List<dynamic> get installedList => _installedList;
  set installedList(List<dynamic> value) {
    _installedList = value;
    prefs.setStringList(
        'ff_installedList', value.map((x) => jsonEncode(x)).toList());
  }

  void addToInstalledList(dynamic value) {
    _installedList.add(value);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromInstalledList(dynamic value) {
    _installedList.remove(value);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromInstalledList(int index) {
    _installedList.removeAt(index);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void updateInstalledListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _installedList[index] = updateFn(_installedList[index]);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInInstalledList(int index, dynamic value) {
    _installedList.insert(index, value);
    prefs.setStringList(
        'ff_installedList', _installedList.map((x) => jsonEncode(x)).toList());
  }

  dynamic _testObject;
  dynamic get testObject => _testObject;
  set testObject(dynamic value) {
    _testObject = value;
    prefs.setString('ff_testObject', jsonEncode(value));
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
