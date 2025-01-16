import 'package:Tetris_Fan/Screens/game_board.dart';
import 'package:Tetris_Fan/Screens/difficulty_menu.dart';
import 'package:Tetris_Fan/config/game_config.dart';
import 'package:flutter/material.dart';

/// HomePage 类 - 游戏的主页面
/// 显示游戏标题和开始游戏按钮
class HomePage extends StatelessWidget {
  /// 构造函数
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景容器
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 游戏标题和按钮
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TETRIS',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // 开始游戏按钮
              ElevatedButton(
                onPressed: () => _startGame(context),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    GameConfig.buttonBackgroundColor,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                ),
                child: const Text(
                  'PLAY',
                  style: TextStyle(
                    fontSize: GameConfig.buttonFontSize,
                    fontWeight: FontWeight.w800,
                    color: GameConfig.buttonTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 难度选择按钮
              ElevatedButton(
                onPressed: () => _showDifficultyMenu(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey.shade800,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Difficulty: ${GameConfig.difficultyNames[GameConfig.currentDifficulty]}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 开始游戏
  void _startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const GameBoard(),
      ),
    );
  }

  /// 显示难度选择菜单
  void _showDifficultyMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const DifficultyMenu(),
      ),
    );
  }
}
