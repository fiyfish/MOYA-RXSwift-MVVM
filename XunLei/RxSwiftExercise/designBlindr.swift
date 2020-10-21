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
class designBlindr: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var designButtonClick: UILabel!
    @IBOutlet weak var twoChangeLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
