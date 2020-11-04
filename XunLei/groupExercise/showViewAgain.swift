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
    //212121221 选中需要退回到的版本右键选择将master重制到此次提交
    //选择强制合并这时本地的代码仓库就会重制到选中的提交此时不要拉去以及提交嗲吗因为我们只是改动了本地代码远程仓库还是最新的会导致冲突 强制合并将代码怀远到之前的代码
    //选中最新提交的版本右键选择将master重制到此次提交选中最新的提交版本右键选择将master重置到此次提交
    //然后将代码提交到远程仓库这些合并后就是全部代码的合并操作去满足开发需求就是这样去进行代码的合并开发。
    //git的使用规范如下第一步先拉去服务器的提交的代码版本
    //再向本地提交这个时候可能会出现冲突等问题
    //本地运行一下没有文体最后推到服务器上面去
    //操作规范
    //git使用流程 第一步先拉去服务器上面的版本代码
    //第二部提交本地的服务器代码看一下有没有冲突如果有解决掉冲突问题
    //第三种本地编译一下如果没有问题修改问题最后把项目推到服务器上面去1212121121
    //tag一般在开发过程中起到标记的作用在标记的时候去标记版本的v1.0以及特殊重要的时刻去进行代码的标记展示我们想要展示的数据版本
    let pageshow:Driver<String>
   //let twoPageShow:Driver<String>//声明twoPageShow:Driver<String>需要去初始化对象
   init(oneShow:Driver<String>) {
   pageshow = oneShow.map{$0}

    }
}
