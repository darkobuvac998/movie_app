import 'dart:convert';

class ShowShort {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  ShowShort({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  ShowShort copyWith({
    String? title,
    String? year,
    String? imdbID,
    String? type,
    String? poster,
  }) {
    return ShowShort(
      title: title ?? this.title,
      year: year ?? this.year,
      imdbID: imdbID ?? this.imdbID,
      type: type ?? this.type,
      poster: poster ?? this.poster,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Title': title});
    result.addAll({'Year': year});
    result.addAll({'imdbID': imdbID});
    result.addAll({'Type': type});
    result.addAll({'Poster': poster});

    return result;
  }

  factory ShowShort.fromMap(Map<String, dynamic> map) {
    return ShowShort(
      title: map['Title'] ?? '',
      year: map['Year'] ?? '',
      imdbID: map['imdbID'] ?? '',
      type: map['Type'] ?? '',
      poster: map['Poster'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowShort.fromJson(String source) =>
      ShowShort.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowShort(title: $title, year: $year, imdbID: $imdbID, type: $type, poster: $poster)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowShort &&
        other.title == title &&
        other.year == year &&
        other.imdbID == imdbID &&
        other.type == type &&
        other.poster == poster;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        year.hashCode ^
        imdbID.hashCode ^
        type.hashCode ^
        poster.hashCode;
  }
}
