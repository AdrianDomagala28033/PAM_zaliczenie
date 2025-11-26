// models/game.dart
class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String shortDescription;
  final String publisher;
  final String releaseDate;
  final String gameUrl; // <-- dodajemy to pole

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.shortDescription,
    required this.publisher,
    required this.releaseDate,
    required this.gameUrl, // <-- dodajemy do konstruktora
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
      shortDescription: json['short_description'] ?? '',
      publisher: json['publisher'] ?? '',
      releaseDate: json['release_date'] ?? '',
      gameUrl: json['game_url'] ?? '', // <-- tutaj przypisujemy
    );
  }
}
