//
//  completeViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/16.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
/*
 语法糖 $0 引用必包参来引用闭包参数的值利用$0/$1
 Observable - 可监听序列
 之前我们提到 Observable可以用于描述元素异步产生的序列这样我们生活中许多事物都可以通过它来表示例如：
  Observable<Double> 温度 可以将温度看作一个序列当温度变化的情况下开始改变例如温度变高打开空调
 Observable<OnePieceEpisode>
 我们可以把海贼王看作一个序列当这个序列更新一集的时候我们就可以立即去观看这一集。
 Observable<json>我们可以把json看作是一个序列 当json返回时或者改变的时候将json打印出来。
 Observable<void>任务回调
 你可以把任务回调看作是一个序列当任务结束后 提醒用户任务已完成。
 如何创建序列即观看者的属性 这个序列在开发过程中框架已经为我们创建好了许多框架如 button的点击/textFeild的当前文本/switch的开关/slider的当前数组等等
另外一些自定义饿序列是需要我们自己创建饿 这里如下：
 let numbers: Observable<Int> = Observable.create{}
 Event-事件
 public enum Event<Element> {
     case next(Element)
     case error(Swift.Error)
     case completed
 }在这里进行事件的处理 next产生一个新的元素/error错误/completed 完成整个序列的操作。
 序列/观察者 温度是序列------------改变空调是观察者去改变序列的事件的操作
 创建观察者最直接的方法就是在 Observable的subscribe方法后面描述事件发生时如何做出响应就是观察者后面的onNext/onError/onCompleted这些必报构建出来的。
 这个需要去进行数据绑定和支付处理
 usernameValid.bind(to:usernameValidOutlet.rx.isHidden).disposed(by:disposeBag)
 操作符可以帮助大家创建新的序列或者变化组合原油的序列从而生成一个新的序列
 通过map去判断输入的用户名转化的用户名是否有效
 通过combinelatest方法将两者合并去判断两者是否同时有效
 map和combineLatest都是操作符它们可以帮助我们构建所需要的序列现在看几个例子
 filter 过滤
 map转化
 zip配对 这3个方法 filter/map/zip都是去配对出新的方法。
 passwordValid
 .bind(to: passwordValidOutlet.rx.isHidden)
 .disposed(by: disposeBag)
 passwordValid.bind(to:Passw.rx.isHidden).disposed(by:disposeBag)
 Schedulers - 调度器
 理清一下整体的编程思路:
 (1),创建模式的值去标记出是否显示出动画/是否动画完成
 (2),将完成之后获取到的数据传递给列表中的值并进行列表刷新的操作
 (3),熟悉rxCocoa中关于uitableviewcell的封装操作最直接去展示最后的效果值去完成开发需求。
 在当前屏幕的缓存区域外去开辟另一个缓存区域去进行渲染尽量避免离屏渲染触发丽萍渲染要多次切换上下文以及开辟缓存区域 Gpu能处理的最大纹理尺寸是4096*4096一旦超过这个尺寸就会占有用的Cpu资源进行处理所以纹理要尽量不要超过这个尺寸
 减少透明的试图不透明就设置opaque为yes
尽量避免出现离屏渲染
出现卡顿的原因就是主线程进行了耗时操作
 可以添加observeer到主线程runloop中通过监听runloop状态切换的消耗时间的长短就可以达到监控卡顿的目的。
 避免过多的使用autolayout这个过多设置frame会消耗更多的cpu资源。
 图片的size最好刚刚和UiimageView的size保持一致
 控制一下线程的最大并发数量 避免过多的开辟子线程 子线程也是占用内存结构的
 监测卡顿
 */
class completeViewController: UIViewController {

    var homeViewModel : oneMVVM!
    
    let disposeBag = DisposeBag()
    
    var loadview : AnimateloadingView!
    
    var listTableView:UITableView!
    
    var DataArray:NSMutableArray!
    
    var oneView:UITextField!
    
    override func viewDidLoad() {
        
      super.viewDidLoad()
        
       self.view.backgroundColor = UIColor.white
        
        self.oneView = UITextField.init(frame:CGRect(x: 0, y: 0, width: 10, height: 10))
        
        self.view.addSubview(self.oneView)
    
        self.DataArray = NSMutableArray.init()
        
        self.listTableView = UITableView.init()
        
        self.view.addSubview(self.listTableView)
        
        self.listTableView.delegate = self;
        
    self.listTableView.dataSource = self
    self.listTableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGH)
        
        setupBindings()
        
        homeViewModel = oneMVVM.init(typeString: self.oneView.rx.text.orEmpty.asObservable())
        
       homeViewModel.requestData()//绑定之后再去请求数据然后进行事件的更新

        // Do any additional setup after loading the view.
    }
    
    func  setupBindings() -> Void {
    
        homeViewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        homeViewModel.albums.subscribe(onNext: { (name) in
            
            self.DataArray.addObjects(from: name)
            
            DispatchQueue.main.sync {
               
                self.listTableView.reloadData()
          }
           
        }).disposed(by: disposeBag)
        
        homeViewModel
        .error
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (error) in
            switch error {
            case .internetError(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .error)
            case .serverMessage(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .warning)
            }
        })
        .disposed(by: disposeBag)
    
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

extension completeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.DataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let ShowIdentifier = "identifier";
        
        let oneCell:UITableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: ShowIdentifier)
        
        let picString:Album = self.DataArray[indexPath.row] as! Album
        
        oneCell.textLabel?.text = picString.name
        
        return oneCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("e1eeqeqeqweqeqeq")
    }
    
}
