import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NormalTasbihScreen extends StatefulWidget {
  const NormalTasbihScreen({Key? key}) : super(key: key);

  @override
  State<NormalTasbihScreen> createState() => _NormalTasbihScreenState();
}

class _NormalTasbihScreenState extends State<NormalTasbihScreen> {
  int _count = 0;
  final int _target = 33; // You can change to 99

  @override
  void initState() {
    super.initState();
    _loadCount();
  }

  Future<void> _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('tasbih_count') ?? 0;
    });
  }

  Future<void> _saveCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbih_count', _count);
  }

  void _incrementCounter() {
    setState(() {
      _count++;
    });
    _saveCount();
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
    _saveCount();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_count % _target) / _target;

    return Scaffold(
      backgroundColor: const Color(0xFF0B3D2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B3D2E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Digital Tasbih",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: _incrementCounter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Dhikr Text
            const Text(
              "سُبْحَانَ ٱللَّٰهِ",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "SubhanAllah",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 40),

            /// Circular Counter
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.white24,
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),

                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1F6F5B),
                          Color(0xFF289672),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _count.toString(),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// Reset Button
            ElevatedButton(
              onPressed: _resetCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0B3D2E),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Reset",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Tap anywhere to count",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}