//
//  Track.swift
//  XunLei
//
//  Created by abc on 2020/10/19.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
struct Track: Codable {
    let id, name, trackArtWork, trackAlbum: String
    let artist: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case trackArtWork = "track_art_work"
        case trackAlbum = "track_album"
        case artist
    }
}
extension Track {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Track.self, from: data)//将每一个元素转化为数据模型
            self = me
        }
        catch {
            print(error)
            return nil//捕获到异常并将错误打印出来并报道catch中去
        }
    }
}
/*
 Struct作为数据模型的注意事项
 第一步 struct是值类型的没有引用计数 不会内存泄漏 放在站里面数据更快 值类型是自动线程安全得无论你从那个线程去访问struct都非常安全 无论是省考呗还是浅考呗都是比较简单安全的
 不足点: oc不友好 struct不能被继承 struct不能被序列化成NsDta对象即不能被nsuserDefault存储即没有原来安全
 [weak self]// [unowned self]
 //它们一直是相互引用，即同时销毁的，那么就可以将捕获定义为 unowned。
 //它们之间销毁有前后之间的区别则去使用weak将前后消费去除掉去满足。
 同oc中的dealloc方法一样deinit方法如上所示在里面需要进行的方法操作有
 对象销毁
 kvo移除
 移除通知
 nstimer销毁
 [weak self]
 [unowned self]
 */
