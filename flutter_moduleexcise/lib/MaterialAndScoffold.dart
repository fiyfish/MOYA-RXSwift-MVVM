import 'package:flutter/material.dart';
import 'package:flutter_moduleexcise/main.dart';

class Page extends StatefulWidget {
  _pageState createState() =>
      _pageState(); //MaterialApp是一个方便的Widget它封装了应用程序实现MaterialDesign所需要的一些Widget
} //Scaffold组件是Material Design布局结构的具体实现此类用于显示drawer snackBar和底部的sheet的API MaterialApp的child是Scaffold Widget

class _pageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    //Material or Scafold
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("title"),
      ),
      body: Text("eqeqweqeqeq"),
    );
  }
/*
MaterialApp属性介绍
navigatorKey导航键  gloBalKey<NavigatorState>
home主页 Widget
routes路由 Map<String,WidgetBuilder>
initialRoute初始路由 String
OnGenerateRoute生成路由 RouteFactory
onUnkownRoute未知路由 RouteFactory
builder Trans
title
color
naviagetorKey.currentState相当于Navigator.of(context)
*/
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new MaterialApp(
      home: new newMyHomePage(),
    );
  }
}

class newMyHomePage extends StatefulWidget {
  @override
  _newMyHomePageState createState() => _newMyHomePageState();
}

class _newMyHomePageState extends State<newMyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: new AppBar(
        title: Text("text"),
      ),
      body: Center(
        child: Text("home"),
      ),
    );
  }
}
