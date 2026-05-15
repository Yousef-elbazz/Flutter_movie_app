class TrailerModel {
  final String id;
  final List<TrailerResult> results;

  TrailerModel({required this.id, required this.results});

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      id: json['id'].toString(),
      results: (json['results'] as List)
          .map((item) => TrailerResult.fromJson(item))
          .toList(),
    );
  }
}

class TrailerResult {
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;

  TrailerResult({
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  factory TrailerResult.fromJson(Map<String, dynamic> json) {
    return TrailerResult(
      name: json['name'],
      key: json['key'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
      official: json['official'],
      publishedAt: DateTime.parse(json['published_at']),
    );
  }
}
