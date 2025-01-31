// 导入Flutter的核心UI包
import 'package:flutter/material.dart';
// 导入自定义的主页面组件
import 'package:Tetris_Fan/Screens/home_page.dart';

/// 应用程序的入口点
/// 初始化并运行Tetris游戏应用
void main() {
  runApp(TetrisGame());
}

/// TetrisGame 类 - 应用程序的根组件
/// 继承自StatelessWidget，因为不需要管理状态
class TetrisGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // 应用程序标题，显示在任务管理器中
      title: 'TETRIS Game',
      // 移除右上角的debug标签
      debugShowCheckedModeBanner: false,
      // 设置应用的首页为HomePage组件
      home: HomePage(),
    );
  }
}
