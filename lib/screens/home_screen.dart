import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projekt_zaliczeniowy/services/api_service.dart';

import '../models/game.dart';
import 'game_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Game> games = [];
  List<Game> filteredGames = [];
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    try {
      final data = await apiService.getGames();
      setState(() {
        games = data;
        filteredGames = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading games: $e");
      setState(() => isLoading = false);
    }
  }

  void _filterGames(String query) {
    final results = games.where((game) {
      final titleLower = game.title.toLowerCase();
      final genreLower = game.genre.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) || genreLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredGames = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wyszukiwarka darmowych gier")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterGames,
              decoration: InputDecoration(
                hintText: "Wyszukaj grę...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // GAME LIST
          Expanded(
            child: ListView.builder(
              itemCount: filteredGames.length,
              itemBuilder: (context, index) {
                final game = filteredGames[index];

                return ListTile(
                  leading: Image.network(
                    game.thumbnail,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  title: Text(game.title),
                  subtitle: Text("${game.genre} - ${game.platform}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GameDetailsScreen(game: game),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
