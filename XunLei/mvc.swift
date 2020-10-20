//
//  mvc.swift
//  XunLei
//
//  Created by abc on 2020/10/14.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
/*
 model为源程序提独立的不依赖于view和controller子系统的数据模型
 view 展示数据的模型操作 将系统所获取的数据在view上面展示出来
 controller 在model和view之间添加一个Controller目的是去耦合即消除model和view之间的耦合性
 对cell进行沪指操作去进行代码展示操作和说明
 在开发过程中一般会忽略mvc框架的设定导致cell/view和数据模型model建立起了直接的数据关系把他们一一联系起来。
 使tableview显示的大了起来去显示我们想要展示的代码量并最终展示出来。
 我们日常写的代码就是m-vc总是将model和vc总结在一起进行代码的编写以及数据的展示出来
 mvvm的基本概念
 在MVVM中 view和ViewController正式联系在一起M/view/VM/view和VC正式联系在一起我们将它们视为一个组件去进行UI的操作
 view/viewController不能直接引用model而是应用试图模型viewModel
 viewModel使一个放置用户输入验证逻辑视图表示逻辑发起网络请求和其他代码的地方
 使用mvvm会增加代码量但是总体上减少了代码的复杂性
 MVVM的注意事项
 view引用viewModel但是反过来不行即不需要在viewmodel中加入ui操作任何视图的操作都不应该放在viewModel中(ps:基本要求必须满足)
 viewModel引用model，但是反过来不行
 引用设置如下所示
 view中引用viewModel//但是viewmodel中不能引用view
 viewModle中引用model model中不能引用viewmodel接下来就是view和moddel直接的关系？
 独立开发 开发人员可以专心于业务逻辑和数据的处理viewmodel///设计人员可以专注于view/vc的开发
 可测试性即单元测试 通过界面是难于测试的而mvvm是专门针对viewModel来进行代码测试的
 举个简单的操作例子你在mvc模式下点击一个按钮进行一个复杂的逻辑操作而你想去对这个复炸的逻辑单元进行数据操作这个时候不能一直去点击进行操作//
 开发速度而言如果你想更快的将项目做处理那就使用cocoamvc这个会让你更快的去使用mvc这个框架
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

