//
//  twoShowViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class twoShowViewController: UIViewController {
    let disposeBage = DisposeBag()
    @IBOutlet weak var inputTextView: UITextField!
    var oneShow:vmModelShow!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.oneShow = vmModelShow.init(textPusblish:self.inputTextView.rx.text.orEmpty.asObservable())
//        self.oneShow.showEnd.subscribe(onNext: { (text) in
//            print(text)
//            }).disposed(by:disposeBage)
        
      /*
        driver的使用提供了一种简单的ui编程代码的响应式编程代码 它满足一下3个条件 不会产生error当产生error的时候可以返回自己业务逻辑错误的提示
         一定在主线程监听UI
        共享状态变化()
*/
      self.oneShow = vmModelShow.init(oneShow: self.inputTextView.rx.text.orEmpty.asDriver())
        
        self.oneShow.pageshow.drive(onNext: { (text) in
            
         print(text)
           
        }).disposed(by: disposeBage)
        
        // Do any additional setup after loading the view.
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
