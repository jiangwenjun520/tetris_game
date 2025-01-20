import 'package:flutter/material.dart';
import 'package:Tetris_Fan/TetrominoShapes/shapes.dart';
import 'package:Tetris_Fan/logic/logic_of_game.dart';

class Piece {
  //type of tetris pieces

  TetrominoShapes type;
  Piece({required this.type});

  //the piece is just a list of integers
  List<int> position = [];

  //color of tetris piece
  Color get color => tetrominoColor[type] ?? const Color(0xffffffff);

  // 优化：使用Map存储方块形状的旋转状态
  static final Map<TetrominoShapes, List<List<int>>> _rotationStates = {
    TetrominoShapes.L: [
      [-2, -1, 0, 1],
      [-rowLength, 0, rowLength, rowLength + 1],
      [-1, 0, 1, rowLength - 1],
      [-rowLength - 1, -rowLength, 0, rowLength],
    ],
    TetrominoShapes.J: [
      [-2, -1, 0, -3],
      [-rowLength, 0, rowLength, -rowLength - 1],
      [-1, 0, 1, -rowLength + 1],
      [rowLength + 1, rowLength, 0, -rowLength],
    ],
  };

  //generate the shapes integers

  // -30  -29  -28  -27  -26  -25  -24  -23  -22  -21
  // -20  -19  -18  -17  -16  -15   -14  -13   -12 -11
  // -10   -9   -8   -7  -6   -5    -4    -3    -2   -1
  //  0    1     2    3    4   5     6     7    8   9
  //  10   11   12   13   14   15   16   17   18   19
  void intializePiece() {
    switch (type) {
      case TetrominoShapes.L:
        position = [-26, -16, -6, -5];
        break;

      case TetrominoShapes.J:
        position = [-25, -15, -5, -6];
        break;
      case TetrominoShapes.I:
        position = [-7, -6, -5, -4];
        break;
      case TetrominoShapes.O:
        position = [-16, -15, -5, -6];
        break;
      case TetrominoShapes.S:
        position = [-15, -14, -6, -5];
        break;
      case TetrominoShapes.T:
        position = [-26, -16, -6, -15];
        break;
      case TetrominoShapes.Z:
        position = [-17, -16, -6, -5];
        break;
      default:
    }
  }

  // 优化：使用增量更新而不是循环
  void movePiece(Direction direction) {
    final int offset = switch (direction) {
      Direction.left => -1,
      Direction.right => 1,
      Direction.down => rowLength,
      _ => 0,
    };

    if (offset != 0) {
      for (int i = 0; i < position.length; i++) {
        position[i] += offset;
      }
    }
  }

  int rotationState = 1;

  // 优化：重写旋转算法，使用预计算的旋转矩阵
  void rotatePiece() {
    if (type == TetrominoShapes.O) return; // O型方块不需要旋转

    final rotations = _rotationStates[type];
    if (rotations == null) return;

    final centerPos = position[1]; // 使用第二个方块作为旋转中心
    final nextState = (rotationState + 1) % 4;

    if (nextState >= rotations.length) return;

    // 计算新位置
    final List<int> newPosition = List<int>.generate(
      4,
      (i) => centerPos + rotations[nextState][i],
    );

    // 优化：碰撞检测
    if (_isValidRotation(newPosition)) {
      position = newPosition;
      rotationState = nextState;
    }
  }

  // 优化：新增旋转碰撞检测方法
  bool _isValidRotation(List<int> newPosition) {
    for (final pos in newPosition) {
      if (pos % rowLength < 0 || pos % rowLength >= rowLength) return false;
      if (pos < 0 || pos >= rowLength * columnLength) return false;
      if (gameBoard.contains(pos)) return false;
    }
    return true;
  }

  // 优化：新增投影位置计算方法
  List<int> getProjectedPosition() {
    List<int> projection = List<int>.from(position);
    int dropDistance = 0;

    while (!_willCollide(projection, dropDistance + rowLength)) {
      dropDistance += rowLength;
    }

    for (int i = 0; i < projection.length; i++) {
      projection[i] += dropDistance;
    }

    return projection;
  }

  // 优化：碰撞预测
  bool _willCollide(List<int> positions, int offset) {
    for (final pos in positions) {
      final newPos = pos + offset;
      if (newPos >= rowLength * columnLength) return true;
      if (gameBoard.contains(newPos)) return true;
    }
    return false;
  }

  //check if valid position
  bool positionIsValid(int position) {
    //get the row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    //if the position is taken return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    //otherwise position is valid return true
    else {
      return true;
    }
  }

//check if piece valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      //check for first column or last column is occupied
      int col = pos % rowLength;
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
      //if there is any piece in the first column or last column
      // will go through the wall
    }
    return !(firstColOccupied && lastColOccupied);
  }

  /// 获取相对位置
  List<Offset> getRelativePositions() {
    switch (type) {
      case TetrominoShapes.L:
        return [
          const Offset(0, 0),
          const Offset(0, 1),
          const Offset(0, 2),
          const Offset(1, 2),
        ];
      case TetrominoShapes.J:
        return [
          const Offset(1, 0),
          const Offset(1, 1),
          const Offset(1, 2),
          const Offset(0, 2),
        ];
      case TetrominoShapes.I:
        return [
          const Offset(0, 0),
          const Offset(0, 1),
          const Offset(0, 2),
          const Offset(0, 3),
        ];
      case TetrominoShapes.O:
        return [
          const Offset(0, 0),
          const Offset(1, 0),
          const Offset(0, 1),
          const Offset(1, 1),
        ];
      case TetrominoShapes.S:
        return [
          const Offset(1, 0),
          const Offset(2, 0),
          const Offset(0, 1),
          const Offset(1, 1),
        ];
      case TetrominoShapes.Z:
        return [
          const Offset(0, 0),
          const Offset(1, 0),
          const Offset(1, 1),
          const Offset(2, 1),
        ];
      case TetrominoShapes.T:
        return [
          const Offset(1, 0),
          const Offset(0, 1),
          const Offset(1, 1),
          const Offset(2, 1),
        ];
    }
  }
}
