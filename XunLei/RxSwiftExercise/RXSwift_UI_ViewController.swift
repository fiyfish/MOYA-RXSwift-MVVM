//
//  RXSwift_UI_ViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/20.
//  Copyright © 2020 abc. All rights reserved.
//
//Rx对UI的所有属性/序列/的观察以及对这些事件的封装如下
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class RXSwift_UI_ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
   let disponseBag = DisposeBag()
    var nameTextFeild:UITextField!
    var textView:UITextView!
    var telephone:UITextField!
    var clickButton:UIButton!
    var listTableView:UITableView!
    let celleIDentider = XiBTableViewCell.self
    var listCollection:UICollectionView!
    public var tracks = PublishSubject<[Track]>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//按钮
        self.clickButton = UIButton.init(frame: CGRect(x: 0, y:0, width: 50, height: 50))
        self.view.addSubview(self.clickButton)
        self.clickButton.titleLabel?.textColor = UIColor.purple
        self.clickButton.backgroundColor = UIColor.red
        self.clickButton.rx.tap.subscribe(onNext: { (next) in
            
        print("11111111111")
            
        }).disposed(by: disponseBag)
        
        self.nameTextFeild = UITextField.init(frame: CGRect(x: 0, y: 50, width: 100, height: 40))
        self.nameTextFeild.layer.borderColor = UIColor.black.cgColor
        self.nameTextFeild.layer.borderWidth = 1.0
        self.nameTextFeild.delegate = self
        self.view.addSubview(self.nameTextFeild)
        self.nameTextFeild.delegate = self
        
        self.telephone = UITextField.init(frame: CGRect(x: 0, y: 90, width: 100, height: 40))
        self.telephone.layer.borderColor = UIColor.black.cgColor
        self.telephone.layer.borderWidth = 1.0
        self.telephone.delegate = self
        self.view.addSubview(self.telephone)
        self.telephone.delegate = self
        /*
         UItextView封装了一下几个委托回调方法
         didBeginEditing
         didEndEditing
         didChange
         didchangeSelection
         */
        self.textView = UITextView.init(frame: CGRect(x: 0, y: 140, width: 250, height: 200))
        self.textView.delegate = self
        self.view.addSubview(self.textView)
        self.textView.backgroundColor = UIColor.black
        
        self.listTableView = UITableView.init(frame: CGRect(x: 0, y: 340, width:SCREEN_WIDTH, height:800))
        self.view.addSubview(self.listTableView)
        self.listTableView.backgroundColor = UIColor.yellow
        self.listTableView.rowHeight = 100;
        self.listTableView.register(UITableViewCell.self, forCellReuseIdentifier:"identifier")
//tableview
        
        getModelData().bind(to: self.listTableView.rx.items(cellIdentifier:"identifier",cellType: UITableViewCell.self)){ (row,Track,cell) in
            
           cell.textLabel?.text = Track.name
            
        }.disposed(by: disponseBag)
        
        self.listTableView.rx.itemSelected.subscribe(onNext: { (next) in
                 
          print("111111111")
                 
        }).disposed(by: disponseBag)
        
//获取编辑的值
        self.nameTextFeild.rx.text.orEmpty.subscribe(onNext: { (text) in
           // print(text)
        }).disposed(by: disponseBag)
