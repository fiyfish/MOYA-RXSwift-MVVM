import UIKit
import SwiftyJSON
import MBProgressHUD
/*
 swiftjson的使用流程如下
 let json = JSON(data: dataFromNetworking)
 let json = JSON(data:dataFromNetworking)
 let json = JSON(jsonObject)
 let json = JSON(jsonObeject)
 if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
     let json = JSON(data: dataFromString)
 }
 if let dataFromString = jsonString.data(using:.utf8,allowLossConversion:false)
 在这里进行代码json的代码方法解析完成
 Carthage存在的缺陷
 1，支持carthage的库不如Cocoapods丰富
 2，径直冲iOS8.0++
 3，在使用过程中无法去查看源码
 好处：1，去中心化 也减少了维护/Cocoapods有一个中心仓库/即Carthage每次配置和更新环境，只会去更新具体的库，所需时间更短。Podspec对项目没有侵入性/而且更新起来更快/ios8.0+ podspec文件不需要去使用对项目侵入兴更低。
 */
class videoPlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  //显示频道列表的tableView
    var tableView:UITableView!
    //频道列表数据
    var channels:Array<JSON> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设备"
        self.view.backgroundColor = UIColor.white
        //创建表视图
        let button:UIButton = UIButton.init(frame: CGRect(x: 10, y:20, width: 30, height: 30))
        self.view.addSubview(button)
        button.backgroundColor = UIColor.purple
        button.addTarget(self, action:#selector(backUP), for: .touchUpInside)
        self.tableView = UITableView(frame:CGRect(x: 0, y: 60, width: SCREEN_WIDTH, height: SCREEN_HEIGH-60), style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
        MBProgressHUD .showAdded(to: self.view, animated: true)
        DouBanProvider.request(.channels) { result in
             if case let .success(response) = result {
                //解析数据在这里进行数据的展示和解释说明
                MBProgressHUD.hide(for: self.view, animated: false)
                let data = try? response.mapJSON()
                let json = JSON(data!)//在这里进行数据的解析与操作去满足开发需求
                self.channels = json["data"]["returnData"]["rankinglist"].arrayValue
                 //刷新表格数据
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }else{
                
                MBProgressHUD.hide(for: self.view, animated: false)
            }
        }
    }
     
    //返回表格分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
     
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identify, for: indexPath)
            cell.accessoryType = .disclosureIndicator
            //设置单元格内容
            cell.textLabel?.text = channels[indexPath.row]["subTitle"].stringValue
            return cell
    }
     
    //处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取选中项信息
        let view = FindController.init()
        view.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
        let channelName = channels[indexPath.row]["title"].stringValue
        let channelId = channels[indexPath.row]["channel_id"].stringValue
        //使用我们的provider进行网络请求（根据频道ID获取下面的歌曲）
        DouBanProvider.request(.playlist(channelId)) { result in
            if case let .success(response) = result {
                //解析数据，获取歌曲信息
                let data = try? response.mapJSON()
                let json = JSON(data!)
//                let music = json["song"].arrayValue[0]
//                let artist = music["artist"].stringValue
//                let title = music["title"].stringValue
//                let message = "歌手：\(artist)\n歌曲：\(title)"
//                 
//                //将歌曲信息弹出显示
//                self.showAlert(title: channelName, message: message)
            }
        }
    }
     
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func backUP(){
        
        self.dismiss(animated: true, completion: nil)
    }
}

