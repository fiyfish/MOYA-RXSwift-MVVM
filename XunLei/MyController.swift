//
//  MyController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
//import RealmSwift
class MyController: UIViewController {
    var onebutton : UIButton!
    enum fileGet:Error {
        case addressError
        case getNoData
     }
    override func viewDidLoad() {
         super.viewDidLoad()
         /*
         空合运算符 ?? 如果 ？？ 号前面的值不为nil者将??前面的值解包返回否则取??取后面的值即时返回的值
         */
         var type:String? = "two"
         let pick = type ?? "one"
         print(pick)
         var p = 3>2 ? 1:5
         print("\(p)")
         var result = try? readFile(file: "e1ee121")//try?返回的值解析可能为nil也可能存在值
         var result1 = try!readFile(file: "eqeqeqeqeqe")//try!//try!返回的值进行强制解析最终返回一个值do/catch
        //抛出异常后也就是异常出现后如何处理用throwing函数传递错误
        //try？方式最终返回一个可选值如果出现异常则返回一个nil没有异常则返回对应的值不处理异常
        //try！强制解析告诉该方法那样异常一旦出现异常则程序会自动崩溃
        defer {
            print("处理最后释放的资源数据")
        }
        //搬砖者的思维逻辑1.它是干嘛的 2.它在什么情况下用 3.它有什么别人取代不了的情况 4。使用它需要注意哪些细节问题
        //这就是一个搬砖者学习新知识的4问 这4个问题都搞明白了你才可以说你是一个合格的搬砖者。
        //RealmSwift能够让你以安全稳定苏旭的方式来高效编写引用的数据模型层例子如下数据模型的涂层如下：
        /*
         class Dog:Object{
         @objc dynamic var name = ""
         @objc dynamic var age = 0
      }
      class person:object{
        @objc dynamic var name = ""
        @objc dynamic var picture:data? = nil//支持可空值
        let dogs = List<Dog>()
        }
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog:\(myDog.name)")
        let realm = try!.Realm()
        let puppies = realm.objects(Dog.self).filter("age<2")
        try.realm.write{
        realm.add(myDog)
        }
        带有后台刷新功能的realm文件在ios8及其以上的平台中当设备锁定之后引用哪的文件会自动倍NSfileProtection所加密如果您的应用试图在设备锁定且realm文件的nsfileProtection属性属性被设置为苏旭机密的情况下去执行设计到realm操作的话就会曝出一个open()failed：opreation not permittted的异常
         为了解决这个问题父类的config文件夹中则将确定所有相关得Realm文件无论是何时创建的都应该有此属性配置
        let realm = try! realm()
        let folderPatg = realm.configuration.fileURL!.deletingLastPatg.path//在父类文件目录中关闭文件保护操作
        puppies.count// =>1
        DispatchQueue(label:"background").async{autoreleasepool{letrealm = try! realm() let theDog = realm.objects(Dog.self).filter("age == 1").first try! realm.writer{theDog!.age = 3}}}子线程异步帅
        let realm = try! Realm()
        try! realm.writer{
         realm.add(myDog)//这将会初始法出一个默认Realm数据库 let realm = try！Realm()//try! Realm()
         }
         try!.realm.writer{
         author.name = "thoms Pynchon"
         }
         try! realm.writer{
         realm.add(myDog)//Realm数据库Realm.configuration的对象实例Realm.configuration//configuration对于本地的Realm数据库而言可以配置Realm文件在磁盘上的路径
         }
         */
        //此段代码位于 application(application:didFinishLaunchingWithOptions:)
        // let puppies = realm.objects(Dog.self).filter("age<2")
        //puppies.count
        // class Person : Object{
       // @objc dynamic var fullName = ""
        //@objc dynamic var age = 0
        // let realm = try! Realm()
        //}
        //try!.realm.writer{realm.create(Dig.self,value:["name":"Fido","age":1])}
        //let realm = try! Realm()
        // try! realm.write{realm.create(book.self,value:["id":1,"price":9000],update:true)try!.realm,writer{realm.delete(cheeseBook).try!.realm.write{realm.deleteAll()}}}
        //let dogs = realm.objects(Dog.self)//从默认的Realm数据库中遍历所有的Dog对象
        //var tanDogs = realm.objects(Dog.self).filter("color = 'tan' AND name BeGINSWITH 'B'")
        // tanDogs = realm.objects(Dog.self).filter(Predicate)//在这里去进行条件的处理满足条件
        //print(realm.configuration.fileURL!)
       // Do any additional setup after loading the view.
    }
    
    func readFile(file:String) throws -> String{
    
       if file == ""{
            
        throw fileGet.addressError
     
        }
        
        if file == "11"{
            
            throw fileGet.getNoData
        }
        
        return "123"
    }
/*
移动端数据库的常见操作如下
     1，属性重命名在更新的时候会在appdelegatedidfinshedLaunching中存一个版本号将版本号+1即可这个时候realm会自动监测新增加和需要删除得属性然后自动更新硬盘上的数据库结构移除属性的数据会被删除。等等这一系列的相当于本地数据库进行版本升级之后对应的本地所有的数据库更新升级。
     2，需要保留之前的数据并更新新属性的值再属性变化后将属性的值加1并将config改为如下其余不变并将oldObject之中的值取出放入新的newobject对应的属性中去
     
     3，属性名称的替换之前版本号+1然后把两者属性值一一对应替换一下就可以满足将关键属性值字体替换就可以满足开发者需求
    
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
