//
//  OneDayViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class OneDayViewController: UIViewController {
    
    enum oneerrorType:String {
       
        case north = "像素混合"
        case south = "离屏渲染"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UI层级的性能优化";
        var allArray:[String] = ["内存优化","FPS优化"]
         allArray.append("用户体验优化")
        // Do any additional setup after loading the view.
        let onetips = "对象的创建设会分配内存设置属性会消耗cpu资源所以尽量使用轻的对象代替能用CALayer的时候不用UIview敏感位置能不能用IB尽量使用纯代码手写"
        let view = CALayer.init()
        self.view.layer.addSublayer(view)
        view.backgroundColor = UIColor.purple.cgColor
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        /*
         tips calayer给view提供了基础的设施使得绘制内容和呈现更高动画变得更容易性能更高
          calayer不参与响应者链不会响应交互事件
         uiview继承于uiresponse calayer继承于NSobject uiview比nsobject多了一个用户响应操作 uiview来来自于Calayer是calayer的高级封装和实现uivew的所有特征来自于calayer
         cabsasicAnimation。。。CAAnimation cakeyframeAnimation等动画都是绘制在Calayer上的所以这些动画是不会响应点击操作的
         关于DrawDectDrawDect是属于CoreGraphic框架占用CPU消耗性能大
         CAShaperlayer属于CoreAnimation框架通过Gpu来渲染图形节省性能动画渲染直接提交到手机GPU不消耗内存
         当视图层次调整时，UIView、CALayer 之间会出现很多方法调用与通知，所以在优化性能时，应该尽量避免调整视图层次、添加和移除视图避免调整试图层次添加和删除试图会造成大量内存泄漏
         当前类持有大量对象时候，其销毁时候的资源消耗就非常明显。建议创建销毁的异步队列，将需要销毁的对象放到队列中销
         布局计算在UITableView使用中是最常见的消耗资源的地方。建议取到数据之后，异步进行计算布局并缓存下来，当复用Cell时候直接调用缓存数据
         CALAyer 圆角/则着/阴影 casharplayer的历练图x看是通常会触发离屏渲染而离屏渲染通常发生在GPU中我们可以把它赚到cpu中可以尝试开启CALayer.shouldRasterize属性但这会把原本最好就是使用图片圆角则早去解决
         */
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
