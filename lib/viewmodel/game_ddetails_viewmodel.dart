import 'package:flutter/cupertino.dart';

import '../models/game.dart';

class GameDetailsViewModel extends ChangeNotifier {
  final Game game;

  GameDetailsViewModel(this.game);

  // Future<void> openGame() async {
  //   final uri = Uri.parse(game.gameUrl);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     print('Nie można otworzyć ${game.gameUrl}');
  //   }
  // }
}
