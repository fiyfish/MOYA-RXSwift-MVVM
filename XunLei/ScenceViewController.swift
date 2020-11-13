//
//  ScenceViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
//
/*
 oc的核心是面向对象即我们常说的封装继承和多态
 swift的核心是面向协议代码是从一个协议开始去进行代码的编写核心是抽象和简化
 class/struct/enum//protocol协议
 
 */
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
        collectionView.delegate = self
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
/*
    as? 转化成功是一个可选值转化不存在为nil
    as！强制转化如果转化失败报runtime的错误
    as 从派生类转化成为基类向上转型 值类型转化 语句类型转化 let personq as Student向上转类型值消除二义性数值类型转化 swift语句中进行匹配通过语法进行操作检查对象的类型然后进行处理
*/
    
}

extension ScenceViewController : HWCollectionViewFlowLayoutDelegate {
    func hw_setCellHeght(layout: HWCollectionViewFlowLayout, indexPath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        let item = itemArray[indexPath.item]
        let heigth = itemWidth * item.h! / item.w!;
        return heigth
    }
}

extension ScenceViewController : UICollectionViewDelegate{
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          //        let cell = collectionView .cellForItem(at: indexPath)
          //        cell?.backgroundColor = armColor();
          
       print("瀑布流在流水")
          
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
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
