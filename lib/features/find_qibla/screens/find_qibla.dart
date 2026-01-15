import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/images.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';

class QiblaCompassApp extends StatelessWidget {
  const QiblaCompassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qibla Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const QiblaCompassScreen(),
    );
  }
}


class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({Key? key}) : super(key: key);

  @override
  State<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  Position? _position;
  double? _heading; // device heading in degrees
  double _qiblaDirection = 0.0; // degrees from north to qibla
  StreamSubscription<CompassEvent>? _compassSubscription; // Changed type here

  @override
  void initState() {
    super.initState();
    _getLocation();
    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (mounted) {
        setState(() {
          _heading = event.heading;
        });
      }
    });
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        _position = position;
        _qiblaDirection = _calculateQiblaDirection(
            position.latitude, position.longitude);
      });
    }
  }

  // Correct Qibla direction calculation using great-circle bearing formula
  double _calculateQiblaDirection(double lat, double lon) {
    const double kaabaLat = 21.4225;
    const double kaabaLon = 39.8262;

    double latRad = _degToRad(lat);
    double lonRad = _degToRad(lon);
    double kaabaLatRad = _degToRad(kaabaLat);
    double kaabaLonRad = _degToRad(kaabaLon);

    double deltaLon = kaabaLonRad - lonRad;

    double y = math.sin(deltaLon) * math.cos(kaabaLatRad);
    double x = math.cos(latRad) * math.sin(kaabaLatRad) -
        math.sin(latRad) * math.cos(kaabaLatRad) * math.cos(deltaLon);

    double bearingRad = math.atan2(y, x);
    double bearingDeg = (_radToDeg(bearingRad) + 360) % 360;

    return bearingDeg;
  }

  double _degToRad(double deg) => deg * (math.pi / 180);
  double _radToDeg(double rad) => rad * (180 / math.pi);

  @override
  Widget build(BuildContext context) {
    double dialRotation = 0;
    double qiblaRotation = 0;

    if (_heading != null) {
      dialRotation = -_heading!; // Rotate dial opposite to device heading
      qiblaRotation = _qiblaDirection; // Qibla relative to dial north
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.qibla_finder_bg), // Your background
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            // Coordinates display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    _position == null
                        ? 'Getting location...'
                        : '${_position!.latitude.toStringAsFixed(6)}, ${_position!.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // Compass with Qibla pointer
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Rotated Compass Dial (ticks + N,S,E,W)
                    Transform.rotate(
                      angle: _degToRad(dialRotation),
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.greenAccent, width: 4),
                          color: Colors.black,
                        ),
                        child: Stack(
                          children: [
                            // Tick marks
                            ...List.generate(60, (index) {
                              double tickRotation = index * 6.0;
                              return Transform.rotate(
                                angle: _degToRad(tickRotation),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 2,
                                    height: index % 5 == 0 ? 12 : 6,
                                    color: Colors.white70,
                                  ),
                                ),
                              );
                            }),

                            // Compass directions
                            Positioned(
                              top: 10,
                              left: 0,
                              right: 0,
                              child: const Text(
                                'N',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: const Text(
                                'S',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              top: 120,
                              bottom: 0,
                              child: const Text(
                                'W',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 120,
                              bottom: 0,
                              child: const Text(
                                'E',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),

                            Positioned(
                              left: 85,
                              top: 85,
                              child: Transform.rotate(
                                angle: _degToRad(qiblaRotation),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.greenAccent, width: 3),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      Images.qibla,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Qibla pointer rotated relative to dial north

                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Qibla angle display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _position == null
                    ? 'Calculating Qibla...'
                    : _qiblaDirection.toStringAsFixed(4),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
