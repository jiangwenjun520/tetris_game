import 'package:flutter/material.dart';

/// Pixels 类 - 表示游戏中的单个像素方块
/// 用于渲染游戏中的每个小方块，包括方块本身和背景格子
class Pixels extends StatelessWidget {
  /// 方块的颜色
  /// 可以是具体的颜色值或空（用于背景格子）
  final Color color;

  /// 构造函数
  /// [color] - 方块的颜色，必须提供
  const Pixels({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // 设置方块的样式
        decoration: BoxDecoration(
            // 使用传入的颜色
            color: color,
            // 添加圆角效果，使方块看起来更美观
            borderRadius: BorderRadius.circular(4)),
        // 在方块周围添加小边距，创建网格效果
        margin: const EdgeInsets.all(1),
      ),
    );
  }
}
