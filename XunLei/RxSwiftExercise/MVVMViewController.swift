//
//  MVVMViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/14.
//  Copyright © 2020 abc. All rights reserved.
//
// RxSwift一般的练习写法并展示出来
import UIKit//View
import SnapKit
import ReactiveObjC
import RxSwift
import RxCocoa
/*
 热信号是主动的 不管有没有订阅者他都会启动如果发送当时有订阅者就会同时接受到信号 如果没有就不会接受不了到信号给订阅者发送消息不一定会收到他可以有多个订阅者是一对多集合可以与订阅者共享信息。
 冷信号是被动的只有当你订阅的时候他才回启动当有不同的订阅者消息是重新完整发送到订阅者用户。
 */
import enum Result.NoError//上面这一块的4个类要一起倒入并进行数据的编写
class MVVMViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate{
    var textFeild:UIScrollView!
     let disposeBag = DisposeBag()
    var uitextFeild:UITextField!
    var twoUitextFeild:UITextField!
    var viewModel:PeopleSHow!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.textFeild = UIScrollView.init(frame: CGRect(x: 0, y: 30, width: SCREENWIDTH, height: 60))
        self.textFeild.backgroundColor = UIColor.black
        self.textFeild.contentSize = CGSize(width: 800,height: 400)
        self.textFeild.delegate = self
        self.view.addSubview(self.textFeild)
        self.view.addSubview(oAuthLoginButton)
        self.uitextFeild = UITextField.init()
        self.view.addSubview(self.uitextFeild)
        self.uitextFeild.backgroundColor = UIColor.purple
        self.uitextFeild.delegate=self
        self.uitextFeild.frame = CGRect(x: 0, y:100, width:SCREENWIDTH, height:90)
        self.twoUitextFeild = UITextField.init()
        self.view.addSubview(self.twoUitextFeild)
        self.twoUitextFeild.backgroundColor = UIColor.purple
        self.twoUitextFeild.delegate=self
        self.twoUitextFeild.frame = CGRect(x: 0, y:200, width:SCREENWIDTH, height:90)
        self.twoUitextFeild.rx.text.orEmpty.map{$0.count >= 5}.bind(to: oAuthLoginButton.rx.isHidden).disposed(by: disposeBag)
        //在这里进行函数的响应式编程 第一步 函数式编程 第二部 响应式编程 大概意思如下 我们通过不同的函数构建所需的数据队列 然后通过适当的方式去响应这个方法 这就是函数响应式编程。
        //在rx上有一个比较重要的概念就是绑定数据绑定即订阅就是指可监听程序绑定到观察者身上就是绑定/订阅就是观看属性。
        
        let usernameValid =  self.uitextFeild.rx.text.orEmpty
       .map { $0.count >= 5 }
       .share(replay: 1)
        
        let twoPage = self.twoUitextFeild.rx.text.orEmpty.map { $0.count <= 1
        }.share(replay: 1 )
        //这个语法糖写起来很方便简单易用
        let everythign = Observable.combineLatest(usernameValid, twoPage){$0&&$1}.share(replay: 1)
        
        let twoEvetThign =  Observable.combineLatest(usernameValid,twoPage, everythign){$0||$1||$2}.share(replay:1)
         twoEvetThign.bind(to: self.textFeild.rx.isHidden).disposed(by: disposeBag)
         viewModel = PeopleSHow(username: self.uitextFeild.rx.text.orEmpty.asObservable(), password: self.twoUitextFeild.rx.text.orEmpty.asObservable()
          )
         viewModel.usernameValid.bind(to: oAuthLoginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.passWordValid.bind(to: textFeild.rx.isHidden).disposed(by: disposeBag)
        //viewModel.everythingValid.bind(to: twoUitextFeild.rx.isEnabled).disposed(by: disposeBag)
        viewModel.everythingValid.observeOn(MainScheduler.instance).bind(to: twoUitextFeild.rx.isHidden).disposed(by: disposeBag)
        //将获取到的返回值绑定到列表的数据源操作然后去进行数据更新操作
        //在这里去进行两者关系的验证 与/或/非去进行代码的验证实现的逻辑//combineLatest链接两个判断条件去进行后门的{进行逻辑验证}
        
//        let nickNameValid = self.uitextFeild.rx.text.orEmpty
//        .map { (text) -> Bool in
//            let tLength = text.count//获取字符串的长度
//        return tLength >= 3 && tLength <= 10
//        }
//        .share(replay: 1)
//        //根据获取到的状态去进行其他2个元素的状态显示与否
//        nickNameValid.bind(to: self.textFeild.rx.isHidden).disposed(by: disposeBag)
//        nickNameValid.bind(to: oAuthLoginButton.rx.isEnabled).disposed(by: disposeBag)
        
         //按钮的rxswift响应式编程的代码
        oAuthLoginButton.rx.tap.subscribe(onNext: { (next) in
            
            print(next)
            
        }, onError: { (error) in
            
            print(error)
            
        }, onCompleted: {
            
            print("完成操作的第一步")
            
        }, onDisposed:nil).disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
        //在这里进行当前属性的描述并将属性展示出来
        self.textFeild.rx.contentOffset.subscribe(onNext: { (contentoffsize) in
            
            print(contentoffsize)
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }, onDisposed: nil).disposed(by: disposeBag)
        
 //通知的书写方法去进行代码验证
        
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification).subscribe(onNext: { (notification) in
            
            print("enter backView")
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
         }, onDisposed: nil).disposed(by: disposeBag)
       //Observer//Observable即使Observer又是Observable这种变量subject
        //对UI时间进行绑定操作如下 homeViewmodl.loading.bind(to:self.rx.isAnimating).disposed(by:disppseBag)true//false只有true/false 通过某个值的变化去绑定某个视图的显示与否去进行动画的显示并最终将结果显示出来
        let helloworld = Observable.just("hello rx world")
        let twoHelloWorld = Observable.of(0,1,2)
        let sictSequence = Observable.from([1:"he11o",2:"World"])
        //观看这些
        helloworld.subscribe(onNext: { (page) in
            
         print(page)
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }).disposed(by: disposeBag)
  //在RX世界中 对于每一个Observable 都是由3种可能的枚举组成 .next/onNext(value:T)/.error(error:Error)/.completed
  //在这个三块进行事件的书写和编辑 onNext 下一步执行的操作/// onError//数据类型// onComplete//完成 disposed//消失事件的处理
        
        
        
        
        
        
        
        
        
    }
    lazy var oAuthLoginButton: UIButton = {
        
        let view = UIButton.init(frame:CGRect(x:0, y:300, width: SCREENWIDTH, height:50))
        
        view.backgroundColor = UIColor.orange
        
        return view
    }()
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
