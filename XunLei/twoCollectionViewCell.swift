//
//  twoCollectionViewCell.swift
//  XunLei
//
//  Created by abc on 2020/11/11.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class twoCollectionViewCell: UICollectionViewCell {
    var buttona :UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addaaaaaa()
               // Initialization code
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addaaaaaa(){
        
        self.buttona = UIButton.init()
        
        self.addSubview(self.buttona)
        
        self.buttona.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        
        self.buttona.backgroundColor = UIColor .yellow
    }
}
