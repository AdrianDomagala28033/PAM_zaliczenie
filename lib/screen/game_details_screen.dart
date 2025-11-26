import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/game_details_viewmodel.dart';

class GameDetailsScreen extends StatelessWidget {
  final int gameId;

  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameDetailsViewModel()..loadGameDetails(gameId),
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1B2F),
        appBar: AppBar(
          title: const Text(
            "Wyszukiwarka darmowych gier",
            style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0F1B33),
          elevation: 4,
          iconTheme: const IconThemeData(color: Colors.greenAccent),
        ),
        body: Consumer<GameDetailsViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
            }

            if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage, style: const TextStyle(color: Colors.redAccent)));
            }

            final game = viewModel.game!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(game.thumbnail, width: double.infinity, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 20),
                  Text(game.title,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Chip(label: Text(game.genre, style: const TextStyle(color: Colors.black)), backgroundColor: Colors.greenAccent),
                      const SizedBox(width: 8),
                      Chip(label: Text(game.platform, style: const TextStyle(color: Colors.black)), backgroundColor: Colors.orangeAccent),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(game.shortDescription, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Wydawca: ${game.publisher}", style: const TextStyle(color: Colors.white70)),
                      Text("Data: ${game.releaseDate}", style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Center(child: Text("Graj teraz")),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
