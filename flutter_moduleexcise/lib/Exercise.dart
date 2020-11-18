import 'package:flutter/material.dart';
import 'dart:async';
class DeMonWidget extends StatelessWidget {//无状态控件
  final String text;

  DeMonWidget(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Text(text ?? "这就无状态DEMO"),
    );
  }
}
class DemonFul extends StatefulWidget {
  final String text;
  DemonFul(this.text);
  @override
  _DemonFulState createState() => _DemonFulState(text);

}
class _DemonFulState extends State<DemonFul>{
  String text;
  _DemonFulState(this.text);
  @override
  void initState(){}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(text ??"这就是demon"),
    );
  }

}













