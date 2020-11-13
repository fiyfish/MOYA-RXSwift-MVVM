//
//  loadXibData.swift
//  XunLei
//
//  Created by abc on 2020/11/11.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
protocol NibLoadable {}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ name : String? = nil) -> Self {////Self (大写) 当前类对象
        let loadName = name == nil ? "\(self)" : name!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
extension NibLoadable where Self : UIViewController {
    static func loadFromStoryboard(_ name: String? = nil, withIdentifier: String? = nil) -> Self {
        
        let loadName = name == nil ? "\(self)" : name!
        guard let sbId = withIdentifier else {
            return UIStoryboard(name: loadName, bundle: nil).instantiateInitialViewController() as! Self
        }
        
        return UIStoryboard(name: loadName, bundle: nil).instantiateViewController(withIdentifier: sbId) as! Self
    }
}
extension UIViewController: NibLoadable {}
extension UIView: NibLoadable {}
