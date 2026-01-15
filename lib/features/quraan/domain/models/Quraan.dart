class Quraan {
  int? id;
  String? name;
  String? pageStart;
  String? pageEnd;
  int? ruku;
  int? ayat;

  Quraan(
      {this.id, this.name, this.pageStart, this.pageEnd, this.ruku, this.ayat});

  Quraan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pageStart = json['pageStart'];
    pageEnd = json['pageEnd'];
    ruku = json['ruku'];
    ayat = json['ayat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pageStart'] = this.pageStart;
    data['pageEnd'] = this.pageEnd;
    data['ruku'] = this.ruku;
    data['ayat'] = this.ayat;
    return data;
  }
}