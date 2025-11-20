import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/game.dart';

class GameDetailsScreen extends StatelessWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(game.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(game.thumbnail, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20,),
            Text(game.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("${game.genre} (${game.platform})",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              game.shortDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wydawca: ${game.publisher}",
                    style: const TextStyle(fontSize: 14)),
                Text("Data: ${game.releaseDate}",
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){},
                  child: const Text("Pokaż więcej")),
            )
          ],
        ),
      ),
    );
  }
}