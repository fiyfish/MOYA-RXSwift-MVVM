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
    let pageshow:Driver<String>
   //let twoPageShow:Driver<String>//声明twoPageShow:Driver<String>需要去初始化对象
   init(oneShow:Driver<String>) {
   pageshow = oneShow.map{$0}

    }
/*
  选择强制合并，这时本地的代码就会重置到选中的提交，此时不要拉取及提交代码，因为我们只改动了本地代码，远端仓库还是最新的，会导致冲突
  选中最新的提交版本，右键选择将master重置到此次提交
  选择软合并，这意味着我们刚刚重置的本地的代码得到了保留，并没有被最新的提交中的代码覆盖。
  旋转软合并这意味着我们刚刚重置的本地的代码得到了保留并没有被重新提交到最新提交中的代码覆盖。
*/
}
