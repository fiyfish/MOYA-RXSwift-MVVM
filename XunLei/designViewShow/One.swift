//
//  One.swift
//  XunLei
//
//  Created by abc on 2020/11/13.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class One: UIView {

    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
           super.init(frame: frame)
           // 加载xib
           contentView = (Bundle.main.loadNibNamed("One", owner: self, options: nil)?.last as? UIView)
           // 设置frame
           contentView.frame = frame
           contentView.backgroundColor = UIColor.orange
           // 添加上去
           addSubview(contentView)
     }
    @IBAction func touchInside(_ sender: Any) {
        
        print("YAYAYAAYAY")
    }
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
