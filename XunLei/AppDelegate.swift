//
//  AppDelegate.swift
//  XunLei
//
//  Created by abc on 2020/9/27.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
//UI/方法/功能/oc与swift混编/swift与flutter混编/打包上传/第三方库管理/逻辑交互实现方法/一些方法的使用/响应式编码/mvvm编码涉及的事件机制--信号---订阅者//参数中的_
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabbar = tabBarController.init()
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }
}

