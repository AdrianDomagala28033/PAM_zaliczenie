import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/game.dart';

class ApiService {
  static const baseUrl = "https://www.freetogame.com/api";

  Future<List<Game>> getGames() async{
    final url = Uri.parse("$baseUrl/games");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Game.fromJson(json)).toList();
    }else{
      throw Exception("Failed to load games");
    }
  }
  Future<Game> getGameDetails(int gameId) async {
    final url = Uri.parse('$baseUrl/game?id=$gameId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Game.fromJson(data);
    } else {
      throw Exception("Failed to load game details");
    }
  }


}