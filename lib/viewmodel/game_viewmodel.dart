import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game.dart';
import '../services/api_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GameViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  List<Game> games = [];
  List<Game> filteredGames = [];
  bool isLoading = true;
  String errorMessage = "";

  String selectedPlatform = "All";
  String selectedGenre = "All";
  List<String> genres = ["All"];

  Future<void> loadGames({int page = 1}) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      final data = await apiService.getGames();
      games = data;
      filteredGames = games;

      genres = ["All"];
      genres.addAll(games.map((g) => g.genre).toSet().toList()..sort());

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("cachedGames", jsonEncode(games.map((g) => g.toJson()).toList()));

      isLoading = false;
      notifyListeners();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);

      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString("cachedGames");
      if (cachedData != null) {
        final List decoded = jsonDecode(cachedData);
        games = decoded.map((json) => Game.fromJson(json)).toList();
        filteredGames = games;
        genres = ["All"];
        genres.addAll(games.map((g) => g.genre).toSet().toList()..sort());
        errorMessage = "Tryb offline: pokazuję ostatnio pobrane dane";
      } else {
        errorMessage = "Błąd pobierania danych: $e";
      }
      isLoading = false;
      notifyListeners();
    }
  }


  void filterGames(String query) {
    analytics.logEvent(
      name: 'search_performed',
      parameters: {'query': query},
    );

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

    analytics.logEvent(
      name: 'filter_applied',
      parameters: {'filter_type': 'platform', 'value': platform},
    );

    filterGames(query);
  }

  void updateGenre(String genre, String query) {
    selectedGenre = genre;

    analytics.logEvent(
      name: 'filter_applied',
      parameters: {'filter_type': 'genre', 'value': genre},
    );

    filterGames(query);
  }
}
