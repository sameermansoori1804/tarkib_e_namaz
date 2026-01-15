import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController implements GetxService {


  double _latitude = 0.000;
  double get latitude => _latitude;


  double _longitude = 0.000;
  double get longitude => _longitude;

  String _address = "";
  String get address => _address;


  String _daySetting = "";
  String get daySetting => _daySetting;

  String _tune = "";
  String get tune => _tune;


  Future<void> getInitData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
     _latitude = prefs.getDouble("latitude") ?? 23.8698579;
    _longitude = prefs.getDouble("longitude") ?? 75.1778739;
    _address = prefs.getString("address") ?? "Barelly Utter Pradesh";
    _daySetting = prefs.getString("daySetting") ?? "0";



    String imsak = '${prefs.getString("imsak_tune") ?? "0"}';
    String fazr = '${prefs.getString("imsak_tune") ?? "0"}';
    String sunrise = '${prefs.getString("sunrise_tune") ?? "0"}';
    String zuhar = '${prefs.getString("imsak_tune") ?? "0"}';
    String? asr = '${prefs.getString("asr_tune") ?? "0"}';
    String magrib = '${prefs.getString("imsak_tune") ?? "0"}';
    String sunset ='${prefs.getString("sunset_tune") ?? "0"}';
    String isha = '${prefs.getString("isha_tune") ?? "0"}';
    String midnight = '${prefs.getString("midnight_tune") ?? "0"}';
    _tune = '$imsak,$fazr,$sunrise,$zuhar,$asr,$magrib,$sunset,$isha,$midnight';
  }



  /// Fetch and update current location
  Future<void> getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Check location service
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _address = 'Location services are disabled';
        return;
      }

      // Check permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _address = 'Location permissions are denied';
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _address = 'Location permissions are permanently denied';
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _latitude = position.latitude;
      _longitude = position.longitude;

      // Get address
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        _address =
        "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }


      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble("latitude", _latitude);
      await prefs.setDouble("longitude", _longitude);
      await prefs.setString("address", _address ?? "");
  }











}