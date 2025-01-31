import 'package:flutter/material.dart';

/// 游戏控制按钮组件
class GameControls extends StatelessWidget {
  final VoidCallback onMoveLeft;
  final VoidCallback onMoveRight;
  final VoidCallback onRotate;

  const GameControls({
    Key? key,
    required this.onMoveLeft,
    required this.onMoveRight,
    required this.onRotate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            onPressed: onMoveLeft,
            icon: Icons.arrow_back_outlined,
          ),
          _buildControlButton(
            onPressed: onRotate,
            icon: Icons.rotate_right_rounded,
          ),
          _buildControlButton(
            onPressed: onMoveRight,
            icon: Icons.arrow_forward,
          ),
        ],
      ),
    );
  }

  /// 构建控制按钮
  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
