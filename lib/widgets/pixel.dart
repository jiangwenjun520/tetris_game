import 'package:flutter/material.dart';

/// Pixel widget
/// 用于渲染游戏网格中的单个像素格子
class Pixel extends StatelessWidget {
  final Color color;
  final Widget? child;

  const Pixel({
    Key? key,
    required this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: child ?? Container(color: color),
    );
  }
}
