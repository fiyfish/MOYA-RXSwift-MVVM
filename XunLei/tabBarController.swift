//
//  tabBarController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class tabBarController: UITabBarController {
  
    private let  homePage = HomeController()
    
    private let  scenePage = MailListViewController()
    
    private let devicePage = FindController()
    
    private let findPage = ScenceViewController()
    
    private let myPage = MyController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           self.tabBar.isTranslucent = false;
           homePage.tabBarItem.title   = "首页"
           scenePage.tabBarItem.title  = "情景"
           findPage.tabBarItem.title   = "发现"
           devicePage.tabBarItem.title = "设备"
           myPage.tabBarItem.title     = "我的"
           //创建分栏控制器的图片
           homePage.tabBarItem.image   = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           scenePage.tabBarItem.image  = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           findPage.tabBarItem.image   = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           devicePage.tabBarItem.image = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           myPage.tabBarItem.image     = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           
           homePage.tabBarItem.selectedImage   = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           scenePage.tabBarItem.selectedImage  = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           findPage.tabBarItem.selectedImage   = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           devicePage.tabBarItem.selectedImage = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           myPage.tabBarItem.selectedImage     = UIImage.init(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          //设置文字标题颜色和大小
           UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)], for: .normal)
           UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)], for: .selected)
           self.viewControllers = [homePage,scenePage,findPage,devicePage,myPage]
       
    }
    
    //自定义tabbar的样式
    
    fileprivate func setUpTabbar(){
        //tabbar顶部横线
        let rect = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.shadowImage = image
        self.tabBar.backgroundImage = UIImage()
        //tabbar工具栏背景色
        self.tabBar.barTintColor = UIColor.white
        
        //设置为点击文字颜色
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HEXCOLOR(0x333333)], for: UIControl.State.normal)
        //设置点击之后文字颜色
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HEXCOLOR(0xf4b541)], for: UIControl.State.selected)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
