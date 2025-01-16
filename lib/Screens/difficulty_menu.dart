import 'package:flutter/material.dart';
import 'package:Tetris_Fan/config/game_config.dart';
import 'package:Tetris_Fan/Screens/game_board.dart';

class DifficultyMenu extends StatelessWidget {
  const DifficultyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConfig.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Difficulty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ...GameDifficulty.values
                .map((difficulty) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GameConfig.buttonBackgroundColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () {
                          GameConfig.currentDifficulty = difficulty;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameBoard(),
                            ),
                          );
                        },
                        child: Text(
                          GameConfig.difficultyNames[difficulty]!,
                          style: GameConfig.difficultyMenuTextStyle.copyWith(
                            color: GameConfig.buttonTextColor,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
