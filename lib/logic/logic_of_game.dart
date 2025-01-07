import 'package:Tetris_Fan/TetrominoShapes/pieces.dart';
import 'package:Tetris_Fan/TetrominoShapes/shapes.dart';
import 'dart:math';

/// 游戏面板数据结构
/// 使用二维数组表示游戏区域，null表示空格，非null表示已占用的方块类型
List<List<TetrominoShapes?>> gameBoard = List.generate(
    columnLength,
    (i) => List.generate(
          rowLength,
          (j) => null,
        ));

/// 当前活动的方块
/// 这个方块是玩家当前可以控制的方块
Piece currentPiece = Piece(type: TetrominoShapes.L);

/// 游戏状态变量
int currentScore = 0; // 当前得分
bool gameOver = false; // 游戏是否结束

/// 检查方块移动是否会发生碰撞
/// [direction] 移动方向
/// 返回true表示会发生碰撞，false表示可以安全移动
bool checkCollision(Direction direction) {
  // 遍历当前方块的每个位置
  for (int i = 0; i < currentPiece.position.length; i++) {
    // 计算当前位置的行和列
    int row = (currentPiece.position[i] / rowLength).floor();
    int column = currentPiece.position[i] % rowLength;

    // 根据移动方向调整位置
    if (direction == Direction.left) {
      column -= 1;
    } else if (direction == Direction.right) {
      column += 1;
    } else if (direction == Direction.down) {
      row += 1;
    }

    // 检查是否超出游戏边界
    if (row >= columnLength || column < 0 || column >= rowLength) {
      return true;
    }
  }
  return false;
}

/// 检查方块是否需要着陆
/// 当方块触底或碰到其他方块时进行着陆处理
void checkLadning() {
  // 如果向下移动会发生碰撞或已经着陆
  if (checkCollision(Direction.down) || checkLanded()) {
    // 将当前方块固定到游戏面板上
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int column = currentPiece.position[i] % rowLength;
      if (row >= 0 && column >= 0) {
        gameBoard[row][column] = currentPiece.type;
      }
    }
    // 创建新的方块
    createNewPiece();
  }
}

/// 检查当前方块是否已经着陆
/// 返回true表示已着陆，false表示未着陆
bool checkLanded() {
  // 遍历当前方块的每个位置
  for (int i = 0; i < currentPiece.position.length; i++) {
    int row = (currentPiece.position[i] / rowLength).floor();
    int col = currentPiece.position[i] % rowLength;

    // 检查下方格子是否已被占用
    if (row + 1 < columnLength && row >= 0 && gameBoard[row + 1][col] != null) {
      return true;
    }
  }
  return false;
}

/// 清除已完成的行并计分
void clearLine() {
  // 从底部向上遍历每一行
  for (int row = columnLength - 1; row >= 0; row--) {
    bool rowIsFull = true;

    // 检查当前行是否已填满
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[row][col] == null) {
        rowIsFull = false;
        break;
      }
    }

    // 如果行已填满，进行消除操作
    if (rowIsFull) {
      // 将上方的所有行向下移动一行
      for (int r = row; r > 0; r--) {
        gameBoard[r] = List.from(gameBoard[r - 1]);
      }
      // 清空顶部行
      gameBoard[0] = List.generate(rowLength, (index) => null);
      // 增加得分
      currentScore++;
    }
  }
}

/// 检查游戏是否结束
/// 当方块堆积到顶部时游戏结束
bool isGameOver() {
  // 检查顶部行是否有方块
  for (int col = 0; col < rowLength; col++) {
    if (gameBoard[0][col] != null) {
      return true;
    }
  }
  return false;
}

/// 创建新的方块
void createNewPiece() {
  // 随机生成一个新的方块类型
  Random random = Random();
  TetrominoShapes randomShape =
      TetrominoShapes.values[random.nextInt(TetrominoShapes.values.length)];
  currentPiece = Piece(type: randomShape);
  currentPiece.intializePiece();

  /* 游戏结束检查说明：
   * 由于游戏结束条件是顶部行有方块，
   * 我们在创建新方块时检查游戏是否结束，
   * 而不是每一帧都检查。
   * 因为新方块可以穿过顶部行，
   * 但如果创建新方块时顶部行已有方块，
   * 则表示游戏结束。
   */
  if (isGameOver()) {
    gameOver = true;
  }
}
