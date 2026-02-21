import 'dart:convert';

class SalatWaqt {
  int id;
  String name;
  DateTime time;
  bool isNotificationEnabled;
  String ring;
  SalatWaqt({
    required this.id,
    required this.name,
    required this.time,
    required this.isNotificationEnabled,
    required this.ring,
  });

  factory SalatWaqt.fromMap(Map<String, dynamic> map) => SalatWaqt(
        id: map['id'] as int,
        name: map['name'] as String,
        ring: map['ring'] as String,
        time: DateTime.parse(map['time']),
        isNotificationEnabled: map['isNotificationEnabled'] as bool,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'ring': ring,
        'time': time.toIso8601String(),
        'isNotificationEnabled': isNotificationEnabled,
      };

  factory SalatWaqt.fromJson(String json) =>
      SalatWaqt.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
