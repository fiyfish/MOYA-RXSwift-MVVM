//
//  HomeController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
//协议的书写与遵守协议的
protocol someProtocol{
    
}
protocol twoSSSrococol {
    
}//
protocol twoSSSSProtocol{

}//实现协议的方法在这里面去执行 通过扩展去帮某些类去实现最终的协议 extension UiviewController:ViewProperty{func printName(){}}通过扩展去实现这个协议本身没有实现的类的协议 协议是定义了一些规范属性方法 然后由一些类
//结构体或者枚举来实现这些规范这一过程被称为满足了协议。主要分为以下几块 协议的基本原理 定义协议与实现协议 协议与构造器 结构体/类/枚举去实现满足协议的开发需求。满足多个协议的时候用，分开一般由父类线：然后是协议SomeProtoal，animation分离开
//是类的定义部分。定义协议与实现协议 协议可以定义类方法和实例方法使用static 协议定义方法名称但不做实现同时不能使用默认参数 mutating 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating
//关键字。实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。swift与oc不一样 在oc中枚举只能玩int而swift中枚举可以是int/float/string/Bool等等
//枚举的类型int/bool/string/float在这里去声明路的类型以及指令
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
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        let subject = PublishSubject<String>()
        subject.onNext("1111")
        subject.subscribe(onNext: { (next) in
        print(next)
        }).disposed(by: disposeBag)
        
        subject.onNext("222222")
        subject.onCompleted()//完成了
        subject.onNext("444")//完成之后再去发消息最后都只会发送compeleted在完成之后最后只会发这个完成事件
        let subjext = BehaviorSubject(value:"111")
        subject.subscribe(onNext: { (next) in
            
            print("12121212121212121212121")
            
            }).disposed(by: disposeBag)
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
        
        let subject1 = BehaviorRelay<[String]>(value: ["1"])
         
        //修改value值
        subject1.accept(subject1.value + ["2", "3"])
         
        //第1次订阅
        subject1.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
         
        //修改value值
        subject1.accept(subject1
            .value + ["4", "5"])
         
        //第2次订阅
        subject1.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
         
        //修改value值
        subject1.accept(subject1.value + ["6", "7"])
// 就是这里一次次添加到项目中然后将这些数字一次一次发送
// behaviorSubject需要一个默认出事值来创建当一个订阅者订阅他的时候这个订阅者会立即收到BehaviorSubjects上一个发出的event之后就更脂肪情况一下它也会接收到BehaviorSubject之后发出性的event
   //ReplaySubject 缓冲一下 将所需要的缓冲起来最近的2个当需要的时候完成也罢也会答应2个最新的订阅也会发送2个
   //BehaviorSubject 需要通过一个默认初始值来创建。当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的 event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
//beHaviorRelay是替代Variable出现的其本质上也是在Behavioursubject的封装所以必须要通过一个摸扔的值来进行创建。其哟哟一个accept方法可以用在上拉加载的时候去进行操作去将后面acceept
        
        subject.buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
//每缓冲3个元素则会组合到一起发出如果1秒内不够3个也会发出有几个就发几个一个都没有发空数组[])结果如下["a","b","c"]
//["1","2","3"][][][][][]/1s发一个event如果window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。同时 buffer
//要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。zip通常指的是当2个失误通常同时完成的情况下发生combinelaste将2哥何必任何依着发生改变就要去验证
     let disponse = DisposeBag()
        
     let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails.startWith("1").debug().catchErrorJustReturn("eqeqeqe").subscribe(onNext: { (next) in
            
         print("111111")//catchError 捕获错误并返回到一个最新的序列序列替换 retry(2)//重试2次（参数为空则只重试一次）
            
       }).disposed(by: disponse)
        //self.oneLable.rx.text//self.oneLable.rx.attributedText//attributed绑定
        //String(format: "%0.2d:%0.2d.%0.1d",
        //arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])
        // Do any additional setup after loading the view.
    
    
    let rxData = PublishSubject<Data>()
    
        rxData.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)).observeOn(MainScheduler.instance).subscribe(onNext: { (next) in
            
            //
            
            }).disposed(by: disponse)
    
//subscribeOn()决定序列在那个Scheduler上执行 observeOn()决定响应在那个线程上执行
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
