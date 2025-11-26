// screen/game_details_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/game.dart';

class GameDetailsScreen extends StatelessWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  Future<void> _openGameUrl(BuildContext context) async {
    if (game.gameUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Brak linku do gry')),
      );
      return;
    }

    final Uri uri = Uri.parse(game.gameUrl);

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nie można otworzyć strony gry')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Błąd przy otwieraniu linku')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B2F),
      appBar: AppBar(
        title: const Text(
          "Szczegóły gry",
          style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0F1B33),
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: game.thumbnail.isNotEmpty
                  ? Image.network(
                game.thumbnail,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[800],
                  child: const Icon(Icons.image, color: Colors.white, size: 64),
                ),
              )
                  : Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[800],
                child: const Icon(Icons.image, color: Colors.white, size: 64),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              game.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.greenAccent),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  label: Text(game.genre, style: const TextStyle(color: Colors.black)),
                  backgroundColor: Colors.greenAccent,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(game.platform, style: const TextStyle(color: Colors.black)),
                  backgroundColor: Colors.orangeAccent,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              game.shortDescription,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wydawca: ${game.publisher}", style: const TextStyle(color: Colors.white70)),
                Text("Data: ${game.releaseDate}", style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _openGameUrl(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Graj teraz", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
