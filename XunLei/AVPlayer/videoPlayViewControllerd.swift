//
//  videoPlayViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import AVKit
class videoPlayViewControllerd: UIViewController {
    let urlString = "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"
     var player : AVPlayer!
     var palyerItem : AVPlayerItem!
     var bufferTimeLabel : UILabel!
      
      lazy var slider : UISlider = { [weak self] in
          let slider  = UISlider(frame: CGRect(x: 20, y: 300 + 30, width:(self?.view.frame.width)! - 40, height: 20))
          slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
          return slider
      }()
      
      lazy var loadTimeLabel : UILabel = { [weak self] in
          let loadTimeLabel = UILabel(frame: CGRect(x: 20, y: (self?.slider.frame.maxY)!, width: 100, height: 20))
          loadTimeLabel.text = "00:00:00"
        return loadTimeLabel
      }()
    
      lazy var totalTimeLabel : UILabel = { [weak self] in
          let totalTimeLabel =  UILabel(frame: CGRect(x: (self?.slider.frame.maxX)! - 100, y: (self?.slider.frame.maxY)!, width: 100, height: 20))
          totalTimeLabel.text = "00:00:00"
          return totalTimeLabel
      }()
      
      lazy var pasueButton : UIButton = { [weak self] in
          let button = UIButton(frame: CGRect(x: 20, y: 280, width: 60, height: 30))
          button.setTitle("暂停", for: .normal)
          button.setTitle("播放", for: .selected)
          button.setTitleColor(UIColor.white, for: .normal)
          button.backgroundColor = UIColor.black
          button.addTarget(self, action: #selector(pauseButtonSelected(sender:)), for: .touchUpInside)
          return button
      }()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AVPlayer播放视频"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.slider)
        self.view.addSubview(self.loadTimeLabel)
        self.view.addSubview(self.totalTimeLabel)
        self.view.addSubview(self.pasueButton)
        
        //创建媒体资源管理对象
        self.palyerItem = AVPlayerItem(url: NSURL(string: urlString)! as URL)
        //创建ACplayer：负责视频播放
        self.player = AVPlayer.init(playerItem: self.palyerItem)
        self.player.rate = 1.0//播放速度 播放前设置
        //创建显示视频的图层
        let playerLayer = AVPlayerLayer.init(player: self.player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        self.view.layer.addSublayer(playerLayer)
        //观察属性
        self.palyerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        self.palyerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        self.palyerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.palyerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        
        self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self](time) in
            //当前正在播放的时间
            let loadTime = CMTimeGetSeconds(time)
            //视频总时间
            let totalTime = CMTimeGetSeconds((self?.player.currentItem?.duration)!)
            //滑块进度
            self?.slider.value = Float(loadTime/totalTime)
            self?.loadTimeLabel.text = self?.changeTimeFormat(timeInterval: loadTime)
            self?.totalTimeLabel.text = self?.changeTimeFormat(timeInterval: CMTimeGetSeconds((self?.player.currentItem?.duration)!))
        }
    
/*
一般的音视频播放需要的功能如下
本地/网络音视频播放
屏幕滑动播放进度/亮度/音量
倍速播放
全屏幕状态自适应铺满调节
横竖屏适配功能切换
物理旋转时调整为全屏幕播放
在wifi条件下自动缓存网络视频
断点续播公能/不同清晰度的播放
自定义播放结束界面以及音频播放界面
远程控制带耳机或者拔掉耳机时需要暂停
后台播放功能视频和声音是否需要全部在后台播放
下一曲/步 上一步视频
视频下载//多视频下载操作网络状态的判断
封面图是否是直接拉取还是根据网络Url获取
通知//以及一些播放资源的释放
锁屏功能的实现
1，avplayer/avplayerController
第一种采用系统自带的方法:self.player replaceCurrentItemWithPlayerItem:Item]但是在切换playitem之前要把所有的通知观察者移除然后再去重新添加。
第二张又一个继承于avplayer的类库 avplayerquueq在里间添加avolayeritem到里面然后播放
  guard age > 18 else {
  return false
}
//guard 守门员的概念去声明在不满足guard的条件下去执行else里面的代码然后去执行响应的操作
  guard age > 18 else{
  return false/none guard age > 18 else{}
}
*/
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
extension videoPlayViewControllerd{
    //KVO观察
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            switch self.palyerItem.status{
                case .readyToPlay:
                    self.play()
                case .failed:
                    print("failed")
                case.unknown:
                    print("unkonwn")
            @unknown default:
                print("other type")
            }
        }else if keyPath == "loadedTimeRanges"{
            let loadTimeArray = self.palyerItem.loadedTimeRanges
            //获取最新缓存的区间
            let newTimeRange : CMTimeRange = loadTimeArray.first as! CMTimeRange
            let startSeconds = CMTimeGetSeconds(newTimeRange.start);
            let durationSeconds = CMTimeGetSeconds(newTimeRange.duration);
            let totalBuffer = startSeconds + durationSeconds;//缓冲总长度
            print("当前缓冲时间：%f",totalBuffer)
        }else if keyPath == "playbackBufferEmpty"{
            print("正在缓存视频请稍等")
        }
        else if keyPath == "playbackLikelyToKeepUp"{
            print("缓存好了继续播放")
            self.player.play()
        }
    }
    
    //播放
    func play(){
        self.player.play()
    }
    
    //暂停
    @objc func pauseButtonSelected(sender:UIButton)  {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            self.player.pause()
        }else{
            self.play()
        }
    }
    
    //播放进度
    @objc func sliderValueChange(sender:UISlider){
        if self.player.status == .readyToPlay {
            let time = Float64(sender.value) * CMTimeGetSeconds((self.player.currentItem?.duration)!)
            let seekTime = CMTimeMake(value: Int64(time), timescale: 1)
            self.player.seek(to: seekTime)
        }
    }
    
    //转时间格式
    func changeTimeFormat(timeInterval:TimeInterval) -> String{
        return String(format: "%02d:%02d:%02d",(Int(timeInterval) % 3600) / 60, Int(timeInterval) / 3600,Int(timeInterval) % 60)
    }
    
    @objc func playToEndTime(){
        print("播放完成")
    }
    
}
