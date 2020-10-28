//
//  showViewAgain.swift
//  XunLei
//
//  Created by abc on 2020/10/28.
//  Copyright © 2020 abc. All rights reserved.
//
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

   let pageshow:Driver<String>
    
   init(oneShow:Driver<String>) {
     
    pageshow = oneShow.map{$0}

    }
}
