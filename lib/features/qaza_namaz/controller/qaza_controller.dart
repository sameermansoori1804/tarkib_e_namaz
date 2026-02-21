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


  /// Example: incrementing and saving
  void increment(String type) async{
    print("farukh----->");
    print("farukh----->$type");
    final prefs = await SharedPreferences.getInstance();
    switch (type) {
      case "fazr":
        _fazr++;
        await prefs.setInt('fazr', _fazr);
        break;
      case "zuhar":
        _zuhar++;
        await prefs.setInt('zuhar', _zuhar);
        break;
      case "asr":
        _asr++;
        await prefs.setInt('asr', _asr);
        break;
      case "magrib":
        await prefs.setInt('magrib', _magrib);
        _magrib++;
        break;
      case "isha":
        await prefs.setInt('isha', _isha);
        _isha++;
        break;
      case "roza":
        await prefs.setInt('roza', _roza);
        _roza++;
        break;
      default:
        throw ArgumentError("Invalid Qaza type: $type");
    }
    update();


  }


  void decrement(String type) async {
    print("farukh----->");
    print("farukh----->$type");
    final prefs = await SharedPreferences.getInstance();
    switch (type) {
      case "fazr":
        _fazr--;
        await prefs.setInt('fazr', _fazr);
        break;
      case "zuhar":
        _zuhar--;
        await prefs.setInt('zuhar', _zuhar);
        break;
      case "asr":
        _asr--;
        await prefs.setInt('asr', _asr);
        break;
      case "magrib":
        _magrib--;
        await prefs.setInt('magrib', _magrib);
        break;
      case "isha":
        _isha--;
        await prefs.setInt('isha', _isha);
        break;
      case "roza":
        await prefs.setInt('roza', _roza);
        _roza--;
        break;
      default:
        throw ArgumentError("Invalid Qaza type: $type");
    }
    update();

  }
}
