//
//  DetailAddressModel.swift
//  XunLei
//
//  Created by abc on 2020/10/19.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
import SwiftyJSON
struct DetailAddressModel {
var artist: String?
var track_art_work: String?
var name: String?
var id: String?
    
init(jsonData: JSON) {
    artist = jsonData["artist"].stringValue
    track_art_work = jsonData["track_art_work"].stringValue
    name = jsonData["name"].stringValue
    id = jsonData["id"].stringValue
}

}
