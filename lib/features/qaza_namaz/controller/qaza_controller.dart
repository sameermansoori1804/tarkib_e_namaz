import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QazaController extends GetxController implements GetxService {
  int _fazr = 0;
  int get fazr => _fazr;

  int _zuhar = 0;
  int get zuhar => _zuhar;

  int _asr = 0;
  int get asr => _asr;

  int _magrib = 0;
  int get magrib => _magrib;

  int _isha = 0;
  int get isha => _isha;

  int _roza = 0;
  int get roza => _roza;

  /// Load saved values from SharedPreferences
  Future<void> loadInitialQazaData() async {
    final prefs = await SharedPreferences.getInstance();

    _fazr = prefs.getInt('fazr') ?? 0;
    _zuhar = prefs.getInt('zuhar') ?? 0;
    _asr = prefs.getInt('asr') ?? 0;
    _magrib = prefs.getInt('magrib') ?? 0;
    _isha = prefs.getInt('isha') ?? 0;
    _roza = prefs.getInt('roza') ?? 0;

    update(); // Notify listeners
  }

  /// Save updated values to SharedPreferences
  Future<void> saveQazaData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('fazr', _fazr);
    await prefs.setInt('zuhar', _zuhar);
    await prefs.setInt('asr', _asr);
    await prefs.setInt('magrib', _magrib);
    await prefs.setInt('isha', _isha);
    await prefs.setInt('roza', _roza);
  }

  /// Example: incrementing and saving
  void increment(String type) {
    switch (type) {
      case "Fazr":
        _fazr++;
        break;
      case "Zuhar":
        _zuhar++;
        break;
      case "Asr":
        _asr++;
        break;
      case "Magrib":
        _magrib++;
        break;
      case "Isha":
        _isha++;
        break;
      case "Roza":
        _roza++;
        break;
      default:
        throw ArgumentError("Invalid Qaza type: $type");
    }

    saveQazaData();
    update();
  }


  void decrement(String type) {
    switch (type) {
      case "fazr":
        _fazr++;
        break;
      case "zuhar":
        _zuhar++;
        break;
      case "asr":
        _asr++;
        break;
      case "magrib":
        _magrib++;
        break;
      case "isha":
        _isha++;
        break;
      case "roza":
        _roza++;
        break;
      default:
        throw ArgumentError("Invalid Qaza type: $type");
    }

    saveQazaData();
    update();
  }
}
