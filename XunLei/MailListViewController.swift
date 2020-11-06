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
//内存泄漏第一种记得去释放掉对象 在试图下面要标记出dealloc/deinit方法的调用没有调用即说明存在这个对象未被释放掉存在错误 非逃逸闭包的生命周期把闭包当作参数传递给函数 函数中调用闭包 退出函数 闭包生命周期结束即非逃逸闭包的生命周期与函数相同 逃逸闭包 执行函数 函数结束调用闭包仍被其他对象持有不会在函数结束时候释放。非逃逸闭包/逃逸闭包

class MailListViewController: UIViewController{
    var array:NSMutableArray!
    var dict:NSMutableDictionary!
    var copyArray:Array<String>!
    var setE:Set<String>!
    var twoCopyDict:Dictionary<String,String>!
    override func viewDidLoad() {
        super.viewDidLoad()
        var dict = ["1":"test","2":"twoTest","3":"threeTest"]
        self.array = NSMutableArray.init()
        self.setE = ["1","1","1","1"]
        var one:[Int:String] = [1:"eqeqwe",2:"eqeqeqeq",3:"eqeqweqeqweqeq"]
        //Int类型也可以作为字典的key和value去进行修改元组返回修改
        var eeweq:[String:Int] = ["eqeqeq":1,"eqeqeq":2,"eqewqeqeq":3]//在这里进行代码的修改与完善操作去满足开发线
        let page = (1,20)
        self.copyArray = ["1","2","3","4","5"]
        let favorites : Set<String> = ["红色","红色","蓝色"]
        print(favorites)//自动过滤掉set里面重复的元素
        self.dict = ["1":"2","2":"3"]
        self.array.add(0)
        self.array.add("1")
        self.array.add("2")
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
        
    NotificationCenter.default.removeObserver(self)
        
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
