class Show {
  final int id;
  final String name;
  final String? imageMedium;
  final String? imageOriginal;
  final double? rating;
  final List<String> genres;
  final String summary;

  Show({
    required this.id,
    required this.name,
    this.imageMedium,
    this.imageOriginal,
    this.rating,
    this.genres = const [],
    this.summary = '',
  });


  static String? _https(dynamic url) {
    if (url == null) return null;
    return url.toString().replaceFirst('http://', 'https://');
  }

  static String _stripHtml(dynamic html) {
    if (html == null) return '';
    return html.toString().replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  factory Show.fromJson(Map<String, dynamic> json) {
    final image = json['image'];
    final ratingMap = json['rating'];
    return Show(
      id: json['id'] as int,
      name: (json['name'] ?? '-').toString(),
      imageMedium: image is Map ? _https(image['medium']) : null,
      imageOriginal: image is Map ? _https(image['original']) : null,
      rating: ratingMap is Map && ratingMap['average'] != null
          ? (ratingMap['average'] as num).toDouble()
          : null,
      genres: json['genres'] is List
          ? (json['genres'] as List).map((e) => e.toString()).toList()
          : <String>[],
      summary: _stripHtml(json['summary']),
    );
  }

  /// Untuk disimpan ke Hive.
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'imageMedium': imageMedium,
        'imageOriginal': imageOriginal,
        'rating': rating,
        'genres': genres,
        'summary': summary,
      };

  factory Show.fromMap(Map<String, dynamic> map) => Show(
        id: map['id'] as int,
        name: map['name'] as String,
        imageMedium: map['imageMedium'] as String?,
        imageOriginal: map['imageOriginal'] as String?,
        rating: (map['rating'] as num?)?.toDouble(),
        genres: (map['genres'] as List?)?.map((e) => e.toString()).toList() ??
            <String>[],
        summary: (map['summary'] ?? '') as String,
      );

  String get ratingText => rating == null ? '-' : rating!.toStringAsFixed(1);
}