//开始和结束编辑
        self.nameTextFeild.rx.controlEvent(.editingDidBegin).subscribe(onNext: { (next) in
            
            self.view.backgroundColor = UIColor.orange
            
        }).disposed(by: disponseBag)
    /*
       editingDidBegin 开始编辑功能
       editingchangeed 输入内容发生改变
       editingDidEnd 结束编辑
       editingDidEndOnExit按下return按钮结束编辑
       allEditingEvents包含前面所有编辑相关事件
    */
    //controlevent////didchange//didScroller//didBeginEditing
      self.nameTextFeild.rx.controlEvent(.editingDidEnd).subscribe(onNext: { (next) in
            
            self.view.backgroundColor = UIColor.white
            
            }).disposed(by: disponseBag)
        
        self.nameTextFeild.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { () in
            
            print("点了return按钮")
            
         }).disposed(by: disponseBag)
        
   /*Throttling的作用 throttling是rxswift一个很有用的属性 当一些属性改变时会做大量的逻辑运算操作而使用Throttling属性不会产生大量的逻辑运算而是以一个小的合理弧度去执行比如一些时时搜索功能这个属性就很有用处
    在日常实践开发中我们会经常用到一个高级函数 就是asDriver 而asDriver函数涉及到一个类Driver driver可以说是最复杂的trait它的目标是提供一种简单的方法在UI层编写响应式代码
         如果我们的序列满足一下条件就可以用 不会产生error/一定会在主线程监听 MainScheDuler/共享状态变化
         share会将观察者共享序列),同时把序列放到主线程去，同时检测error事件。序列和观察者同步在主线程同时检车error任务日志
          flatMap/map 过滤 可以把高维数组变成地位数组/没有可选值去进行选择///
         */
        
        let pageShow = self.nameTextFeild.rx.text.orEmpty.asDriver().throttle(1)
        //获取到一秒之后输入的字然后进行操作
        pageShow.drive(self.clickButton.rx.title()).disposed(by: disponseBag)
        //drive相当于blindTo 绑定通过map对当前的操作然后进行下一步操作去满足开发
        pageShow.map{"\($0.count)"}.drive(self.clickButton.rx.title()).disposed(by: disponseBag)
        pageShow.map{$0.count > 5}.drive(self.clickButton.rx.isEnabled).disposed(by: disponseBag)
        // Do any additional setup after loading the view.
        Observable.combineLatest(self.nameTextFeild.rx.text.orEmpty,self.telephone.rx.text.orEmpty){$0.count>5&&$1.count>5}.bind(to: self.clickButton.rx.isHidden).disposed(by: disponseBag)
     //观察两者之间的变化并最终将结果返回到某一个值类型的变化。
        
         self.textView.rx.didBeginEditing.subscribe(onNext: { () in
            print("开始编辑")
            }).disposed(by: disponseBag)
        
        self.textView.rx.didChange.subscribe(onNext: { (next) in
            
            print("eqeqeqweqeq")
            
            }).disposed(by: disponseBag)
        
        self.textView.rx.didScroll.subscribe(onNext: { () in
            
            print("scroller")
            
            }).disposed(by: disponseBag)
    }//视图向上滚动几个单位可以执行一些操作
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getModelData() -> Observable<[User]>{

        return Observable.just([
            User(name: "原始密码"),
            User(name: "新的密码"),
            User(name: "确认密码")
            ]
        )

    }
/*
    一些在工作在序列中的事务 一个Observable就是一个序列包含一些特殊功能其中之一也就是最重要的功能就是OBservables时异步的 是要经过一段时间的发射过程事件可以包含数值/如数字或一个自定义类型的实例也可以是我们公认的手势比如单机
     Observable发生next事物包含元素会一直执行///发送error事物终端或者发送complete事物中断一旦Observable被中断就不会发生事物。
   Obserable<T>这个类就是RX框架的基础我们可以趁他们为可观察序列它的作用就是可以异步的产生一系列的Event事件即一个OBservable<T>对象会随着时间推移发出event(element:T)这样一个东西
     而且event还可以携带数据类型它的泛型《T》就是用来指定这个Event携带的数据的类型
     有了可观察的序列我们还要有一个Obseve订阅者来订阅他这个订阅者才能收到OBservableT不时发出的event
     通过对事件的监测事件Event定义有3类如下 一个是Element/Error/Completed///case有3类事件处理去完成这个事情。
     我们可以看到Event就是一个枚举
     我们可以通过如下几种方法来创建一个 Observable 序列 下面样子我们显示为一个
     let observable = Observable<Int>.just(5)
     of()方法接受可变数量的参数必须是同类的参数
     该方法我们可以接受可变数量的参数必须是同类型的
     let observable = Observable.of("A","B","C")
     from()
     创建可变序列 observable<int>//
     创建观察者 blindTo/Subscibe就是通过这两种方法去进行对可变序列的观察
     创建观察者最直接的方法就是在obsevable的Subscribe方法里面直接去描述当前事物发生的方法需要及时做出响应。一般是通过onNext/onError/onCompleted这些闭包构建出来的
     在bind方法中创建
     下面代码我们创建一个定时生产所应的Observable序列并将序列不断显示在lable标签上
     blindTo//Subscribe
     相比较于这两者的区别
     blinder有一下2个特征就是最直接去处理UI上事件的
     一个是不会处理错误事件
     确保绑定都是在给定的Scheduler即线程上实现的默认是MainScheduler主线程上执行的
     一旦执行错误事件在调试环境下将执行fatalError在发布环境下将打印错误信息。
     binder在RxCocoa中的应用其实Rxcocoa中对许多的UI控件进行扩展时就是利用Biner将事件属性编程观察者比如UIcontrol+Rxswift中isEnable就是一个Observe。
*/
}
