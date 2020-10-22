//
//  designBlindr.swift
//  XunLei
//
//  Created by abc on 2020/10/21.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwiftyJSON
class designBlindr: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var designButtonClick: UILabel!
    @IBOutlet weak var showSlidewr: UISlider!
    @IBOutlet weak var twoChangeLable: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var ShowWift: UISwitch!
    @IBOutlet weak var oneIMageView: UIImageView!
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var firstSecondShow: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    let urlString = "https://www.douban.com/j/app/radio/channels"
    let url = URL(string:urlString)
    //创建请求对象
    let request = URLRequest(url: url!)
     
    //创建并发起请求
    URLSession.shared.rx.response(request: request).subscribe(onNext: {
        (response, data) in
        //数据处理
        let str = String(data: data, encoding: String.Encoding.utf8)
        print("返回的数据是：", str ?? "")
    }).disposed(by: disposeBag)
   
    URLSession.shared.rx.response(request: request).subscribe(onNext: {
            (response, data) in
            //判断响应结果状态码
    if 200 ..< 300 ~= response.statusCode {
    let str = String(data: data, encoding: String.Encoding.utf8)
     print("请求成功！返回的数据是：", str ?? "")
     }else{
     print("请求失败！")
      }
   }).disposed(by: disposeBag)
    
 //创建并发起请求
  URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("请求成功！返回的数据是：", str ?? "")
 }).disposed(by: disposeBag)
        
URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("请求成功！返回的数据是：", str ?? "")
}, onError: { error in
            print("请求失败！错误原因：", error)
})
/*如果不需要获取底层的 response，只需知道请求是否成功，以及成功时返回的结果，那么建议使用 rx.data。
因为 rx.data 会自动对响应状态码进行判断，只有成功的响应（状态码为 200~300）才会进入到 onNext 这个回调，否则进入 onError 这个回调。*/
/*
         
let urlString = "https://www.douban.com/j/app/radio/channels"
                 let url = URL(string:urlString)
                 //创建请求对象
                 let request = URLRequest(url: url!)
                  
                 //发起请求按钮点击
                 startBtn.rx.tap.asObservable()
                     .flatMap {
                         URLSession.shared.rx.data(request: request)
                             .takeUntil(self.cancelBtn.rx.tap) //如果“取消按钮”点击则停止请求
                     }
                     .subscribe(onNext: {
                         data in
                         let str = String(data: data, encoding: String.Encoding.utf8)
                         print("请求成功！返回的数据是：", str ?? "")
                     }, onError: { error in
                         print("请求失败！错误原因：", error)
                     }).disposed(by: disposeBag)
             }
}
*/
   self.dataPicker.rx.date.subscribe(onNext: { (next) in
            
    print(next)
        
   }).disposed(by: disposeBag)
        
    self.ShowWift.rx.isOn.subscribe(onNext: { (next) in//isOn 表示Uiswitch的开发属性
    print(next)
    }).disposed(by: disposeBag)
  //通过设置isNetWorkActicitiyActicityIndicatiorVisable来指明顶部的状态子时期指明活动
   self.ShowWift.rx.value.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
    
    self.firstSecondShow.rx.selectedSegmentIndex.asObservable().subscribe(onNext: { (next) in
            
    print(next)
            
    }).disposed(by: disposeBag)
        
    //点击SelectedSegmentIndex去修改当前
    let showImageChange : Observable<UIImage> = self.firstSecondShow.rx.selectedSegmentIndex.asObservable().map{
        let images = ["311595233896_.pic_hd","room_门票_sel"]
            
            return UIImage(named: images[$0])!
    }
        showImageChange.bind(to: self.oneIMageView.rx.image).disposed(by: disposeBag)
        
        self.showSlidewr.rx.value.asObservable().subscribe(onNext: { (next) in
        
            print(next)
            
        }).disposed(by: disposeBag)
        self.designButtonClick.textColor = UIColor.black
        self.designButtonClick.text = "自定义可绑定属性//即观察者所改变的属性";
        self.designButtonClick.font = UIFont.systemFont(ofSize: 0)
        let Observablee = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        Observablee.map{CGFloat($0)}.bind(to: designButtonClick.rx.fontSize).disposed(by:disposeBag)
        self.twoChangeLable.textColor = UIColor.black
        self.twoChangeLable.text = "自定义可绑定属性//即观察者所改变的属性";
        self.twoChangeLable.font = UIFont.systemFont(ofSize: 0)
        self.twoChangeLable.backgroundColor = UIColor.yellow
        let ObserVablethree = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        ObserVablethree.map{CGFloat($0)}.bind(to: twoChangeLable.fontSize).disposed(by:disposeBag)
        // Do any additional setup after loading the view.
        //stepper值必须要要大于0就是这样去避免出现错误
        self.stepper.rx.value.asObservable().subscribe(onNext: { (next) in
            
            print(next)
       
        }).disposed(by: disposeBag)
        
        showSlidewr.rx.value.map{Double($0)}.bind(to: stepper.rx.stepValue).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            //显示等待提示框
            SwiftNotice.wait()
    }
//对UI进行扩展

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//对UI进行扩展

extension UILabel{
      
    public var fontSize:Binder<CGFloat>{
    
        return Binder(self){lable ,fontSize in
    
        lable.font = UIFont.systemFont(ofSize: fontSize)
      }
    }
  }
//利用Reactive对UILable进行扩展
extension Reactive where Base:UILabel{
    
    public var fontSize:Binder<CGFloat>{
        
        return Binder(self.base){lable,fontSize in
        
          lable.font = UIFont.systemFont(ofSize: fontSize)
                
          }
        }
    }
    
/*前面我们学习了let obse = observable.just(["1","2","2"])
 这些都是值都获取到了然后在通过event传递出去现在的需求是我们希望等到获取到值获取获取到最新的内容的时候再去将树脂传递出去比如你订阅了一个框的内容当用户输入一个字后整个框就会产生一个带有输入框内容的Event通知给所有订阅者整个就是我们要说饿Subjects///即subjects‘
 subjects即时订阅者也是观察者
 说他是订阅者是因为它可以动态的接受新的值说他又是一个Observable 是因为它有了新职之后就会通过Event将新值发给他的所有订阅者
 一共有4中 publishSubjects/BehaviorSubject/replaySubject/Variable
 相同点 都是序列都是观察者/complete/error被总结就不会在发出.next事件//对于那些subject总结后subject会发出一条complete或者。error的event告诉整个新的订阅者已经总结
 它们之间最大的区别只在与 当一个新的订阅者刚订阅他的时候 能不能收到subjct之前发出的旧的event 如果能的话又能收到几个
 publishSubject 值只能收到订阅后的事件之前的收不到不需要出示值就可以使用这个publishSubject。
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
