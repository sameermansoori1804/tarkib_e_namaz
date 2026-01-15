import '../../../home/domain/models/tasbih_model.dart';

class ReadTasbih {
  int? id;
  int? user_id;
  int tasbih_id;
  int count;
  int round;
  int target;
  int? status;
  int? insert_id;
  String? created_at;
  String? updated_at;
  Tasbih? tasbih;

  ReadTasbih({
    this.id,
    this.user_id,
    required this.tasbih_id,
    required this.count,
    required this.round,
    required this.target,
    this.status,
    this.insert_id,
    this.created_at,
    this.updated_at,
    this.tasbih,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'tasbih_id': tasbih_id,
      'count': count,
      'round': round,
      'target': target,
      'status': status,
      'insert_id': insert_id,
      'created_at': created_at,
      'updated_at': updated_at,
      'tasbih': tasbih,
    };
  }

  factory ReadTasbih.fromJson(Map<String, dynamic> json) {
    return ReadTasbih(
      id: json['id'],
      user_id: json['user_id'],
      tasbih_id: json['tasbih_id'],
      count: json['count'],
      round: json['round'],
      target: json['target'],
      status: json['status'],
      insert_id: json['insert_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      tasbih: json['tasbih'],
    );
  }
}
