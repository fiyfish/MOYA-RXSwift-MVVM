//
//  File.swift
//  XunLei
//
//  Created by abc on 2020/9/27.
//  Copyright © 2020 abc. All rights reserved.
//在这里去写一些常见的布局去展示所示的格式数据

import Foundation
import UIKit
//UI层级去进行代码的编写///网络层去请求数据和对数据进行解析然后给model进行数据展示
let  SCREEN_WIDTH = UIScreen.main.bounds.width
let  SCREEN_HEIGH = UIScreen.main.bounds.height
let SCREENBounds = UIScreen.main.bounds
let SCREENWIDTH = SCREENBounds.size.width
let SCREENHEIGHT = SCREENBounds.size.height
let Is_Iphone = (UI_USER_INTERFACE_IDIOM()==UIDevice.current.userInterfaceIdiom)
let Is_Iphone_X = (Is_Iphone&&(SCREENHEIGHT>=812))
let NaviHeight = Is_Iphone_X ? 88:64
let TabbarHeight = Is_Iphone_X ? 83:49
let BottomHeight = Is_Iphone_X ? 34:0
let STatusHeight = Is_Iphone_X ? 44:20

 func x(object:UIView)->CGFloat{
    return object.frame.origin.x;
}
//颜色
func HEXCOLOR(_ colorRgb: UInt32) -> UIColor {
    return UIColor.init(red: CGFloat((colorRgb & 0xFF0000) >> 16) / 255, green: CGFloat((colorRgb & 0x00FF00) >> 8) / 255, blue: CGFloat(colorRgb & 0x0000FF) / 255, alpha: 1)
}

let NAV_BACK_COLOR = HEXCOLOR(0xf4b542)
let NAV_Title_COLOR = HEXCOLOR(0xffffff)
let VIEW_BACK_COLOR = HEXCOLOR(0xe5e5e5)

func SystemFont(font:CGFloat)->UIFont{
   return UIFont.boldSystemFont(ofSize: font)
}

//图片设置名称
func imageNamed(_ name: String) -> UIImage? {
    return UIImage(named: name)
}
 
 let statusHeight = isIphoneX() ? 44 : 20

 let showStatusHeight = statusHeight - 20
 
// 判断是否设备是iphonex系列
func isIphoneX() -> (Bool) {
    // iPhoneX,XS
    if (UIScreen.main.bounds.size.width == 375 && UIScreen.main.bounds.size.height == 812) {
        return true;
    }
    // iPhoneXS Max,XR
    if (UIScreen.main.bounds.size.width == 414 && UIScreen.main.bounds.size.height == 896) {
        return true;
    }
    return false;
 }

func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
       return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
   }
