//
//  HomeController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
//协议的书写与遵守协议的
protocol someProtocol{
    
}
protocol twoSSSrococol {
    
}//
protocol twoSSSSProtocol{

}//实现协议的方法在这里面去执行 通过扩展去帮某些类去实现最终的协议 extension UiviewController:ViewProperty{func printName(){}}通过扩展去实现这个协议本身没有实现的类的协议 协议是定义了一些规范属性方法 然后由一些类 结构体或者枚举来实现这些规范这一过程被称为满足了协议。主要分为以下几块 协议的基本原理 定义协议与实现协议 协议与构造器 结构体/类/枚举去实现满足协议的开发需求。满足多个协议的时候用，分开一般由父类线：然后是协议SomeProtoal，animation分离开来这是类的定义部分。定义协议与实现协议 协议可以定义类方法和实例方法使用static 协议定义方法名称但不做实现同时不能使用默认参数 mutating 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。swift与oc不一样 在oc中枚举只能玩int而swift中枚举可以是int/float/string/Bool等等 枚举的类型int/bool/string/float在这里去声明路的类型以及指令
/*
 enum Movement {
     case letf
     case right
     case top
     case bottom
 }
 
 enum Movement:Int {
     case left = 0
     case right = 1
     case top = 2
     case bottom = 3
 }
enum Movement:Int{
    case left = 0
    case right = 1
    case top  = 2
    case bottom = 3
 }
 枚举的关联值如下所示
 enum Trade{
      case Buy(stock:String,amount:Int)
      case Sell(stock:String,anount:Int)
  }
 let trade = Trade.Buy(stock:"003100",amount:100)
 switch trade{
 case .Buy(let stock,let amount);
 print("stock:\(stock,)")//说白了就是枚举中可以传递值去进行枚举的数据处理与展示效果
 }
 枚举的数据类型与枚举展示效果
 enum Device{
 case Ipad,iPhone,AppTv,AppWatch
 func introduced()->String{
 switch self{
    case  .ipad: return "ipad"
    case  .iphone return "iphone"
    case  .AppleWatch:return "appleWatch"
    case  .AppleTV:return "AppleTV"//枚举的方法说明数据展示枚举的效果值
 }
 }
 }
 */
class HomeController: UIViewController {
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
