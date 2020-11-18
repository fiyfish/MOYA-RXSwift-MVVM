//不得在Stl中声明非final的变量Widger内部的变量一定要加上final声明来避免歧义
import 'package:flutter/material.dart';

class DemonPage extends StatefulWidget {
  @override
  _DemonPageState createState() => _DemonPageState();
}
class _DemonPageState extends State<DemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("text"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: Colors.white,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Container(
            child: Text("eqeqewq'"),
          ),
        );
      }),
    );
  }
}
