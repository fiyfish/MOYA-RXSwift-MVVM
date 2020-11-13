//
//  ViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/27.
//  Copyright © 2020 abc. All rights reserved.
//
//今日任务 1.内存泄漏的所有情景模拟出来 2.git所有的指令全部属性查找并敲打一遍验证最总的效果
//set和get方法
import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
typealias testLeaks = ()->Void
class ViewController: UIViewController,protoShow {
    var type = "type"
    let kCellIdentifier = "CellIdentifier"
    var addButton:UIButton!
    var lable:UILabel!
    var oneShow:testLeaks!
    var videoListShow:UITableView!
    let name:Array = ["大主宰","雪山飞狐","碧血剑","环太平洋3之我去打外星怪兽","环太平洋2之怪兽我来了","我和我的祖国","我和我的家乡","一点回家","姜子牙","大鱼海棠"]
    //颜色获取(定义方法)
    var a:Int = 0
    var b:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UI()
        var _type:String = "1"//get和set方法
        var type:String{
        /*
            willset{}
            didset{}
         */
          get{
            return _type
           }
            
            set{
            
            _type = newValue
            
            }
      }
        let viewXib = oneView.init(frame: CGRect(x: 0, y: 120, width: 120, height: 120))
        self.view .bringSubviewToFront(viewXib)
        self.view.addSubview(viewXib)
        var c :Int {//当我们获得属性值的时候调用get方法当我们设置属性值的时候设置set方法就这样去进行一个值的书写
            
            get{//willset和didset 在swift里面通过这2个值来监测属性的变化最后展示效果willset////didset
                
                return 1
                
            }
            
            set{
            
              b = newValue
                
            }
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func UI() -> Void {
       self.title = "首页";
       self.view.backgroundColor = UIColor.white
       self.lable = UILabel.init(frame
        : CGRect(x: Int(SCREEN_WIDTH/2-100), y: showStatusHeight+20, width:200 , height:30))
        self.view.addSubview(self.lable)
        self.lable.textAlignment = .center;
        self.lable.font = UIFont.systemFont(ofSize: 20)
         self.lable.text = "迅雷小白虫"
        
        self.videoListShow = UITableView.init(frame: CGRect(x: 0, y:0 , width:0, height:0))
        self.view.addSubview(self.videoListShow)
        self.videoListShow.snp.makeConstraints { (make ) in
         make.left.right.equalToSuperview()
        if #available(iOS 11.0, *) {
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        } else {
            make.top.equalTo(self.topLayoutGuide.snp.top)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
           }
         }
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
/*
 toplayoutGuide/bottomlayoutGuide其实是作为虚拟的占位view用于自动布局的时候帮助开发者避免顶部的状态栏导航栏和底部的tabbar等
 
 */

