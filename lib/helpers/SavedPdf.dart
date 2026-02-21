class SavedPdf {
  final String title;
  final String path;

  SavedPdf({required this.title, required this.path});

  Map<String, dynamic> toJson() => {
        'title': title,
        'path': path,
      };

  factory SavedPdf.fromJson(Map<String, dynamic> json) {
    return SavedPdf(
      title: json['title'],
      path: json['path'],
    );
  }
}
