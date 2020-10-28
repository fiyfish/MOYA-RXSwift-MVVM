//
//  oneMVVM.swift
//  XunLei
//
//  Created by abc on 2020/10/19.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
/*
 subjects与Observables不同在于它同时序列和订阅者2个角色 subjects/Observables 序列/观察者 只能发射在订阅之后的事件此时并没有打印
 Rxswift中提供了4中Subjects///和2种解包类型 分别如下
 PublishSubject ：开始为nil 只发射最新的元素给订阅者
 BehaviorSubject 有开始值并且重复发射最晚一个元素给订阅者
 ReplaySubjects 存在一个缓冲区重复发射符合缓冲区域个数的元素给新的订阅者
 Variable是BehaviorSubject的包装subjects//PublishSubject。在这里进行路线的操作
 BehaviorSubjects 只会输出最新添加的一个元素并在error/complish完成不再执行任何的操作
 */
class oneMVVM{
//这里没有初始法的方法即没有init方法所以要给生成的变量一个开始值然后在这个值里面进行数据处理去满足开发需求
    public enum HomeError{
       case internetError(String)
       case serverMessage(String)
    }
    //publishSubject<[Album]> = PublishSubject()
    //did set will set 在填充值的时候使用
    public let albums : PublishSubject<[Album]> = PublishSubject()
    public let tracks : PublishSubject<[Track]> = PublishSubject()
    public let loading : PublishSubject<Bool>  = PublishSubject()
    public let showView : PublishSubject<[Int]> = PublishSubject()
    public let typeString:Observable<String>
    public let error : PublishSubject<HomeError> = PublishSubject()//声明4个subject去表面这个即使序列又是观察者
    //public let error :PublishSubject<Bool> = PublishSubject()前面半部分是序列//后面半部分是观察者两者一一响应
   private let disposable = DisposeBag()
    
    init(typeString:Observable<String>) {
        
        self.typeString = typeString
    }
    //.filter{!$0.isEmpty}.flatMapLatest
   public func requestData(){
        self.loading.onNext(true)
            APIManager.requestData(url: "dcd86ebedb5e519fd7b09b79dd4e4558/raw/b7505a54339f965413f5d9feb05b67fb7d0e464e/MvvmExampleApi.json", method: .get, parameters: nil, completion: { (result) in
                self.loading.onNext(false)
                switch result {
                case .success(let returnJson) :
                    /*
                     从JSON对象解码数据类型实例的对象。jsonDecoder字符串转模型的结构
                     */
                    //let jsonDecoder = JSONDecoder()
                    
                    //let josnData = JSON(returnJson)
                    
                   //let model = returnJson["Albums"].arrayValue.compactMap {return Album(data: try! $0.rawData())}
                    //在这里加加将这个类型值一一便利转化为特定模型的值并添加到数组中去
                
                let albums = returnJson["Albums"].arrayValue.compactMap {return Album(data: try! $0.rawData())}
                    let tracks = returnJson["Tracks"].arrayValue.compactMap {return Track(data: try! $0.rawData())}//swiftjson里面的序列化和反序列化操作
                    self.albums.onNext(albums)
                    self.tracks.onNext(tracks)
                case .failure(let failure) :
                    switch failure {
                    case .connectionError:
                        self.error.onNext(.internetError("Check your Internet connection."))
                    case .authorizationError(let errorJson):
                        self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                    default:
                        self.error.onNext(.serverMessage("Unknown Error"))
                    }
                }
            })
            
        }
        
   }
/*
flapMap

 将序列的元素转换为其他序列， 就很适合a序列转换为b序列，比如
 输入类型/序列， 输出序列
 flapMapLatest
 和flapMap相似，不同的是只发出最新元素
 
 
 
 
 
 
 
 
 
 
 
 */
/*
 throws抛出的异常必须要通过try来处理
 throws
 try?
 trycatch
 try{
 }catch{
 }try!/
 try标准的处理方式改方式要结合do catch来处理
 try？告诉系统可能回出错 出错返回nil 不出错返回一个可选值返回给我们
 try!告诉系统一定没错如果发生错误程序回崩溃不推荐使用 这些都是对方法throws的一个处理 有throws必有try 当然
 还有try{
 }catch{
 }
 try里面执行代码catch里面抛出异常去执行代码去完善代码要求
 */
    

