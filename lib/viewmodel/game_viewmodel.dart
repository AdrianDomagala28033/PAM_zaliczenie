// viewmodel/game_viewmodel.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/api_service.dart';

class GameViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Game> games = [];
  List<Game> filteredGames = [];
  bool isLoading = true;
  String errorMessage = "";

  String selectedPlatform = "All";
  String selectedGenre = "All";
  List<String> genres = ["All"];

  Future<void> loadGames() async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      games = await apiService.getGames();
      filteredGames = games;

      genres = ["All"];
      genres.addAll(games.map((g) => g.genre).toSet().toList()..sort());

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  void filterGames(String query) {
    final searchLower = query.toLowerCase();
    filteredGames = games.where((game) {
      final titleMatch = game.title.toLowerCase().contains(searchLower);
      final genreMatch = game.genre.toLowerCase().contains(searchLower);
      final platformMatch = selectedPlatform == "All" || game.platform.contains(selectedPlatform);
      final genreFilterMatch = selectedGenre == "All" || game.genre == selectedGenre;
      return (titleMatch || genreMatch) && platformMatch && genreFilterMatch;
    }).toList();
    notifyListeners();
  }

  void updatePlatform(String platform, String query) {
    selectedPlatform = platform;
    filterGames(query);
  }

  void updateGenre(String genre, String query) {
    selectedGenre = genre;
    filterGames(query);
  }

}
