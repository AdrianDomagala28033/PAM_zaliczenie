import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/api_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class GameDetailsViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  Game? game;
  bool isLoading = true;
  String errorMessage = "";

  Future<void> loadGameDetails(int gameId) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      game = await apiService.getGameDetails(gameId);

      isLoading = false;
      notifyListeners();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);

      isLoading = false;
      errorMessage = "Błąd pobierania szczegółów: $e";
      notifyListeners();
    }
  }
}
