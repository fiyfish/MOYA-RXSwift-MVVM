//
//  modelShow.swift
//  XunLei
//
//  Created by abc on 2020/10/23.
//  Copyright © 2020 abc. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa
import RxDataSources
class vmModel: NSObject {//1.建立一个继承于NSObject的model类型 2.在里面声明一些几个类型的值 第一个 let inputAvailab:Observable<Bool>/let inputNameAvailAble:Observable<Bool>3.init(usetNameText:Observable<String>,usetTextFeild:Observable<String>)
    
    let inputAvailad :Observable<Bool>
    let inputNameAvailaBlae : Observable<Bool>
    init(
       usetNameText:Observable<String>,
       usetTextFeild:Observable<String>
    
    ) {
        inputAvailad = usetNameText.map{$0.count>5}.share(replay:1)
        inputNameAvailaBlae = usetTextFeild.map{$0.count>5}.share(replay:1)
    }
}
//双向绑定 userVM.usernam.asObservable().bind(to:textField.rx.text).disposed(by:disposeBag)
/*
 share(replay:1)//只容许当前这个值被监听一次share(replay:1)
 */
/*
class vmModel1:NSObject{
    //output
    let inputAvailable :Observable<Bool>
    let inputNameAvaolAblae:Observable<Bool>
    init(
        userNameText:Observable<String>,
        usetTextFeile:Observable<String>
      ) {
        inputAvailable =  userNameText.map{$0.count>5}.share(replay: 1)
        inputNameAvaolAblae = usetTextFeile.map{$0.count>5}.share(replay: 1)
    }
}
*/
