//
//  BuildBaseInfoModel.swift
//  XunLei
//
//  Created by abc on 2020/10/19.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
import SwiftyJSON
//在json数据中有很多的modle类型并将值引用在一起去满足开发需求
/*
 数据模型数据类型展示
 
 
 
 
 
 
 */
struct BuildBaseInfoModelTwo {
    
    var build_name: String?
    var build_address: String?
    var build_num: String?
    var room_num: String?
    var area_address: String?
    var detail_address: DetailAddressModel
    var area:[Any]?
    // 这里面积area中就不能再用arrayValue获取了，因为arrayValue获取的为JSON类型，我们需要转为我们需要的对象
    init(jsonData: JSON) {
        build_name    = jsonData["build_name"].stringValue
        build_address = jsonData["build_address"].stringValue
        area_address  = jsonData["area_address"].stringValue
        room_num      = jsonData["room_num"].stringValue
        build_num     = jsonData["build_num"].stringValue
        area          = jsonData["area"].arrayObject
        detail_address = DetailAddressModel(jsonData: jsonData["detail_address"])
    }
}
