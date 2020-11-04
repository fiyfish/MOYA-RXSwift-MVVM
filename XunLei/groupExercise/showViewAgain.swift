//
//  showViewAgain.swift
//  XunLei
//
//  Created by abc on 2020/10/28.
//  Copyright © 2020 abc. All rights reserved.
//iOS9以后有安全区域safearea布局的方法一般都写在安全区域里面
import Foundation
import RxCocoa
import RxSwift
import RxDataSources
class vmModelShow: NSObject {
  let disposeBag = DisposeBag()
//   let showEnd : Observable<String>
//   init(textPusblish:Observable<String>) {
//   showEnd = textPusblish.map{"e"+$0+"e"}.share(replay:1)
//}
    //回滚测试7
    //回滚测试9
    //回滚测试9
    //回滚测试10
    //回滚测试11
    //回滚测试12
    //112122112
    //212121221
    //212121121
    //1212121112
    //212121221
    let pageshow:Driver<String>
   //let twoPageShow:Driver<String>//声明twoPageShow:Driver<String>需要去初始化对象
   init(oneShow:Driver<String>) {
   pageshow = oneShow.map{$0}

    }
}
