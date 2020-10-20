//
//  mvvmexercise.swift
//  XunLei
//
//  Created by abc on 2020/10/16.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class mvvmexercise: NSObject {

    //输出
    let username:Observable<Bool>
    let telePhoname:Observable<Bool>
    let allSure:Observable<Bool>
    init(
       //输入
        userNameText:Observable<String>,
        telphomeText:Observable<String>,
        buttonClick:Observable<Void>
    
    ) {
        username = userNameText.map{$0.count>5}.share(replay:1)
        telePhoname = telphomeText.map{$0.count > 5}.share(replay:1)
        allSure = Observable.combineLatest(username,telePhoname){$0&&$1}.share(replay:1)
        
    }
}
