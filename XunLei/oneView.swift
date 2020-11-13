//
//  oneView.swift
//  XunLei
//
//  Created by abc on 2020/11/11.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
//自定义Uiview在这里面所写的时候这个时候我们要重写init(frame:CGRect) override方法同时在requireinit？(coder:NSCoder)方法里面{fatalError(init(coder)has not been implemented)}//就是在这个方法里面去进行overrice init(frame:Cgrect)在这里面去写同时require.init?(coder:NScoder)
class oneView: UIView {
    var view1:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view1 = UIView.init()
        self.addSubview(self.view1)
        self.view1.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.view1.backgroundColor = UIColor.yellow
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
/*
     
     let demoView = DemoView.loadFromNib()
     demoView.backgroundColor = UIColor.red
     view.addSubview(demoView)
      
     //3.2 xib文件与类名不相同的情况
     let testV = TestView.loadFromNib("TestView0")
     testV.backgroundColor = UIColor.green
     view.addSubview(testV
     */
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
/*
extension oneView{
    
    class func loadFromNib() -> oneView {
           return Bundle.main.loadNibNamed("oneview", owner: nil, options: nil)?[0] as! oneView
       }
    
 */
//}
