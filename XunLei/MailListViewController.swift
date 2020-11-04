//
//  MailListViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
//内存泄漏第一种记得去释放掉对象 在试图下面要标记出dealloc/deinit方法的调用没有调用即说明存在这个对象未被释放掉存在错误
class MailListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"isTest"), object: nil)
        // Do any additional setup after loading the view.
    }
    
 @objc func test(){
        
        print("11111111")
        
 }
  //最后一步很重要记得去移除这些通知
   deinit{
        
    NotificationCenter.default.removeObserver(self)
        
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
