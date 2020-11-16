//
//  SwiftLearnViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
typealias TesstBlock = () ->Any
typealias NameBlock = (String)->Any
//省略block里面的型参直接展示类型和返回在函数执行完成之后再去执行闭包操作用@escaping//可以逃逸否者不能让其逃逸@escaping非逃逸函数使用闭包要避免循环引用注意weak若饮类型总是可选类型打破类型对闭包的强引用之后对象销毁之后会自动只为nil
typealias ThreeBlcok  = (String,Int)->Void//在这里面去进行block的传值以及数据展示
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
    let array1:[Int] = [1,2,3]
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
    case hotPage
    case hoePage
    case hofPage
    case horPage
  }
  print(Surname.hotPage)
    
        
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
