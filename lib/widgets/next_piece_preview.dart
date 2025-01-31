import 'package:flutter/material.dart';
import 'package:Tetris_Fan/TetrominoShapes/pieces.dart';
import 'package:Tetris_Fan/pixels.dart';

/// 下一个方块预览组件
class NextPiecePreview extends StatelessWidget {
  final Piece nextPiece;
  final double size;

  const NextPiecePreview({
    Key? key,
    required this.nextPiece,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 16, // 4x4 网格
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          // 计算相对位置
          final relativePositions = nextPiece.getRelativePositions();
          final row = (index / 4).floor();
          final col = index % 4;

          // 检查是否是方块的一部分
          if (relativePositions
              .any((pos) => pos.dx == col - 1 && pos.dy == row - 1)) {
            return Pixels(
              color: nextPiece.color,
            );
          }

          // 空白格子
          return Pixels(
            color: Colors.transparent,
          );
        },
      ),
    );
  }
}
