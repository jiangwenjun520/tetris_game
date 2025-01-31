import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Tetris_Fan/config/game_config.dart';
import 'package:Tetris_Fan/TetrominoShapes/pieces.dart';
import 'package:Tetris_Fan/TetrominoShapes/shapes.dart';

/// 游戏状态管理类
/// 负责管理游戏的核心状态和逻辑
class GameState {
  /// 游戏面板
  List<List<TetrominoShapes?>> gameBoard;

  /// 当前活动方块
  Piece currentPiece;

  /// 下一个方块
  Piece nextPiece;

  /// 游戏状态
  int score;
  bool isGameOver;
  int highScore = 0; // 添加最高分数

  /// 本地存储键
  static const String highScoreKey = 'tetris_high_score';

  /// 构造函数
  GameState()
      : gameBoard = List.generate(GameConfig.columnLength,
            (i) => List.generate(GameConfig.rowLength, (j) => null)),
        currentPiece = Piece(type: TetrominoShapes.L),
        nextPiece = Piece(type: _getRandomShape()),
        score = 0,
        isGameOver = false,
        highScore = 0 {
    // 初始化时加载最高分
    _loadHighScore();
  }

  /// 加载最高分
  Future<void> _loadHighScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      highScore = prefs.getInt(highScoreKey) ?? 0;
    } catch (e) {
      print('Error loading high score: $e');
    }
  }

  /// 保存最高分
  Future<void> _saveHighScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(highScoreKey, highScore);
    } catch (e) {
      print('Error saving high score: $e');
    }
  }

  /// 获取随机形状
  static TetrominoShapes _getRandomShape() {
    final random = Random();
    return TetrominoShapes
        .values[random.nextInt(TetrominoShapes.values.length)];
  }

  /// 重置游戏状态
  void reset() {
    gameBoard = List.generate(GameConfig.columnLength,
        (i) => List.generate(GameConfig.rowLength, (j) => null));
    score = 0;
    isGameOver = false;
    currentPiece = Piece(type: _getRandomShape());
    nextPiece = Piece(type: _getRandomShape());
    currentPiece.intializePiece();
  }

  /// 检查碰撞
  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / GameConfig.rowLength).floor();
      int column = currentPiece.position[i] % GameConfig.rowLength;

      switch (direction) {
        case Direction.left:
          column -= 1;
          break;
        case Direction.right:
          column += 1;
          break;
        case Direction.down:
          row += 1;
          break;
      }

      if (row >= GameConfig.columnLength ||
          column < 0 ||
          column >= GameConfig.rowLength) {
        return true;
      }
    }
    return false;
  }

  /// 检查着陆
  bool checkLanded() {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / GameConfig.rowLength).floor();
      int col = currentPiece.position[i] % GameConfig.rowLength;

      if (row + 1 < GameConfig.columnLength &&
          row >= 0 &&
          gameBoard[row + 1][col] != null) {
        return true;
      }
    }
    return false;
  }

  /// 处理方块着陆
  void handleLanding() {
    if (checkCollision(Direction.down) || checkLanded()) {
      _placePiece();
      createNewPiece();
    }
  }

  /// 放置方块
  void _placePiece() {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / GameConfig.rowLength).floor();
      int column = currentPiece.position[i] % GameConfig.rowLength;
      if (row >= 0 && column >= 0) {
        gameBoard[row][column] = currentPiece.type;
      }
    }
  }

  /// 清除已完成的行
  void clearLines() {
    for (int row = GameConfig.columnLength - 1; row >= 0; row--) {
      if (_isRowFull(row)) {
        _clearRow(row);
        updateScore(); // 使用新的更新分数方法
      }
    }
  }

  /// 检查行是否已满
  bool _isRowFull(int row) {
    return !gameBoard[row].contains(null);
  }

  /// 清除指定行
  void _clearRow(int row) {
    for (int r = row; r > 0; r--) {
      gameBoard[r] = List.from(gameBoard[r - 1]);
    }
    gameBoard[0] = List.generate(GameConfig.rowLength, (index) => null);
  }

  /// 检查游戏是否结束
  bool checkGameOver() {
    return gameBoard[0].any((element) => element != null);
  }

  /// 创建新方块
  void createNewPiece() {
    currentPiece = nextPiece;
    currentPiece.intializePiece();
    nextPiece = Piece(type: _getRandomShape());

    if (checkGameOver()) {
      isGameOver = true;
    }
  }

  /// 检查是否可以移动（包括边界和已有方块的碰撞检测）
  bool canMove(Direction direction) {
    // 首先检查边界碰撞
    if (checkCollision(direction)) {
      return false;
    }

    // 然后检查与已有方块的碰撞
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / GameConfig.rowLength).floor();
      int col = currentPiece.position[i] % GameConfig.rowLength;

      switch (direction) {
        case Direction.left:
          if (col - 1 >= 0 && gameBoard[row][col - 1] != null) {
            return false;
          }
          break;
        case Direction.right:
          if (col + 1 < GameConfig.rowLength &&
              gameBoard[row][col + 1] != null) {
            return false;
          }
          break;
        case Direction.down:
          if (row + 1 < GameConfig.columnLength &&
              gameBoard[row + 1][col] != null) {
            return false;
          }
          break;
      }
    }
    return true;
  }

  /// 检查边界碰撞

  /// 更新分数
  void updateScore() {
    score++;
    if (score > highScore) {
      highScore = score;
      _saveHighScore(); // 保存新的最高分
    }
  }
}
