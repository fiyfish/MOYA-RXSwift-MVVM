//
//  listModelExercise.swift
//  XunLei
//
//  Created by abc on 2020/10/20.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

struct Project: Codable {//可编码的数据结构类型
    
    let xian,title:String
    let thumb:String
    let lookNum:Int
    let sheng,juli:String//有些字段可能为nil 所以不确定是否有值的时候声明为可选择(?)
    
}
extension Project{
    init?(data:Data) {
        guard let me = try? JSONDecoder().decode(Project.self, from: data) else {
            return nil;
        }
         self = me
    }
}
