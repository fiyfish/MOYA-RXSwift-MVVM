//
//  File.swift
//  XunLei
//
//  Created by abc on 2020/10/23.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
/*
 
 for var i = 0;i<5;i++{
 
 print("Hello")
 
 }
 //for i in 0...4{//..<//...不包含后者包含全部 for i in 0...4///0..<4
 for i in 0...4{
 
 print("Heello")
 
 }
 swift中Struct是值类型的 class是引用类型的因此文字一这两类来阐述文章
 值类型放在栈区
 引用类型放在堆区
 class RectClass{
    var height = 0.0
    var width = 0.0
 }
 struct RectStruct{
 //语意
    var height = 0.0
    var width = 0.0
 }
 var rectCls = RectClass()
 var rectStrct = RectStruct()
 值类型即每个实例保持一份数据拷贝
 在swift中值类型有struct/enum/tuple都是值类型tuple 元组
 swift中值类型的拷贝是深考呗寓意即新对象和源对象都是独立的当改变新对象饿属性时源对象不会收到影响反之同理。
 而我们平时使用的Int/Double/Float/String/Array/Dictionary/Set其实都是用结构体来实现的也是值类型//
 struct CoordinateStruct{
 var x:Double
 var y:Double
 }
 var coordA = CoorDinateStruct(x:0,y:0)
 var coordB = coordA
 coordA.x = 100.0
 let coodc = CoordinateStruct(x:0,y:0)
 //Wrong:Coordc.x=100.0
 引用类型即所有实例共享一份数据拷贝
 在Swift中class和闭包都是引用类型引用类型的胡值是浅拷贝引用语意即新对象和源对象的变量名不同但其引用指向的内存空间是一样的因此当使用新对象操作内部数据时源对象的内部数据也会受到影响。
 class Dog{
 
      var height = 0.0
      var weight = 0.0
 
 }
 var dogA = Dog()
 var dogB = dogA
 dogA.height = 50.0
 如果声明一个引用类型的常量那么就意味着该常量的引用不能改变即不能被捅类型变量复制但值内存中所存储的变量是可以改变。
 let dic = ["1":"a","3":"c","2":"b"]
 let result = dic.sort{$0.0<$1.0}
 let dic = dic.sort{$0.1<$1.1}
 这里不能直接使用>或者<去实现我们最终的效果值
 */
