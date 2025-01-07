import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Tetris_Fan/config/game_config.dart';
import 'package:Tetris_Fan/models/game_state.dart';
import 'package:Tetris_Fan/TetrominoShapes/shapes.dart';
import 'package:Tetris_Fan/widgets/game_grid.dart';
import 'package:Tetris_Fan/widgets/next_piece_preview.dart';

/// GameBoard 类 - 游戏主界面
/// 包含游戏网格、分数显示和控制按钮
class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late GameState gameState;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    gameState = GameState();
    startGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  /// 开始游戏X
  void startGame() {
    gameState.currentPiece.intializePiece();
    _startGameLoop();
  }

  /// 启动游戏循环
  void _startGameLoop() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(
      const Duration(milliseconds: GameConfig.frameRate),
      _onGameTick,
    );
  }

  /// 游戏循环回调
  void _onGameTick(Timer timer) {
    setState(() {
      gameState.clearLines();
      gameState.handleLanding();

      if (gameState.isGameOver) {
        timer.cancel();
        _showGameOverDialog();
      } else {
        gameState.currentPiece.movePiece(Direction.down);
      }
    });
  }

  /// 显示游戏结束对话框
  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // 止点击外部关闭
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Column(
          children: [
            // 游戏结束图标
            Icon(
              Icons.sports_esports,
              size: 50,
              color: GameConfig.tetrominoColors[TetrominoShapes.L],
            ),
            const SizedBox(height: 10),
            // 游戏结束文本
            const Text(
              'GAME OVER',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: GameConfig.titleFontSize,
                color: Colors.black87,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Your Score',
                style: TextStyle(
                  fontSize: GameConfig.fontSize,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${gameState.score}',
                style: TextStyle(
                  fontSize: GameConfig.titleFontSize * 1.5,
                  fontWeight: FontWeight.bold,
                  color: GameConfig.tetrominoColors[TetrominoShapes.T],
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          // 重新开始按钮
          ElevatedButton(
            onPressed: () {
              _resetGame();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: GameConfig.tetrominoColors[TetrominoShapes.I],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.replay, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Play Again',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: GameConfig.fontSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 重置游戏
  void _resetGame() {
    setState(() {
      gameState.reset();
      startGame();
    });
  }

  /// 移动方块
  void _moveLeft() {
    if (!gameState.checkCollision(Direction.left)) {
      setState(() {
        gameState.currentPiece.movePiece(Direction.left);
      });
    }
  }

  void _moveRight() {
    if (!gameState.checkCollision(Direction.right)) {
      setState(() {
        gameState.currentPiece.movePiece(Direction.right);
      });
    }
  }

  void _rotatePiece() {
    setState(() {
      gameState.currentPiece.rotatePiece();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: GameConfig.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.emoji_events,
              color: GameConfig.tetrominoColors[TetrominoShapes.L],
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Best: ${gameState.highScore}',
              style: TextStyle(
                color: GameConfig.tetrominoColors[TetrominoShapes.L],
                fontSize: GameConfig.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 分数和下一个方块预览
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 分数显示
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          'SCORE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: GameConfig.fontSize * 0.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${gameState.score}',
                          style: TextStyle(
                            color:
                                GameConfig.tetrominoColors[TetrominoShapes.T],
                            fontSize: GameConfig.titleFontSize * 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 分隔
                  const SizedBox(width: 20),

                  // 下一个方块预览
                  Column(
                    children: [
                      const Text(
                        'NEXT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: GameConfig.fontSize * 0.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      NextPiecePreview(
                        nextPiece: gameState.nextPiece,
                        size: 60,
                      ),
                    ],
                  ),
                ],
              ),

              // 游戏网格
              GameGrid(gameState: gameState),
            ],
          ),
        ),
      ),
    );
  }
}
