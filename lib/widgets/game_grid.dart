import 'package:flutter/material.dart';
import 'package:Tetris_Fan/config/game_config.dart';
import 'package:Tetris_Fan/models/game_state.dart';
import 'package:Tetris_Fan/TetrominoShapes/shapes.dart';
import 'package:Tetris_Fan/widgets/pixel.dart';

/// 游戏网格组件
/// 负责渲染游戏主网格界面
class GameGrid extends StatefulWidget {
  final GameState gameState;
  final VoidCallback onMoveLeft;
  final VoidCallback onMoveRight;
  final VoidCallback onRotate;

  const GameGrid({
    Key? key,
    required this.gameState,
    required this.onMoveLeft,
    required this.onMoveRight,
    required this.onRotate,
  }) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  // 用于跟踪拖动的起始位置
  Offset? dragStartPosition;
  // 记录上次移动的时间
  DateTime? lastMoveTime;
  // 记录最后一次移动方向
  Direction? lastMoveDirection;
  // 记录累计拖动距离
  double accumulatedDx = 0;
  double accumulatedDy = 0;
  // 网格尺寸
  late double gridWidth;
  late double gridHeight;
  // 单个格子的大小
  late double cellWidth;
  late double cellHeight;
  // 保存渲染框的引用
  RenderBox? renderBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      renderBox = context.findRenderObject() as RenderBox?;
      _updateGridSize();
    });
  }

  /// 更新网格尺寸
  void _updateGridSize() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    gridWidth = screenWidth * 0.9;
    gridHeight = screenHeight * 0.7;
    cellWidth = gridWidth / GameConfig.rowLength;
    cellHeight = gridHeight / GameConfig.columnLength;
  }

  /// 获取本地坐标
  Offset? getLocalPosition(Offset globalPosition) {
    try {
      if (renderBox == null) {
        renderBox = context.findRenderObject() as RenderBox?;
      }
      if (renderBox != null) {
        return renderBox!.globalToLocal(globalPosition);
      }
    } catch (e) {
      print('Error converting coordinates: $e');
    }
    return null;
  }

  /// 检查是否可以移动
  bool canMove() {
    if (lastMoveTime == null) {
      lastMoveTime = DateTime.now();
      return true;
    }

    final now = DateTime.now();
    const moveInterval = 100; // 移动间隔（毫秒）

    if (now.difference(lastMoveTime!).inMilliseconds >= moveInterval) {
      lastMoveTime = now;
      return true;
    }
    return false;
  }

  /// 检查坐标是否在网格内
  bool isPositionInGrid(Offset position, double gridWidth, double gridHeight) {
    return position.dx >= 0 &&
        position.dx <= gridWidth &&
        position.dy >= 0 &&
        position.dy <= gridHeight;
  }

  /// 处理方块移动
  void handleMove(Direction direction) {
    lastMoveDirection = direction;
    switch (direction) {
      case Direction.left:
        widget.onMoveLeft();
        break;
      case Direction.right:
        widget.onMoveRight();
        break;
      case Direction.down:
        widget.gameState.currentPiece.movePiece(direction);
        break;
    }
  }

  /// 处理拖动更新
  void handlePanUpdate(DragUpdateDetails details) {
    try {
      if (widget.gameState.isGameOver || dragStartPosition == null || !mounted)
        return;

      _updateGridSize();
      final localPosition = getLocalPosition(details.globalPosition);
      if (localPosition == null) return;

      if (isPositionInGrid(localPosition, gridWidth, gridHeight)) {
        // 累加拖动距离
        accumulatedDx += details.delta.dx;
        accumulatedDy += details.delta.dy;

        bool moved = false;

        // 只在达到一个格子的距离时才移动
        if (accumulatedDx.abs() >= cellWidth) {
          int steps = (accumulatedDx / cellWidth).abs().floor();
          Direction direction =
              accumulatedDx > 0 ? Direction.right : Direction.left;

          for (int i = 0;
              i < steps && widget.gameState.canMove(direction);
              i++) {
            setState(() {
              handleMove(direction);
              moved = true;
            });
          }

          // 重置累计距离，保留未使用的部分
          accumulatedDx = accumulatedDx % cellWidth;
        }

        // 只在水平移动完成后才考虑垂直移动
        if (!moved && accumulatedDy.abs() >= cellHeight) {
          int steps = (accumulatedDy / cellHeight).abs().floor();

          if (accumulatedDy > 0) {
            for (int i = 0;
                i < steps && widget.gameState.canMove(Direction.down);
                i++) {
              setState(() {
                handleMove(Direction.down);
                moved = true;
              });
            }
          }

          // 重置累计距离，保留未使用的部分
          accumulatedDy = accumulatedDy % cellHeight;
        }

        // 更新起始位置
        if (moved) {
          dragStartPosition = localPosition;
        }
      }
    } catch (e) {
      print('Error in handlePanUpdate: $e');
    }
  }

  // 开始拖动
  void handlePanStart(DragStartDetails details) {
    try {
      if (widget.gameState.isGameOver) return;

      final localPosition = getLocalPosition(details.globalPosition);
      if (localPosition != null && mounted) {
        setState(() {
          dragStartPosition = localPosition;
          lastMoveTime = null;
          lastMoveDirection = null;
          // 重置累计距离
          accumulatedDx = 0;
          accumulatedDy = 0;
        });
      }
    } catch (e) {
      print('Error in onPanStart: $e');
    }
  }

  // 结束拖动
  void handlePanCancel() {
    try {
      if (!mounted) return;
      setState(() {
        dragStartPosition = null;
        lastMoveTime = null;
        lastMoveDirection = null;
        // 重置累计距离
        accumulatedDx = 0;
        accumulatedDy = 0;
      });
    } catch (e) {
      print('Error in handlePanCancel: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateGridSize();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        if (widget.gameState.isGameOver) return;
        try {
          final localPosition = getLocalPosition(details.globalPosition);
          if (localPosition == null) return;

          if (isPositionInGrid(localPosition, gridWidth, gridHeight)) {
            final column = (localPosition.dx / cellWidth).floor();
            final row = (localPosition.dy / cellHeight).floor();

            if (column >= 0 &&
                column < GameConfig.rowLength &&
                row >= 0 &&
                row < GameConfig.columnLength) {
              final index = row * GameConfig.rowLength + column;
              if (widget.gameState.currentPiece.position.contains(index)) {
                widget.onRotate();
              }
            }
          }
        } catch (e) {
          print('Error in onTapUp: $e');
        }
      },
      onPanStart: handlePanStart,
      onPanUpdate: handlePanUpdate,
      onPanEnd: (_) => handlePanCancel(),
      onPanCancel: handlePanCancel,
      child: SizedBox(
        width: gridWidth,
        height: gridHeight,
        child: GridView.builder(
          itemCount: GameConfig.rowLength * GameConfig.columnLength,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: GameConfig.rowLength,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            Color color = GameConfig.emptyBlockColor;
            int row = (index / GameConfig.rowLength).floor();
            int col = index % GameConfig.rowLength;

            // 检查当前方块
            if (widget.gameState.currentPiece.position.contains(index)) {
              color = GameConfig
                  .tetrominoColors[widget.gameState.currentPiece.type]!;
            }
            // 检查已落地的方块
            else if (widget.gameState.gameBoard[row][col] != null) {
              color = GameConfig
                  .tetrominoColors[widget.gameState.gameBoard[row][col]]!;
            }

            return Pixel(
              color: color,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(GameConfig.blockRadius),
                  border: Border.all(
                    color: color.withOpacity(0.5),
                    width: GameConfig.blockMargin,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
