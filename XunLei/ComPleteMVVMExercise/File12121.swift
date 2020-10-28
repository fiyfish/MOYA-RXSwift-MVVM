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
    var width = 0.0NYYN
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
iOS14引入了LimitPhotosLiBrary的概念用户可以授权应用访问其一部分的照片对于应用来说仅仅能读取到部分图片能让我们看到app对于用户隐私的钟总这仅仅是一部分PHAuthorizationStatusLimited如果未进行适配有可能会在每次触发相处功能时都进行弹窗询问用户是否是需要修改照片权限。
 iOS8 - iOS13 ，用户在不同的网络间切换和接入时，mac 地址都不会改变这也就使得网络运营商还是可以通过 mac 地址对用户进行匹配和用户信息收集，生成完整的用户信息。iOS14 提供 Wifi 加密服务，每次接入不同的 WiFi 使用的 mac 地址都不同。每过 24 小时，mac 地址还会更新一次。需要关注是否有使用用户网络 mac 地址的服务。
 iOS14 中，读取用户剪切板的数据会弹出提示这个获取粘贴板信息的时候会出现一个新的粘贴提示代码
 WiFI地址 用户mac地址是不变的 Wi-Fi Address通过这个地址去获取到 用户可以选择是否让当前选择是否开启 private WIFI address去进行适配
 相机和麦克风 会出现小黄点/小旅店这个跟开发关系不大
 IDFA 广告表示符 用于标记用户目前最广泛的用途是用于投放广告个性化推荐等
 在iOS13及以前系统会默认为用户开启允许追踪设置我们可以通过简单的通过代码去获取到IDFA标识符。
 在iOS14中系统默认会为我们关闭广告表示符 如果想要去进行这个操作需要去进行申请在开发过程中在info.plist中配置在用户拒绝的情况下可以考虑接入apple的SKADNetwork框架进行广告分析
在app下载之前就要去知道这些app需要那些用户权限目前app上架要求引用子啊上架时都必须提供一份隐私政策如果引入了第三方收集用户信息的sdk都需要向apple说明这些信息的用途是干什么的
 这些都是为了保证app用户在使用app的过程中对自己的安全信息更加安全
 礼物分为gif/svga/连击礼物/进场坐骑/全场横符/礼物选中动画/链接礼物/进场旋转动画等等就是通过这些去进行动画的播放
 svga这是第一种//gif动态图这是第二种
 链接礼物
 */
