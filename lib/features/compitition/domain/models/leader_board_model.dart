class LeaderBoardModel {
  final int userId;
  final String name;
  final int points;
  final int rank;
  final bool itsMe;

  LeaderBoardModel({
    required this.userId,
    required this.name,
    required this.points,
    required this.rank,
    required this.itsMe,
  });

  /// From JSON
  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    return LeaderBoardModel(
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      points: json['points'] ?? 0,
      rank: json['rank'] ?? 0,
      itsMe: json['itsMe'] ?? false,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'points': points,
      'rank': rank,
      'itsMe': itsMe,
    };
  }
}