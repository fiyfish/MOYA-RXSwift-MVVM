//
//  ViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/27.
//  Copyright © 2020 abc. All rights reserved.
//
//今日任务 1.内存泄漏的所有情景模拟出来 2.git所有的指令全部属性查找并敲打一遍验证最总的效果
import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
typealias testLeaks = ()->Void
class ViewController: UIViewController,protoShow {
    let kCellIdentifier = "CellIdentifier"
    var addButton:UIButton!
    var lable:UILabel!
    var oneShow:testLeaks!
    var videoListShow:UITableView!
    let name:Array = ["大主宰","雪山飞狐","碧血剑","环太平洋3之我去打外星怪兽","环太平洋2之怪兽我来了","我和我的祖国","我和我的家乡","一点回家","姜子牙","大鱼海棠"]
    //颜色获取(定义方法)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UI()
        
        // Do any additional setup after loading the view.
    }
    
    func UI() -> Void {
    
       self.view.backgroundColor = UIColor.white
       self.lable = UILabel.init(frame
        : CGRect(x: Int(SCREEN_WIDTH/2-100), y: showStatusHeight+20, width:200 , height:30))
        self.view.addSubview(self.lable)
        self.lable.textAlignment = .center;
        self.lable.font = UIFont.systemFont(ofSize: 20)
         self.lable.text = "迅雷小白虫"
        
        self.videoListShow = UITableView.init(frame: CGRect(x: 0, y: showStatusHeight+55, width: Int(SCREEN_WIDTH), height:Int(SCREEN_HEIGH) - (showStatusHeight+55)))
        self.view.addSubview(self.videoListShow)
        self.videoListShow.delegate = self
        self.videoListShow.dataSource = self
        let nib = UINib(nibName: "videoListTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.videoListShow.register(nib, forCellReuseIdentifier: kCellIdentifier)
        self.addButton = UIButton.init(frame: CGRect(x:Int(SCREEN_WIDTH) - 70, y:10+showStatusHeight, width: 60, height:30))
          self.view.addSubview(self.addButton)
          self.addButton.setTitle("+下载", for:.normal)
           self.addButton.setTitleColor(UIColor.orange, for:.normal)
            self.addButton.addTarget(self, action: #selector(beginLoad), for: .touchUpInside)
               //self.addButton.setImage(UIImage(named:"311595233896_.pic_hd" ), for: .normal)
               PublicObj .setUpImgDownText(self.addButton, space:30)//oc和swift混编直接创立乔接文件然倒入头文件最后直接按照swift的语言习惯直接调用就可以在swift里面使用oc的代码效果
               var pt:CGRect = PublicObj.rect(with: "12121212", andFont: UIFont.systemFont(ofSize: 14), maxWidth: 200)//判断方法类型以及最后的效果类型展示去展示效果
         }
//下载按钮的操作
@objc func beginLoad()
 {
    let vc  = LoadVideoViewController.init()
    vc.delegate = self
     vc.modalPresentationStyle = .fullScreen;
     self .present(vc, animated: true, completion: nil)
}
    
    @objc func test(nofi : Notification){
        let str = nofi.userInfo!["post"]
        print(String(describing: str!) + "this notifi")
    }
    
    func dosSome(cell: videoListTableViewCell)->Void{
        
        let indexPath :IndexPath = self.videoListShow.indexPath(for: cell)!
        print(indexPath.row,indexPath.section)
        let vc = videoPlayViewController.init()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func describeName() ->Void{
        
        print("12121212121")
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellIdentifier, for: indexPath) as! videoListTableViewCell
        
        cell.oneBlock = {(cell: videoListTableViewCell) -> Void in
            
            self.dosSome(cell: cell)
        }
        cell.videoLableName.text = self.name[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75;
    }
}

