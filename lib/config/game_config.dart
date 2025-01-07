import 'package:flutter/material.dart';
import 'package:Tetris_Fan/TetrominoShapes/shapes.dart';

/// 游戏配置类
/// 集中管理所有游戏相关的常量和配置
class GameConfig {
  // 私有构造函数，防止实例化
  GameConfig._();

  /// 游戏面板尺寸
  static const int rowLength = 10; // 列数
  static const int columnLength = 15; // 行数

  /// 游戏刷新率（毫秒）
  static const int frameRate = 1200;

  /// UI配置
  static const double blockRadius = 4.0; // 方块圆角
  static const double blockMargin = 1.0; // 方块边距
  static const double fontSize = 20.0; // 默认字体大小
  static const double titleFontSize = 30.0; // 标题字体大小

  /// 颜色配置
  static const Map<TetrominoShapes, Color> tetrominoColors = {
    TetrominoShapes.L: Color(0xFFFFA500), // 橙色
    TetrominoShapes.J: Color(0xff045AFA), // 蓝色
    TetrominoShapes.I: Color(0xFFE80B93), // 粉色
    TetrominoShapes.O: Color(0xFFFFff00), // 黄色
    TetrominoShapes.S: Color(0xFF12C800), // 绿色
    TetrominoShapes.Z: Color(0xFFEE0000), // 红色
    TetrominoShapes.T: Color(0xFF901ABE), // 紫色
  };

  /// 游戏背景色
  static final Color backgroundColor = Colors.black;
  static final Color emptyBlockColor = Colors.grey.shade900;
  static final Color defaultBlockColor = Colors.grey;

  /// 按钮样式
  static const Color buttonBackgroundColor = Color(0xffD9D9D9);
  static const Color buttonTextColor = Colors.black54;
  static const double buttonFontSize = 40.0;
}
