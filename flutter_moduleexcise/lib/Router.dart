import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moduleexcise/MaterialAndScoffold.dart';
import 'package:flutter_moduleexcise/main.dart';
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //路由器跳转
    return MaterialApp(
      title: "flutter APP",
      theme: ThemeData(
          primarySwatch: Colors.black
      ),
      home: MyHomePage(),
      routes: {"weater":(context){return newMyHomePage();},"page2":(context){return newMyHomePage();}},
    );
  }
  /*
  在开发过程中创建无状态的控件可以使用stl
  有控件的可以使用stf
  不带参数的路由器跳转
  Navigator.of(context).pop({"result:successs"});
  Navigator.pushNamed(context,routerName);
  Navigator.pushNamed(context,'/weather',arguments:<String,String>{'city':'Berlin','country':'Germany'},);
  如果单张图片导入太麻烦可以一次性去导入一个文件夹在特定文件夹下导入特定的文章
   */
}
