import 'package:Tetris_Fan/Screens/game_board.dart';
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
        // 开始游戏按钮
        Center(
          child: ElevatedButton(
            onPressed: () => _startGame(context),
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(
                GameConfig.buttonBackgroundColor,
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
}
