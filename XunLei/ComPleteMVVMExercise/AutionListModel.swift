//
//  AutionListModel.swift
//  XunLei
//
//  Created by abc on 2020/10/20.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

struct AutionListModel:Codable {

    let status:Int
    let message:String
    let data:[Datum]
}
struct Datum: Codable {
let sheng, projectID, projectType, status: Int
let nowMoney: String
let project: Project
let shi: Int
let updatedAt, endTime, openingBid: String
let type, participation, id, xian: Int
let jiaoTime: String
let yanNum, yanQi: Int
let randNum: Int
let cashDeposit: String
let winID: Int?
let deadline, closingCost, markUp, startTime: String
let xiang: Int
let createdAt: String
let lookNum: Int
enum CodingKeys: String, CodingKey {//如果需要重新去编码所需要编码的key在这里去进行值的操作
    case sheng
    case projectID = "projectId"
    case projectType, status, nowMoney, project, shi
    case updatedAt = "updated_at"
    case endTime, openingBid, type, participation, id, xian, jiaoTime, yanNum, yanQi, randNum, cashDeposit
    case winID = "winId"
    case deadline, closingCost, markUp, startTime, xiang
    case createdAt = "created_at"
    case lookNum
}
}
