//
//  Album.swift
//  XunLei
//
//  Created by abc on 2020/10/19.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
struct Album: Codable {
    
    let id, name, albumArtWork, artist: String
    enum CodingKeys: String, CodingKey {
        case id, name
        case albumArtWork = "album_art_work"//当后来返回字段和系统关键字冲突或者key不匹配的时候 利用这个去替换掉原有的值
        case artist
    }
}

// MARK: Convenience initializers

extension Album {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Album.self, from: data) else { return nil }
        self = me
    }
}
/*
 swift 高阶函数语言展示出来
 1，map 可以对容器中每一个元素做一次处理
 例子如下
 let arr = [1,2,3,4,5,6,7]
 let arr1 = arr.map($0+1)
 print(arr1)//[2,3,4,5,6,7,8]//单一每一次操作去进行加操作函数式编程就是其中之一 在Swift中 函数作为高等一集的公民出现
 map对给定数据的每个元素执行闭包的映射最后将结果返回到数组里面 map执行闭包操作
 flatMap 对给定元素的每个元素
 compactMap 对数组中的每一个元素执行硬伤将非空的印社结果key-value放置在字典中返回
 filter 对给定数组的每个元素执行闭包中的操作 将符合条件的元素放在数组中返回
 reduce 对给定数组的每个元素执行闭包的操作对元素进行合并 并将合并结果返回。
 flatMap的主要作用是你想去获取到一个单层集合的数组 通过下面的代码来看一下map和flatMap
 map返回当前值的操作
 flatMap 会讲元素平铺在一个数组中 如例子所示
 let scoreByName = ["Henk":[0,5,8],"john":[2,5,8]],
 let mapper = scoreByName.map{$0.value}
 print(mapper)// [0,5,8]/[2,5,8]
 let flatMapped = ScoreByName.flatMap{$0.value}
 //[2,5,8,0,5,8] 将这些值平铺返回回来。
 filter//将这些值符合条件的元素查找出来并返回出来 let adults = stus.filter{(stu) -> Bool in }
 在这里去进行当前这个高级函数代码编程的书写
 */
