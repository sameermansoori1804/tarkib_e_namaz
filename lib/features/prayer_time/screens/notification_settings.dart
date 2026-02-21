import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_template/features/prayer_time/controller/prayer_time_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_template/utils/audio.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<String> prayers = [
    "Fajr",
    "Zuhr",
    "Asr",
    "Maghrib",
    "Isha",
  ];

  final Map<String, String> ringtoneFiles = {
    "Adhan 1": Audio.Adhan_1,
    "Adhan 2": Audio.Adhan_2,
    "Adhan 3": Audio.Adhan_3,
    "Beep 1": Audio.noti_1,
    "Beep 2": Audio.noti_beep,
    "Beep 3": Audio.noti_beep_beep,
    "Siren": Audio.siren,
  };
  final Map<String, String> ringtoneFiles2 = {
    "Adhan 1": 'azan_1',
    "Adhan 2": 'azan_2',
    "Adhan 3": 'azan_3',
    "Beep 1": 'noti_1',
    "Beep 2": 'noti_beep',
    "Beep 3":'noti_beep_beep',
    "Siren": 'siren',
  };
  Map<String, bool> prayerSwitch = {};
  Map<String, String> selectedRingtone = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  /// Load saved values
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    for (var prayer in prayers) {
      prayerSwitch[prayer] =
          prefs.getBool("${prayer}_enabled") ?? true;

      selectedRingtone[prayer] =
          prefs.getString("${prayer}_ringtone") ??
              ringtoneFiles.keys.first;
      selectedRingtone[prayer] =
          prefs.getString("${prayer}_ring") ??
              ringtoneFiles2.keys.first;
    }

    setState(() {});
  }

  /// Save switch value
  Future<void> _saveSwitch(String prayer, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("${prayer}_enabled", value);
  }

  /// Save ringtone value
  Future<void> _saveRingtone(String prayer, String ringtone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("${prayer}_ringtone", ringtone);
    String fileName = Uri.parse(ringtone).pathSegments.last.split('.').first;
    await prefs.setString("${prayer}_ring", fileName);
  }

  Future<void> _playSound(String ringtone) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(ringtoneFiles[ringtone]!));
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerTimeController>(
      builder: (prayerTimeController) {
        return Scaffold(
          backgroundColor: const Color(0xff0f172a),
          appBar: AppBar(
            backgroundColor: const Color(0xff1e293b),
            title: const Text("Prayer Notifications"),
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: prayers.length,
            itemBuilder: (context, index) {
              final prayer = prayers[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1e293b),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Prayer Name + Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prayer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          activeColor: Colors.green,
                          value: prayerSwitch[prayer] ?? false,
                          onChanged: (value) {
                            setState(() {
                              prayerSwitch[prayer] = value;
                            });
                            _saveSwitch(prayer, value);
                            prayerTimeController.cancelNotification();

                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// Ringtone Dropdown
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xff334155),
                      value: selectedRingtone[prayer],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xff334155),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: ringtoneFiles.keys.map((ring) {
                        return DropdownMenuItem(
                          value: ring,
                          child: Text(ring),
                        );
                      }).toList(),
                      onChanged: prayerSwitch[prayer] == true
                          ? (value) {
                        setState(() {
                          selectedRingtone[prayer] = value!;
                        });
                        _saveRingtone(prayer, value!);
                        _playSound(value!);
                      }
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}