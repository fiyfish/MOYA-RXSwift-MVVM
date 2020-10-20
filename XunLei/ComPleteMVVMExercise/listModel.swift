//
//  listModel.swift
//  XunLei
//
//  Created by abc on 2020/10/19.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import SwiftyJSON
/*
 为了解决在处理optional可选值问题已经一些路径/取值/特定字段问题2个方向一方面保持json定义语意直接解析json封装成固定的模版展示修改
 第二种预定意model类将json反序列化成类实例在使用这些变量去解析我们遇到的问题 通常我们拿到数据会进行非常麻烦的optional可选类型的操作去进行拆包操作 swiftjson会内部自动对optioanl进行拆包大大简化了代码解析非常方便拿到的json数据data直接人出去
  let jsonData = JSON.init(data)
 就这样直接对其转化为jsondata数据 不管要去取何种数据直接对josnData进行路径读取
 let build_name = jsonData[0]["build_name"].stringValue
 值得注意的是不需要考虑服务器给我们返回的是什么类型比如不去求一个房屋的冬素“build_num”: 588是我们先要获取int或者String类型都是可以的
 如
 let room_uum1 = josnData[0]["build_bum"].stringValue
 let room_num2 = json[0]["build_num"].initValue//对同一个数据取值返回的是不同类型的值/string/value这样通过。StringValue/intvalue就可以获取到不可选自类型如果没有获取到就会返回到一个墨认值即.stringValue返回空知乎穿/.intValue返回0/。arrayValue返回一个空数组[]这样就不需要我们去解析包了
     当然某些场景需要你自己去判断自己是否存在那么可以通过。string/。int/。bool/。float/。array/。dictionary 等等方法获取
     if let build_name = jsonData[0]["build_name"].string{print(build_name)}else{print(jsonData[0]["build_name"])}
 */
struct BuildBaseInfoModel {
    
    var build_name:String?
    var build_address:String?
    var build_num:String?
    var room_num:String?
    var area_address:String?
    
    init(jsonData:JSON) {
    
        build_name  = jsonData["build_name"].stringValue
        build_address = jsonData["build_address"].stringValue
        build_num = jsonData["build_num"].stringValue
        area_address = jsonData["area_addres"].stringValue
        build_num = jsonData["build_num"].stringValue
    }
    
}
