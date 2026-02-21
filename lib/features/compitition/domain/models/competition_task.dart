class CompetitionTask {
  final int id;
  final String name;
  final String description;
  final int nos;
  final int point;
  final String type;
  final bool isCompleted;

  CompetitionTask({
    required this.id,
    required this.name,
    required this.description,
    required this.nos,
    required this.point,
    required this.type,
    required this.isCompleted,
  });

  factory CompetitionTask.fromJson(Map<String, dynamic> json) {
    return CompetitionTask(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      nos: json['nos'],
      point: json['point'],
      type: json['type'],
      isCompleted: json['is_completed'],
    );
  }
}