// screen/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewmodel/game_viewmodel.dart';
import 'game_details_screen.dart';
import '../models/game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel()..loadGames(),
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
        body: Consumer<GameViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.greenAccent));
            }

            if (viewModel.errorMessage.isNotEmpty) {
              return Center(
                  child: Text(viewModel.errorMessage,
                      style: const TextStyle(color: Colors.redAccent)));
            }

            return Column(
              children: [
                // --- Wyszukiwarka ---
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Wyszukaj grę...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search, color: Colors.greenAccent),
                      filled: true,
                      fillColor: const Color(0xFF2A2A3D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (query) => viewModel.filterGames(query),
                  ),
                ),

                // --- Filtry platformy i gatunku ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Platforma",
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            DropdownButtonFormField<String>(
                              value: viewModel.selectedPlatform,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey[900],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              dropdownColor: Colors.blueGrey[800],
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                              items: ["All", "PC", "Browser"]
                                  .map((platform) => DropdownMenuItem(
                                value: platform,
                                child: Text(platform),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) viewModel.updatePlatform(value, "");
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gatunek",
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            DropdownButtonFormField<String>(
                              value: viewModel.selectedGenre,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey[900],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              dropdownColor: Colors.blueGrey[800],
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                              items: viewModel.genres
                                  .map((genre) => DropdownMenuItem(
                                value: genre,
                                child: Text(genre),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) viewModel.updateGenre(value, "");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Lista gier ---
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.filteredGames.length,
                    itemBuilder: (context, index) {
                      final game = viewModel.filteredGames[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GameDetailsScreen(game: game)),
                          );
                        },
                        child: Card(
                          color: const Color(0xFF2A2A3D),
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: game.thumbnail,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  width: 64,
                                  height: 64,
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.image,
                                      color: Colors.white),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 64,
                                  height: 64,
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.image,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(game.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              children: [
                                Chip(
                                  label: Text(game.genre,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  backgroundColor: Colors.greenAccent,
                                ),
                                const SizedBox(width: 6),
                                Chip(
                                  label: Text(game.platform,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  backgroundColor: Colors.orangeAccent,
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
