//
//  MVVMExerciseViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/16.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
/*
 在View/ViewController里面引入vm 但是vm里面不能使用
 */
class MVVMExerciseViewController: UIViewController,UITextFieldDelegate {
    var uitextFeild:UITextField!
    var vmeeer : mvvmexercise!
     let disposeBag = DisposeBag()
    var twoUitextFeild :UITextField!
              override func viewDidLoad() {
              super.viewDidLoad()
               self.view.backgroundColor = UIColor.white
               self.uitextFeild = UITextField.init()
               self.view.addSubview(self.uitextFeild)
               self.uitextFeild.backgroundColor = UIColor.purple
               self.uitextFeild.delegate=self
               self.uitextFeild.frame = CGRect(x: 0, y:100, width:SCREENWIDTH, height:90)
               self.twoUitextFeild = UITextField.init()
               self.view.addSubview(self.twoUitextFeild)
               self.twoUitextFeild.backgroundColor = UIColor.purple
               self.twoUitextFeild.delegate=self
               self.twoUitextFeild.frame = CGRect(x: 0, y:200, width:SCREENWIDTH, height:90)
               self.view.addSubview(oAuthLoginButton)
               self.blindMVVM()
               
                //这是模拟数据
                let baseInfo: [String : Any] = ["build_name":"置信·原墅",
                                                  "build_address":"学院中路与金桥路交汇处东北侧",
                                                  "build_num": 12,
                                                  "room_num": 588,
                                                  "area_address":"浙江省温州市鹿城区五马街道"]
                let jsonData = JSON(baseInfo)
                let model = BuildBaseInfoModel.init(jsonData: jsonData)
                // 面积中89是Int， 109和129是String
                let baseInfo1: [String : Any] = ["build_name":"置信·原墅",
                                                  "build_address":"学院中路与金桥路交汇处东北侧",
                                                  "area_address":"浙江省温州市鹿城区五马街道",
                                                  "area":[89,"109","129"],
                                                  "detail_address":["province":"浙江省",
                                                                    "city":"温州市",
                                                                    "district":"鹿城区",
                                                                    "street":"五马街道"],
                                                  "build_num": 12,
                                                  "room_num": 588]

                let jons2 = JSON(baseInfo1)
                let model2 = BuildBaseInfoModelTwo.init(jsonData:jons2)
                print(model2.area_address)
                // Do any additional setup after loading the view.
    }

    func blindMVVM() -> Void{
       //初始法以及给指
        vmeeer = mvvmexercise(userNameText:self.uitextFeild.rx.text.orEmpty.asObservable(), telphomeText: self.twoUitextFeild.rx.text.orEmpty.asObservable(),buttonClick:oAuthLoginButton.rx.tap.asObservable())
    
        vmeeer.allSure.bind(to: oAuthLoginButton.rx.isEnabled).disposed(by: disposeBag)

    }
    lazy var oAuthLoginButton: UIButton = {
        
        let view = UIButton.init(frame:CGRect(x:0, y:300, width: SCREENWIDTH, height:50))
        
        view.backgroundColor = UIColor.orange
        
        return view
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
