//
//  XunLeiTests.swift
//  XunLeiTests
//
//  Created by abc on 2020/9/27.
//  Copyright © 2020 abc. All rights reserved.
//
/*
 单元测试的好处
 1.不需要去频繁的去修改代码后去app进行启动去测试刚修改的代码只需要在单元测试中输入几种条件下的值并运行结果
 2.网络请求对网络接口的数据获取解析也可以放在单元测试里面来解析去判断是否获取到当前数据以及数据的后续处理
 3.网络数据层/公开类中的公开方法/业务逻辑层/修复bug的测试其实说白了也就算2类第一类网络请求第二类公开的方法
 */
import XCTest
@testable import XunLei//在这里进行代码方法的逻辑测试

class XunLeiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
