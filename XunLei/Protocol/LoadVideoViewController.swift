//
//  LoadVideoViewController.swift
//  XunLei
//
//  Created by abc on 2020/9/27.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
/*
 协议的使用如下：规定一群使用协议的对象执行协议里面可执行与不可执行协议的方法
              在代理方法里面声明协议然后声明一个中搜协议对象的代理对象然后将这个代理对象设置为执行者
              委托即代理模式写法如下：
              委托方声明协议以及满足协议的对象
              执行协议满足协议然后在方法里面设置代理对象是自己即self
              委托方在特定方法里面执行代理方要执行的代码逻辑
              执行方执行委托代码然后执行委托执行的方法并最总显示出来去满足开发需求
 */
@objc
protocol protoShow {
    
     func describeName() -> Void//必须执行的方法
     @objc optional func doNotDo() ->Void//不必须执行的方法需要加一个objc去修饰这个协议同时还要声明@objc optional 这个属性值
}
class LoadVideoViewController: UIViewController, UITextViewDelegate{
    
    var backButton:UIButton!
    var inputLoadFile:UITextView!
    var loadButtonClick:UIButton!
    open weak var delegate:protoShow!//open weak 在这里用weak去修饰这个代理对象去避免循环引用
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.backButton = UIButton.init()
        self.view.addSubview(self.backButton)
        self.backButton.setTitle("返回", for:.normal)
        self.backButton.frame = CGRect(x:10, y:10+showStatusHeight, width: 40, height: 40)
        self.backButton.setTitleColor(UIColor.black, for: .normal)
        self.backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.backButton.addTarget(self, action:#selector(backToView), for: .touchUpInside)
        
        self.inputLoadFile = UITextView.init()
        self.view.addSubview(self.inputLoadFile)
        self.inputLoadFile.frame = CGRect(x: 10, y:60+showStatusHeight, width:Int(SCREEN_WIDTH)-20, height:160)
        self.inputLoadFile.layer.cornerRadius = 8;
        self.inputLoadFile.delegate = self;
        self.inputLoadFile.layer.masksToBounds = true;
        self.inputLoadFile.text = "请输入您所要下载的地址";
        self.inputLoadFile.layer.borderColor = UIColor.black.cgColor
        self.inputLoadFile.layer.borderWidth = 1
        
        self.loadButtonClick = UIButton.init()
        self.view.addSubview(self.loadButtonClick)
        self.loadButtonClick.frame = CGRect(x: 10, y: self.inputLoadFile.frame.maxY+20, width: SCREEN_WIDTH-20, height: 50)
        self.loadButtonClick.layer.cornerRadius = 25;
        self.loadButtonClick.layer.masksToBounds = true;
        self.loadButtonClick .setTitle("确定", for: .normal)
        self.loadButtonClick.setTitleColor(.white, for: .normal)
        self.loadButtonClick.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
    }
    
    @objc func backToView(){
       
       if (self.delegate != nil) {
            
        self.delegate.describeName()
     }
       self.dismiss(animated:true , completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
       
        textView.text = nil;
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
         if (textView.text  == "") {
        
            textView.text = "请输入您所要下载的地址";
         }
        
    }

}

