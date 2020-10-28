//
//  SwiftLearnViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
typealias tesstBlock = () ->Any
typealias nameBlock = (String)->Any
//省略block里面的型参直接展示类型和返回在函数执行完成之后再去执行闭包操作用@escaping//可以逃逸否者不能让其逃逸@escaping非逃逸函数使用闭包要避免循环引用注意weak若饮类型总是可选类型打破类型对闭包的强引用之后对象销毁之后会自动只为nil
typealias threeBlcok  = (String,Int)->Void//在这里面去进行block的传值以及数据展示
class SwiftLearnViewController: UIViewController {
/*
   在swift中类型命名也有一些约定俗成的规则例如量值属性首字母小写 类名/枚举名/结构体名首字母会大写 如果非要使用预留的关键字进行命名可以使用‘进行包装[waek self]//[owner self]
  闭包///////核心作用1传值2方法回调全家函数没
   两种特殊的基本数据类型 一种是可选的数据类型分为元组类型和可选值类型元组可以刷新出一组特别多的数据类型而可选值类型是swift语言的又一大特带你通过可选值类型swift对数值为nil进行了严格把控
*/
    override func viewDidLoad() {
        super.viewDidLoad()
      let typeL:(String,String) -> String
      var type:(pencil:Int,eraser:Int,pencilCase:Int) = (2,1,15)
      var twoType:(type:Int,typeTwo:Int) = (2,2)
      var pen:(name:String,price:Int) = ("钢笔",2)
         var name = pen.name
         var price = pen.price
        var obj:String? = "HS"
        if let tmp = obj{
         print(tmp)
         }else{
          obj = "HS"
           print(obj!)
          }
//block
    
        typeL = {(num1,num2) -> String in

        return num1+num2
            
       }
//如果let tem = obj 如果满足着去打赢tem如果不满足着不执行下面的操作 optional类型是对普通类型的一种包装因此在使用的时候需要进行拆包处理 拆包的符号！？与！这2个操作符操作 ？可以出现在类型后面也可以出现在实例后面它出现在类型后面表示的是一种隐式解析的语法结构后面章节会有介绍出现在实例类型后面代表的是对optional类型进行拆包操作，则代表的是可选链的取别名typealias Price = Int var penPrice:Price = 100//?出现在类型后如string？表示的是可选类型出现在实例类型后表示的是可选链的掉用 ！出现在类后面表示默认隐式解析出现在实例后面表示强制拆包弱化指针的语言提供了String和Character类型来描述知府黄和字符 swift有3中数据结构 Array set nsdictary/////Array Set Dictionary 这3中数据类型结构 字符串的组合var d1 = "hello \(123)"-------------------------var d2 = "hello \(c2)"//"hello World""\()""\()"可以把其他数据类型转化为字符串类型并且插入字符串数据的响应位子"\()"Array///Set///Dictionary var array1:[Int]//var array2:Array<Int>array1 = []//array2 = Array() array1 = [1,2,3] array2 = Array(arrayLiteral:1,2,3) array1 = [] array2 = Array() array1 = [1,2,3] array2 = Array(arrayLiteral:1,2,3)
    for index in 0...3 {
    print(index)
    }
    for index  in 0..<3 {
    print(index)
    }
    for index  in  0...4 {
    print(index)
    }
    //在这里去什么0...3//0..<3去声明数据的类型展示
    var array1:[Int] = [1,2,3]
    var array2:[Int] = [2,3,4]
    array1.max()
    array1.min()
    var arra:NSMutableArray = ["1","2","3"]
    arra.add("4")
    arra.add("5")
    arra.add("6")
    arra.add("7")
    var twoArea:NSMutableArray
    var dic2:Dictionary<Int,String>
    if searchData(dataID: "1101").success {
        print(searchData(dataID: "1101").data)
     }
    enum Surname{
    case 张
    case 王
    case 力
    case 赵
  }
  print(Surname.力)
//返回值为元组类似都是参数名称:类型类和结构体也是通过点语法来进行对类实例进行数据复制 结构体不需要提供一个构造方法而类要去自己开发中去提供一个构造方法在init()构造方法中需要对完成的所有累中数据进行复制操作 swift闭包就是局部变量在离开作用与后被复制或者引用任然有效 就是一个代码块 可以作为参数也可以作为返回值 闭包分为逃逸闭包和非逃逸闭包 在函数执行完成之后在外部任然可以使用的是逃逸闭包不能被使用的是非逃逸闭包。数据类型的检查和转化需要使用is和as关键字子类型检查机制使得程序代码更加健壮安全 子类实力进行胡庆类型的检查可以检查成功 父亲实力进行子类型的检查不可以检查成功as类型转化是两种as！///as？是一种比较安全的转换方式其结果是Optioanal值如果转化类型成功则为原实力如果转化类型失败着为nil as！是一种强制转化方式其默认此次转化异义迪昂会成功。
    
        
          if let tmp = myFunction4(param: 101){
            
                print(tmp)
            }
        
        func myfunc(param:Int)->Int{
        
        return param*param*param
        
        }
// 闭包的实现方式
       let myClosures = {(param:Int)  in
             
        return param*param
      }
    //如果有闭包类型即return可以将 return后面的值省略只用in类型的数值
    //算法实际上是一个特定的算法映射自变量的改变引起应变量的改变在编程中函数的实质是是完成特定功能的代码快只不过该代码块有一个名称开发着可以通过函数名称来调用函数完成特定的需求和功能，闭包与函数 在oc中/swift中闭包和函数之间有着密不可分的关系函数是有名称的功能代码块 闭包在大多情况是没有名称的功能代码块在语法结构上闭包和函数也有很大的差异由于对闭包语法的支持Swift语言更加强大而灵活 func methodName(param1,param2...)->returnValue{实现部分}//func methodName(param1,param2..)->returnValue{实现部分}闭包的代码结构如下所示标准结构{(参数类型)->返回值你闭包体}
    // Do any additional setup after loading the view.{(param:Int) ->Int in 返回值的执行过程如下所示}
    }
   
   func myFunction4(param:Int) ->Int?{
   
       guard param > 100 else{
   
        return nil
   }
     return param - 100
   }

    func searchData(dataID:String)->(success:Bool,data:String){
    
     let result = true
      let data  = "数据实体"
      return(result,data)
    }
    
    func seartwoData(dada:Int) ->(one:String,type:Int){
    return("1",3)
    }
    func name () -> Void {
    
    print("111111111")
    
    }
    /*
     swift闭包是一种高级语法其核心是使其中的局部变量被复制和引用使这些变量离开作用与后任然有效
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
