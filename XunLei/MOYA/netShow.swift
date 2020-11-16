//
//  netShow.swift
//  XunLei
//
//  Created by abc on 2020/10/13.
//  Copyright © 2020 abc. All rights reserved.
// swiftlint:disable line_length

import Foundation
import Moya
 
//在这里去添加网络请求的超时时间
let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<DouBan>.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 10
        done(.success(request))
    } catch {
        return
    }
}

let LoadingPlugin = NetworkActivityPlugin{ (type, target)in
   switch type {
   case.began:
   NSLog("显示loading")
   case.ended:
   NSLog("隐藏loading")
   }
 }
//初始化豆瓣FM请求的provider
//一般没有设置的网络如下
//let DouBanProvider = MoyaProvider<DouBan>()
let DouBanProvider = MoyaProvider<DouBan>(plugins: [LoadingPlugin])
/** 下面定义豆瓣FM请求的endpoints（供provider使用）**/
 //请求分类 接口功能分组去执行不同模块的接口功能
 public enum DouBan {
    case channels  //获取频道列表
    case playlist(String) //获取歌曲
    case loginView
}
 
//一般的只有一个网课域名的情况下在这里去设置具体的下载地址设置具体的全部路径
//extension GitHub: TargetType {
//public var baseURL: URL { return URL(string: "https://api.github.com")! }


//请求配置 分类后的域名
extension DouBan: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone/rank/list")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        case .loginView:
            return URL(string: "https://loginView.fire")!
        }
     }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return ""
        case .playlist(_):
            return "/j/mine/playlist"
        case .loginView:
            return "/T/My/showView"
        }
    }
     
    //请求类型
    public var method: Moya.Method {
        return .get
    }
     
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
     
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
     
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
     
    //在这里直接添加当前网络请求所需要的请求头
    public var headers: [String: String]? {
            return ["Accept":"application/json","Content-Type":"application/json; charset=utf-8","x-client-system":"ios","x-client-systemVersion":UIDevice.current.systemVersion,"x-client-appVersion":"1.05"]
    }
    
   var touch: Bool { //是否可以操作
     
    switch self {
    case .playlist(_):
     return true
    default:
     return false
    }
     
   }
    
    var show: Bool { //是否显示转圈提示
     
    switch self {
    case .playlist(_):
     return true
    default:
     return false
    }
     
   }
}
