//
//  ScenceViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class ShopItem: NSObject {
    var h : CGFloat?
    var w : CGFloat?
    var price : String?
    var img : String?
}

class ScenceViewController: UIViewController {

    lazy var itemArray = [ShopItem]()
    lazy var collectionView : UICollectionView = {
        let fl = HWCollectionViewFlowLayout()
        fl.delegate = self
        let collectionView = UICollectionView.init(frame:CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: fl)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCellID")
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make ) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
             } else {
                    make.top.equalTo(self.topLayoutGuide.snp.top)
                    make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
                  }
               }
        getDataSource()
    }

    func getDataSource() {
        let path = Bundle.main.path(forResource: "shop", ofType: "plist")
        let arr = NSArray(contentsOfFile: path!)
        
        for dic in arr! {
            let shop = ShopItem()
            let dict = dic as! NSDictionary
            shop.h = dict["h"] as? CGFloat
            shop.w = dict["w"] as? CGFloat
            shop.img = dict["img"] as? String
            shop.price = dict["price"] as? String
            itemArray.append(shop)
        }
        collectionView.reloadData()
    }
 


}

extension ScenceViewController : HWCollectionViewFlowLayoutDelegate {
    func hw_setCellHeght(layout: HWCollectionViewFlowLayout, indexPath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        let item = itemArray[indexPath.item]
        let heigth = itemWidth * item.h! / item.w!;
        return heigth
    }
    
    
}

extension ScenceViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCellID", for: indexPath)
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
}
/*
import UIKit

class ScenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
*/
