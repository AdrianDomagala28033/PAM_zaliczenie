class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String genre;
  final String platform;
  final String publisher;
  final String releaseDate;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.releaseDate,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'] ?? "Brak tytułu",
      thumbnail: json['thumbnail'] ?? "",
      shortDescription: json['short_description'] ?? "Brak opisu",
      genre: json['genre'] ?? "Brak danych",
      platform: json['platform'] ?? "Brak danych",
      publisher: json['publisher'] ?? "Nieznany wydawca",
      releaseDate: json['release_date'] ?? "Brak daty",
    );
  }
}
