import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController implements GetxService {


  double _latitude = 0.000;
  double get latitude => _latitude;


  double _longitude = 0.000;
  double get longitude => _longitude;

  String _address = "";
  String get address => _address;



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
  }








}