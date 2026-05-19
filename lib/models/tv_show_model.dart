import 'package:hive/hive.dart';
part 'tv_show_model.g.dart';

@HiveType(typeId: 0)
class TvShow extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? imageMedium;

  @HiveField(3)
  final String? imageOriginal;

  @HiveField(4)
  final double? rating;

  @HiveField(5)
  final List<String> genres;

  @HiveField(6)
  final String? summary;

  @HiveField(7)
  final String? status;

  @HiveField(8)
  final String? premiered;

  @HiveField(9)
  final String? language;

  TvShow({
    required this.id,
    required this.name,
    this.imageMedium,
    this.imageOriginal,
    this.rating,
    this.genres = const [],
    this.summary,
    this.status,
    this.premiered,
    this.language,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      imageMedium: json['image']?['medium'],
      imageOriginal: json['image']?['original'],
      rating: (json['rating']?['average'] as num?)?.toDouble(),
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'],
      status: json['status'],
      premiered: json['premiered'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': {'medium': imageMedium, 'original': imageOriginal},
      'rating': {'average': rating},
      'genres': genres,
      'summary': summary,
      'status': status,
      'premiered': premiered,
      'language': language,
    };
  }
}
