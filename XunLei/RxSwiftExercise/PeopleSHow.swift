//
//  PeopleSHow.swift
//  XunLei
//
//  Created by abc on 2020/10/14.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit//VM模型
import RxCocoa
import RxSwift
class PeopleSHow: NSObject {
    
    let usernameValid:Observable<Bool>
    let passWordValid:Observable<Bool>
    let everythingValid:Observable<Bool>
    init(
         username: Observable<String>,
          password: Observable<String>
     )
    {
    usernameValid = username
        .map { $0.count >= 5 }
        .share(replay: 1)
   passWordValid = password
        .map { checkTelephoneAndSecret.isTelNumber(num: $0) }
        .share(replay: 1)
  everythingValid = Observable.combineLatest(usernameValid, passWordValid) { $0 && $1 }
        .share(replay: 1)
}
}
