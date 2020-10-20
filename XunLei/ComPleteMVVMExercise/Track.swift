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
