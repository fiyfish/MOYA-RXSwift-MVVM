//
//  UIColor+Swift.swift
//  XunLei
//
//  Created by abc on 2020/10/20.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
/*
 throw的用户 在Swift里 错误用Error协议的类型的值来表示 Error是一个空的协议它唯一的功能就是告诉Swift编译器某个类型用来表示一个错误
 通常 我们使用一个enum来定义各种错误的可能性
 抛出一个错误用throw通过合理定义异常改进上述代码
 */
class throwDescribeType: NSObject {
    
    enum fileReadError:Error {
        case fileISNUll
        case fileNotFound
    }
    // throw 抛出错误的异常
    func reaFile(filePath:String) throws  -> String {
        
        if filePath == "" {
            
            throw fileReadError.fileISNUll
        }
        
        if filePath != "/eqewqeqeqeqwewq" {
            
            throw fileReadError.fileNotFound
        }
        
        return "123"
    }
 /*
    抛出异常后也就是异常出现后如何去处理了
     用throwing函数传递错误
     try？方式
     flatmap 会对数据进行揭包以及压平去获取到最后的数据值filter函数苏艾轩
     最终返回结果是一个可选类型如果出现了异常返回一个nil如果没有返回对应饿值不处理异常即一个可选值去处理当前的视图
     try！方式
     告诉系统该方法没有异常一旦出现了异常则会程序崩溃
     do catch 建议在do里面处理事物 catch里面
     var result = try？readfile(filePath:"abc"")
     var result = try! readfile(filePath:"abc")
     
     do{
    
       try readFile(filePath:"abc")
      
     }catch{

       print(error)
     }
     let prices = [20,30,40]
     let result = prices.filter({$0 > 25})
     print(result)
     let sum = prices.reduce(0){$0 + $1}
     let sum = prices.reduce(0){$0 + $1}
     print(sum)
     在这路一一进行数据加在一起
     defer 在方法中类似于 do catch finally里面的最后的要素再去添加一个defer就是如同上述所示无论在何种位置就是去使用defer去清理资源
     多个refer例子如下所示
     func foo(){
     print("1")
     defer {
       print("6")
     }
     print("2")
     defer {
       print("5")
     }
     print("3")
     defer{
      print("4")
    }
   }
    */
}
