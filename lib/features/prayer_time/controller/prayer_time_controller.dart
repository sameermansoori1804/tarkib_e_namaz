import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/adhan_notification_service_helper.dart';
import '../../../utils/audio.dart';
import '../../home/domain/models/prayer_data.dart';
import 'package:intl/intl.dart';

import '../domain/models/salat_waqt.dart';

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
          }

        } catch (e) {
          timing.isToday = false;
        }
      } else {
        timing.isToday = false;
      }
    }

    setNotification();
    update();

  }

  List<Data>? _notificationTimingList =[];
  List<Data>? get notificationTimingList =>_notificationTimingList;

  List<SalatWaqt> _salatList =[];
  List<SalatWaqt> get salatList =>_salatList;


  final adhanNotificationServices = AdhanNotificationServiceImpl();

  void setNotification() async{
    await adhanNotificationServices.cancelAllNotifications();
    final today = DateTime.now();
    _loadPreferences();
    for (var timing in _prayerTiming!) {
      final readableDate = timing.date?.readable;

      if (readableDate != null) {
        DateTime parsedDate = DateFormat("dd MMM yyyy").parse(readableDate);
        DateTime fajrDateTime =getTime(readableDate,timing.timings?.fajr ?? "00:00");
        DateTime zuharDateTime =getTime(readableDate,timing.timings?.dhuhr ?? "00:00");
        DateTime asrDateTime =getTime(readableDate,timing.timings?.asr ?? "00:00");
        DateTime magribDateTime =getTime(readableDate,timing.timings?.maghrib ?? "00:00");
        DateTime ishaDateTime =getTime(readableDate,timing.timings?.isha ?? "00:00");
        DateTime todayDate = DateTime(today.year, today.month, today.day);
        DateTime compareDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
        if (compareDate.isBefore(todayDate)) {
          print("⛔ Past Date: $fajrDateTime");
        } else{
          final prefs = await SharedPreferences.getInstance();

          String defaultName = Uri.parse(ringtoneFiles.values.first).pathSegments.last.split('.').first;

          SalatWaqt salatWaqt1 = SalatWaqt(id: int.parse("1${parsedDate.day}"), name: "Fajr", time: fajrDateTime, isNotificationEnabled: prefs.getBool("Fajr_enabled") ?? true,ring: prefs.getString("Fajr_ring")?? defaultName);
          SalatWaqt salatWaqt2 = SalatWaqt(id: int.parse("2${parsedDate.day}"), name: "Zuhar", time: zuharDateTime, isNotificationEnabled:prefs.getBool("Zuhr_enabled") ?? true,ring:prefs.getString('Zuhr_ring') ?? defaultName);
          SalatWaqt salatWaqt3 = SalatWaqt(id: int.parse("3${parsedDate.day}"), name: "Asr", time: asrDateTime, isNotificationEnabled: prefs.getBool("Asr_enabled")?? true,ring: prefs.getString('Asr_ring') ?? defaultName);
          SalatWaqt salatWaqt4 = SalatWaqt(id: int.parse("4${parsedDate.day}"), name: "Magrib", time: magribDateTime, isNotificationEnabled: prefs.getBool("Maghrib_enabled") ?? true,ring: prefs.getString('Maghrib_ring') ?? defaultName);
          SalatWaqt salatWaqt5 = SalatWaqt(id: int.parse("5${parsedDate.day}"), name: "Isha", time: ishaDateTime, isNotificationEnabled: prefs.getBool("Isha_enabled") ?? true,ring: prefs.getString('Isha_ring') ?? defaultName);
          setShaduleNotification(salatWaqt1);
          setShaduleNotification(salatWaqt2);
          setShaduleNotification(salatWaqt3);
          setShaduleNotification(salatWaqt4);
          setShaduleNotification(salatWaqt5);

        }
      }
    }




  }
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


  Map<String, bool> prayerSwitch = {};
  Map<String, String> selectedRingtone = {};
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    for (var prayer in prayers) {
      prayerSwitch[prayer] = prefs.getBool("${prayer}_enabled") ?? false;

      String defaultName = Uri.parse(ringtoneFiles.keys.first).pathSegments.last.split('.').first;
      selectedRingtone[prayer] = prefs.getString("${prayer}_ring") ?? defaultName;
    }

  }
  cancelNotification()async {

    setNotification();
  }

  setShaduleNotification(SalatWaqt salatWaqt)async{


    if(salatWaqt.isNotificationEnabled){
      final time = salatWaqt.time.toLocal();
      print(time);
      print(salatWaqt.id);
      print(salatWaqt.isNotificationEnabled);
      print(salatWaqt.name);
      print('farukh------->');
      await adhanNotificationServices.scheduleNotification(
        id: salatWaqt.id,
        title: salatWaqt.name.toLowerCase().tr,
        body: '${'time_for'.tr} ${salatWaqt.name} ${'started_at'.tr} ${DateFormat.jm().format(time)}',
        dateTime: time,
        payload: time.toIso8601String(),
        ring:  salatWaqt.ring
      );
    }
  }


  DateTime getTime(String readableDate,String time){
    DateTime parsedDate = DateFormat("dd MMM yyyy").parse(readableDate);
    String fajrRaw = time ?? "00:00";
    String fajrClean = fajrRaw.split(' ').first;
    List<String> timeParts = fajrClean.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    DateTime fajrDateTime = DateTime(parsedDate.year, parsedDate.month, parsedDate.day, hour, minute,);
    return fajrDateTime;
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

    print("farukh------------->125");
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
     String nextDayFajrFormatted = DateFormat('h:mm a').format(nextDayFajr);

      final currentTime = DateTime.now(); // Current time

      // Check current time against each prayer time range
      if (now.isAfter(fajr) && now.isBefore(sunrise)) {
        _title =  'Fajr';
        _currentPrayerTime = formatPrayerTime(timings.fajr ?? "00:00");
        final timi = {
          'fajr': formatPrayerTime2(timings.fajr ?? "00:00"),
          'sunrise': formatPrayerTime2(timings.dhuhr ?? "00:00"),
        };

        final timeDiffs = getTimeDifferences(timi, currentTime);
        print("${_progress}");

      } else if (now.isAfter(sunrise) && now.isBefore(dhuhr)) {
        _title = 'Sunrise';
        _currentPrayerTime =  formatPrayerTime(timings.sunrise ?? "00:00");
        final timi = {
          'current_prayer': formatPrayerTime(timings.sunrise ?? "00:00"),
          'next_prayer': formatPrayerTime(timings.dhuhr ?? "00:00"),
        };

        getTimeDifferences(timi, currentTime);
      } else if (now.isAfter(dhuhr) && now.isBefore(asr)) {
        _title = 'Dhuhr';
        _currentPrayerTime =  formatPrayerTime(timings.dhuhr ?? "00:00");
        final timi = {
          'current_prayer': formatPrayerTime(timings.dhuhr ?? "00:00"),
          'next_prayer': formatPrayerTime(timings.asr ?? "00:00"),
        };
        getTimeDifferences(timi, currentTime);
      } else if (now.isAfter(asr) && now.isBefore(maghrib)) {
        _title = 'Asr';
        _currentPrayerTime =  formatPrayerTime(timings.asr ?? "00:00");
        final timi = {
          'current_prayer': formatPrayerTime(timings.asr ?? "00:00"),
          'next_prayer': formatPrayerTime(timings.maghrib ?? "00:00"),
        };
        getTimeDifferences(timi, currentTime);


      } else if (now.isAfter(maghrib) && now.isBefore(isha)) {
        _title = 'Maghrib';
        _currentPrayerTime =  formatPrayerTime(timings.maghrib ?? "00:00");
        final timi = {
          'current_prayer': formatPrayerTime(timings.maghrib ?? "00:00"),
          'next_prayer': formatPrayerTime(timings.isha ?? "00:00"),
        };
        getTimeDifferences(timi, currentTime);
      } else if (now.isAfter(isha) && now.isBefore(nextDayFajr)) {
          _title = 'Isha';
        _currentPrayerTime =  formatPrayerTime(timings.isha ?? "00:00");
          final timi = {
            'current_prayer': formatPrayerTime(timings.isha ?? "00:00"),
            'next_prayer': formatPrayerTime(timings.fajr ?? "00:00"),
          };
          getTimeDifferences(timi, currentTime,next: true);
      }

      update();

  }


  Map<String, dynamic> getTimeDifferences(Map<String, String?> timings, DateTime currentTime ,{bool next = false}) {



    // Helper function to parse "HH:mm AM/PM" into DateTime (today)
    DateTime parseTime(String timeStr,{bool next = false}) {
      var now = DateTime.now();
      if(next){
        now = now.add(Duration(days: 1));
      }
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
    final nextPrayerTime = parseTime(timings['next_prayer'] ?? '00:00 AM',next: next);

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
    update();
    return {
      'current_to_next': formatDuration(currentToNextDiff),
      'remaining_time': formatDuration(remainingTimeDiff),
      'current_to_next_minutes': currentToNextDiff,
      'remaining_minutes': remainingTimeDiff,
    };

  }


Future<void>  setCurrentData(Data todayTimming) async{

    _currentTiming = todayTimming;
    update(["prayer"]);
  }

  Future<void>  setCurrentTime(String todayTimming,String title) async{

    _currentPrayerTime = todayTimming;
    _title = title;
    update(["prayer"]);
  }








}

