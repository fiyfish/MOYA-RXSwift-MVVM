//
//  MailListViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import WebKit
import SocketIO
protocol pet {
    init(name :String)// 指定构造函数
}
//如果一个类继承了某个类而且尊贵送一个或者多个协议我们应该吧父类放在最前面然后依次用逗号排列 在swift中继承是单一的但是满足的协议可以满足很多个这个时候将父类放在最前面协议依次放在后面去满足开发协议的继承聚合和关联类型

//构造函数的促使发
class Cat : pet{
    
    var name:String = ""
     required init(name:String){
    
        self.name = name
    }
}
//扩展协议的属性和方法 扩展一个已经存在的类型来采纳和遵守一个新的协议无需访问现有代码的类型扩展可以添加新的属性方法和下表到已经存在的类型中并且因此苏旭你添加的协议满足任何需求
extension CustomStringConvertible{
    
    var customDescription: String{
    return "YQ"+description
    }
}
protocol Student {
    var name:String{get set}
    var birthPlace:String{get set}
    static var qualification:String{get set}//通过static声明一个类型属性
    mutating func study()//
    static func hardStudy()//只声明函数不需要去实现
}
//满足one协议方法的类或者结构体枚举等等都必须要去声明Student中方法和one中应该有的属性以及方法的最终实现效果协议的聚合
/*
 typealias Three = TwoProtocol & OneProtocol
 func text(paramter:OneProtocol&TwoProtocol){}我们不管paramter什么类型参数只要他满足这个要求的协议即可去进行书写
 新协议和协议聚合在使用上的区别 不需要生产新的协议声明和使用在一个地方临时变量使用起来非常简单方便如何检查某个协议释放满足特别的协议使用is即可去
 struct Person:OneProtocol{}
 let p1= Person()
 if(p is Oneprotocol){print(""yes)}
 如何让定义的协议只被类满足使用class
 协议的关联类型指的是根据使用场景的变化如果协议中某些属性存在逻辑想通而类型不同的情况可以使用associatedtype为这些属性的类型声明关联属性
*/

protocol WeightCalculable {
    
    associatedtype WeightAType//可称重协议weight属性返回的是具体满足协议类型实例的重量

    var weight :WeightAType{get}
}
//类型管理在这里去动态的描述满足协议的对象所满足的协议类型
struct car :WeightCalculable {
    typealias WeightAType = Double
    var weight: WeightAType//weight是double类型的值
}
struct car1:WeightCalculable {
typealias WeightAType = Int
var weight: WeightAType
}
//协议的扩展 1，扩展协议的属性和方法
extension Student{

    func study(){
        
        print(name)//协议的扩展可以直接读取协议中的变量和方法名称在协议的扩展中将协议的方法实现掉然后就是简单的调用就ok了
    }


}

class pick:Student
{
    var name: String = ""
    
    var birthPlace: String = ""
    
    static var qualification: String = ""
    
    static func hardStudy() {
        print("2")
    }
    
}
protocol twoFour:class,Student {
// 只被类重视的协议
}
protocol one:Student {
    
    
}

struct Puple:Student {
    var name: String = ""
    var birthPlace: String = ""
    var show:String = ""
    static var qualification: String = "222"
    static func hardStudy() {//在祝颂协议的类/枚举/结构体中去书写方法的具体实现
         print("i want to study hard")
     }
     
    mutating func study() {
          print(" i study hard")
          self.name = "MOYA"
     }
}

class wuLianji:Student{

    var name: String = ""
    var birthPlace: String = ""
    var show:String = ""
       static var qualification: String = "222"
       static func hardStudy() {//在祝颂协议的类/枚举/结构体中去书写方法的具体实现
            print("i want to study hard")
        }
        
      func study() {
             print(" i study hard")
             self.name = "MOYA"
        }

}
//内存泄漏第一种记得去释放掉对象 在试图下面要标记出dealloc/deinit方法的调用没有调用即说明存在这个对象未被释放掉存在错误 非逃逸闭包的生命周期把闭包当作参数传递给函数 函数中调用闭包 退出函数 闭包生命周期结束即非逃逸闭包的生命周期与函数相同 逃逸闭包 执行函数 函数结束调用闭包仍被其他对象持有不会在函数结束时候释放。非逃逸闭包/逃逸闭包
class MailListViewController: UIViewController{
    var array:NSMutableArray!
    var dict:NSMutableDictionary!
    var copyArray:Array<String>!
    var setE:Set<String>!
    var twoCopyDict:Dictionary<String,String>!
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var p1 = Puple(name: "11111", birthPlace: "111111", show: "1212121")
        Puple.qualification = "eqeqeqeq"
        p1.study()
        let p = pick.init()
        pick.hardStudy()
        Puple.hardStudy()//static 申明是实例属性和方法还是具体的属性和方法
        let s1 : Student = p1//并不能去进行不存在协议中的单元设置一个合理的值类型
        var dict = ["1":"test","2":"twoTest","3":"threeTest"]
        self.array = NSMutableArray.init()
        self.setE = ["1","1","1","1"]
        var one:[Int:String] = [1:"eqeqwe",2:"eqeqeqeq",3:"eqeqweqeqweqeq"]
        //Int类型也可以作为字典的key和value去进行修改元组返回修改
        var eeweq:[String:Int] = ["eqeqeq":1,"eqeqe112q":2,"eqewqeqeq":3]//在这里进行代码的修改与完善操作去满足开发线
        let page = (1,20)
        let threeSrteng = (1,"12121",[1,2,3,4],["1":"2","3":"4","5":"6","7":"8"])
        print(threeSrteng)
        self.copyArray = ["1","2","3","4","5"]
        let favorites : Set<String> = ["红色","红色","蓝色"]
        var stringCode = "1990"
        var pageString = Int(stringCode)
        var twoPageString = Float(stringCode)
        var threePageString = Double(stringCode)
        var fourPageString = Double(stringCode)//类名+()+字符传转特定类型数字
        var val4 = "25.0";
        let count = Double(val4);
        print("\(2)")
        print("\(12121212)")//数字等直接抓String类型
        print(favorites)//自动过滤掉set里面重复的元素
        self.dict = ["1":"2","2":"3"]
        self.array.add(0)
        self.array.add("1")
        self.array.add("2")
        self.array.add("3")
        self.array.add("4")
        self.dict = NSMutableDictionary.init()
        self.dict.setValue("two", forKey: "2")
        self.dict.setValue("one", forKey: "1")
        self.dict.setValue("three", forKey: "3")
        print(self.dict!)
        print(self.array!)//在这里进行可选值的展示
        let manager = SocketManager(socketURL: URL(string: "http://chat.socket.io/")!, config: [.log(true), .compress])
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        socket.on("eqewqeqe") { (arc, tex) in
            
            print("eqeqewqeqeqeqeqeqeqe")
        }
        socket.on(clientEvent: .disconnect) { data, ack in//尾
            
            print("socket disconnect")
        }
        
        socket.on("currentAmount") {data, ack in
            guard let cur = data[0] as? Double else { return }
            
            socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                socket.emit("update", ["amount": cur + 2.50])
            }
            ack.with("Got your currentAmount", "dude")
        }
         
        socket.connect()
        //NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"isTest"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func test(){
        
        print("11111111")
  }
    //元组作为参数和返回值
    func teeee(index:String) -> (page:Int,twpoPage:String) {
        
        let twopage = 1
        
        return(twopage,index)
    }
  
  //最后一步很重要记得去移除这些通知
   deinit{
        
     NotificationCenter.default.removeObserver(self)//iOS9之后系统会默认在deinit方法里面移除掉通知的事件
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
