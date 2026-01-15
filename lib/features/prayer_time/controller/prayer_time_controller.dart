import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

import '../../home/domain/models/prayer_data.dart';
import 'package:intl/intl.dart';

class PrayerTimeController extends GetxController implements GetxService {

  Data? _currentTiming = Data();
  Data? get currentTiming => _currentTiming;


  List<Data>? _prayerTiming = [];
  List<Data>? get prayerTiming => _prayerTiming;


  String? _currentPrayerTime = "";
  String? get currentPrayerTime => _currentPrayerTime;

  String? _title = "";
  String? get title => _title;



  double _progress = 0;
  double get progress => _progress;

  String _remainingTime = "";
  String get remainingTime => _remainingTime;


  int _currentIndex = 0;
  int get currentIndex => _currentIndex;



  Future<void>  initData() async{
    _prayerTiming?.addAll(Get.find<SplashController>().prayerTime!.data as Iterable<Data>);
    for (var timing in _prayerTiming!) {
      String? dateString = timing.date?.gregorian?.date;
      DateTime today = DateTime.now();
       _currentIndex = (today.day - 1);

      if (dateString != null && dateString.isNotEmpty) {
        try {
          DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(dateString);

          bool isToday = parsedDate.year == today.year &&
              parsedDate.month == today.month &&
              parsedDate.day == today.day;
          timing.isToday = isToday;
          _currentTiming = timing;
          if (isToday) {

            await getCurrentPrayerTimeTitle(timing.timings);


            break; // Stop loop once today's date is found
          }

        } catch (e) {
          timing.isToday = false;
        }
      } else {
        timing.isToday = false;
      }
    }
    update();

  }
String formatPrayerTime(String timeString) {
  // Remove the " (IST)" part
  String cleanTime = timeString.split(" ").first;
  DateTime parsedTime = DateFormat("HH:mm").parse(cleanTime);
  return DateFormat("h:mm a").format(parsedTime);
}

  String formatPrayerTime2(String timeString) {
    // Remove the " (IST)" part
    String cleanTime = timeString.split(" ").first;
    DateTime parsedTime = DateFormat("HH:mm").parse(cleanTime);
    return DateFormat("h:mm").format(parsedTime);
  }

   getCurrentPrayerTimeTitle(Timings? timings) async {
      DateTime now = DateTime.now();

      // Helper function to create DateTime for a prayer time
      DateTime createPrayerDateTime(String timeString) {
        if (timeString.isEmpty) return DateTime.now();
        try {
          String cleanTime = timeString.split(" ").first;
          DateTime parsed = DateFormat("HH:mm").parse(cleanTime);
          return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
        } catch (e) {
          return DateTime.now();
        }
      }

      // Create DateTime objects for each prayer time
      DateTime fajr = createPrayerDateTime(timings!.fajr ?? '');
      DateTime sunrise = createPrayerDateTime(timings!.sunrise ?? '');
      DateTime dhuhr = createPrayerDateTime(timings!.dhuhr ?? '');
      DateTime asr = createPrayerDateTime(timings!.asr ?? '');
      DateTime maghrib = createPrayerDateTime(timings!.maghrib ?? '');
      DateTime isha = createPrayerDateTime(timings!.isha ?? '');

      // Adjust for midnight crossing (isha to next day's fajr)
      DateTime nextDayFajr = fajr.add(Duration(days: 1));


      // Check current time against each prayer time range
      if (now.isAfter(fajr) && now.isBefore(sunrise)) {
        _title =  'Fajr';
        _currentPrayerTime = formatPrayerTime(timings.fajr ?? "00:00");
        final timi = {
          'fajr': formatPrayerTime2(timings.asr ?? "00:00"),
          'sunrise': formatPrayerTime2(timings.maghrib ?? "00:00"),
        };
        final currentTime = DateTime.now(); // Current time

        final timeDiffs = getTimeDifferences(timi, currentTime);
        print("${_progress}");

      } else if (now.isAfter(sunrise) && now.isBefore(dhuhr)) {
        _title = 'Sunrise';
        _currentPrayerTime =  formatPrayerTime(timings.sunrise ?? "00:00");

      } else if (now.isAfter(dhuhr) && now.isBefore(asr)) {
        _title = 'Dhuhr';
        _currentPrayerTime =  formatPrayerTime(timings.dhuhr ?? "00:00");

      } else if (now.isAfter(asr) && now.isBefore(maghrib)) {
        _title = 'Asr';
        _currentPrayerTime =  formatPrayerTime(timings.asr ?? "00:00");
        final timi = {
          'current_prayer': formatPrayerTime(timings.asr ?? "00:00"),
          'next_prayer': formatPrayerTime(timings.maghrib ?? "00:00"),
        };
        final currentTime = DateTime.now();
        getTimeDifferences(timi, currentTime);


      } else if (now.isAfter(maghrib) && now.isBefore(isha)) {
        _title = 'Maghrib';
        _currentPrayerTime =  formatPrayerTime(timings.maghrib ?? "00:00");

      } else if (now.isAfter(isha) && now.isBefore(nextDayFajr)) {
          _title = 'Isha';
        _currentPrayerTime =  formatPrayerTime(timings.isha ?? "00:00");

      }

      update();

  }


  Map<String, dynamic> getTimeDifferences(Map<String, String?> timings, DateTime currentTime) {
    // Helper function to parse "HH:mm AM/PM" into DateTime (today)
    DateTime parseTime(String timeStr) {
      final now = DateTime.now();
      final timeParts = timeStr.split(' ');
      final time = timeParts[0].split(':');
      final hour = int.parse(time[0]);
      final minute = int.parse(time[1]);
      final period = timeParts.length > 1 ? timeParts[1].toLowerCase() : 'am';

      int hour24 = hour;
      if (period == 'pm' && hour < 12) {
        hour24 = hour + 12;
      } else if (period == 'am' && hour == 12) {
        hour24 = 0; // 12 AM = 00:00
      }

      return DateTime(now.year, now.month, now.day, hour24, minute);
    }


    // Get current_prayer and next_prayer times (default to "00:00 AM" if null)
    final currentPrayerTime = parseTime(timings['current_prayer'] ?? '00:00 AM');
    final nextPrayerTime = parseTime(timings['next_prayer'] ?? '00:00 AM');

    // Calculate differences in minutes
    final currentToNextDiff = nextPrayerTime.difference(currentPrayerTime).inMinutes;
    final remainingTimeDiff = nextPrayerTime.difference(currentTime).inMinutes;

    // Format into "Xh Ym" (e.g., "1h 15m")
    String formatDuration(int totalMinutes) {
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      if (hours > 0 && minutes > 0) {
        return '0${hours}:${minutes}';
      } else if (hours > 0) {
        return '0${hours}:00';
      } else {
        return '00:${minutes}';
      }
    }

    _remainingTime  = formatDuration(remainingTimeDiff);
    _progress  = (remainingTimeDiff/currentToNextDiff)*150;
    return {
      'current_to_next': formatDuration(currentToNextDiff),
      'remaining_time': formatDuration(remainingTimeDiff),
      'current_to_next_minutes': currentToNextDiff,
      'remaining_minutes': remainingTimeDiff,
    };
  }


Future<void>  setCurrentData(Data todayTimming) async{

    _currentTiming = todayTimming;
    update();
  }

  Future<void>  setCurrentTime(String todayTimming,String title) async{

    _currentPrayerTime = todayTimming;
    _title = title;
    update();
  }

}