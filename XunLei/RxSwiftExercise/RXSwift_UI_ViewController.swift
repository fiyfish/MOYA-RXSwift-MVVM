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
class RXSwift_UI_ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    let disponseBag = DisposeBag()
    var nameTextFeild:UITextField!
    var textView:UITextView!
    var telephone:UITextField!
    var clickButton:UIButton!
    var listTableView:UITableView!
    var listCollection:UICollectionView!
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

}
