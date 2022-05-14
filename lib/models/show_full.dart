import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:movie_app/models/rating.dart';

class ShowFull {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  List<Rating>? ratings;
  final String metascore;
  final String imdbrating;
  final String imdbvotes;
  final String imdbID;
  final String type;
  final String totalseasons;
  final String response;

  ShowFull({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    this.ratings,
    required this.metascore,
    required this.imdbrating,
    required this.imdbvotes,
    required this.imdbID,
    required this.type,
    required this.totalseasons,
    required this.response,
  });

  ShowFull copyWith({
    String? title,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? plot,
    String? language,
    String? country,
    String? awards,
    String? poster,
    List<Rating>? ratings,
    String? metascore,
    String? imdbrating,
    String? imdbvotes,
    String? imdbID,
    String? type,
    String? totalseasons,
    String? response,
  }) {
    return ShowFull(
      title: title ?? this.title,
      year: year ?? this.year,
      rated: rated ?? this.rated,
      released: released ?? this.released,
      runtime: runtime ?? this.runtime,
      genre: genre ?? this.genre,
      director: director ?? this.director,
      writer: writer ?? this.writer,
      actors: actors ?? this.actors,
      plot: plot ?? this.plot,
      language: language ?? this.language,
      country: country ?? this.country,
      awards: awards ?? this.awards,
      poster: poster ?? this.poster,
      ratings: ratings ?? this.ratings,
      metascore: metascore ?? this.metascore,
      imdbrating: imdbrating ?? this.imdbrating,
      imdbvotes: imdbvotes ?? this.imdbvotes,
      imdbID: imdbID ?? this.imdbID,
      type: type ?? this.type,
      totalseasons: totalseasons ?? this.totalseasons,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Title': title});
    result.addAll({'Year': year});
    result.addAll({'Rated': rated});
    result.addAll({'Released': released});
    result.addAll({'Runtime': runtime});
    result.addAll({'Genre': genre});
    result.addAll({'Director': director});
    result.addAll({'Writer': writer});
    result.addAll({'Actors': actors});
    result.addAll({'Plot': plot});
    result.addAll({'Language': language});
    result.addAll({'Country': country});
    result.addAll({'Awards': awards});
    result.addAll({'Poster': poster});
    if (ratings != null) {
      result.addAll({'Ratings': ratings!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'Metascore': metascore});
    result.addAll({'imdbRating': imdbrating});
    result.addAll({'imdbVotes': imdbvotes});
    result.addAll({'imdbID': imdbID});
    result.addAll({'Type': type});
    result.addAll({'totalSeasons': totalseasons});
    result.addAll({'Response': response});

    return result;
  }

  factory ShowFull.fromMap(Map<String, dynamic> map) {
    return ShowFull(
      title: map['Title'] ?? '',
      year: map['Year'] ?? '',
      rated: map['Rated'] ?? '',
      released: map['Released'] ?? '',
      runtime: map['Runtime'] ?? '',
      genre: map['Genre'] ?? '',
      director: map['Director'] ?? '',
      writer: map['Writer'] ?? '',
      actors: map['Actors'] ?? '',
      plot: map['Plot'] ?? '',
      language: map['Language'] ?? '',
      country: map['Country'] ?? '',
      awards: map['Awards'] ?? '',
      poster: map['Poster'] ?? '',
      ratings: map['Ratings'] != null
          ? List<Rating>.from(map['Ratings']?.map((x) => Rating.fromMap(x)))
          : null,
      metascore: map['Metascore'] ?? '',
      imdbrating: map['imdbRating'] ?? '',
      imdbvotes: map['imdbVotes'] ?? '',
      imdbID: map['imdbID'] ?? '',
      type: map['Type'] ?? '',
      totalseasons: map['totalSeasons'] ?? '',
      response: map['Response'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowFull.fromJson(String source) =>
      ShowFull.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowFull(title: $title, year: $year, rated: $rated, released: $released, runtime: $runtime, genre: $genre, director: $director, writer: $writer, actors: $actors, plot: $plot, language: $language, country: $country, awards: $awards, poster: $poster, ratings: $ratings, metascore: $metascore, imdbrating: $imdbrating, imdbvotes: $imdbvotes, imdbID: $imdbID, type: $type, totalseasons: $totalseasons, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowFull &&
        other.title == title &&
        other.year == year &&
        other.rated == rated &&
        other.released == released &&
        other.runtime == runtime &&
        other.genre == genre &&
        other.director == director &&
        other.writer == writer &&
        other.actors == actors &&
        other.plot == plot &&
        other.language == language &&
        other.country == country &&
        other.awards == awards &&
        other.poster == poster &&
        listEquals(other.ratings, ratings) &&
        other.metascore == metascore &&
        other.imdbrating == imdbrating &&
        other.imdbvotes == imdbvotes &&
        other.imdbID == imdbID &&
        other.type == type &&
        other.totalseasons == totalseasons &&
        other.response == response;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        year.hashCode ^
        rated.hashCode ^
        released.hashCode ^
        runtime.hashCode ^
        genre.hashCode ^
        director.hashCode ^
        writer.hashCode ^
        actors.hashCode ^
        plot.hashCode ^
        language.hashCode ^
        country.hashCode ^
        awards.hashCode ^
        poster.hashCode ^
        ratings.hashCode ^
        metascore.hashCode ^
        imdbrating.hashCode ^
        imdbvotes.hashCode ^
        imdbID.hashCode ^
        type.hashCode ^
        totalseasons.hashCode ^
        response.hashCode;
  }
}
