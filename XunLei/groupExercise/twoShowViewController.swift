//
//  twoShowViewController.swift
//  XunLei
//
//  Created by abc on 2020/10/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class twoShowViewController: UIViewController {
    let disposeBage = DisposeBag()
    @IBOutlet weak var inputTextView: UITextField!
    var oneShow:vmModelShow!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.testONE()
        //self.testONE1()
        //self.DispatchQueueTest()
        //self.twoTest()
        //self.dealWithTest()
        //同步栅栏和异步栅栏都能够阻塞队列上的任务,但是最大的区别在于能否阻塞当前线程 同步栅栏异步栅栏能够阻塞队列任务
        //创建一个串型队列执行异步任务 执行同步任务//不要在主列队中执行同步任务，这样会造成死锁问题 不要在主线程执行同步任务这样会死锁的呀线程死锁
        let delay = DispatchTime.now() + 10
        DispatchQueue.main.asyncAfter(deadline: delay) {
            // 延迟执行
        }
        //线程数大于核数两倍的时候会比较耗性能 现场数量大于内核数目2倍的时候会消耗大量的性能所以不这样去写
        //信号量并发执行5次
        DispatchQueue.concurrentPerform(iterations: 5) {
            print("\($0)")
        }
        //同步队列 异步队列任务
        let queue = DispatchQueue(label: "1313131213131")//同步围栏和异步围栏的围栏效果操作是为了一些读写操作的安全性
        let queue1 = DispatchQueue(label: "eqeqeqeqeqeqweq")//默认是串型队列
        let queue2 = DispatchQueue.global()
        let queue3 = DispatchQueue.main
        queue.sync {
         print("12121212121")
        }
        queue.sync {
          print("eeqeqeqeqeqweq")
        }
        queue.sync {
           print("eqeqeqeqewqeqeqw")
         }
        
//        self.oneShow = vmModelShow.init(textPusblish:self.inputTextView.rx.text.orEmpty.asObservable())
//        self.oneShow.showEnd.subscribe(onNext: { (text) in
//            print(text)
//            }).disposed(by:disposeBage)
        
//        let globalQueue1 = DispatchQueue.global(qos: .background)
//         globalQueue1.async {
//        //do someThigb
//        }
        
        
      /*
        driver的使用提供了一种简单的ui编程代码的响应式编程代码 它满足一下3个条件 不会产生error当产生error的时候可以返回自己业务逻辑错误的提示
         一定在主线程监听UI
        共享状态变化()
*/
      self.oneShow = vmModelShow.init(oneShow: self.inputTextView.rx.text.orEmpty.asDriver())
        
        self.oneShow.pageshow.drive(onNext: { (text) in
            
         print(text)
           
        }).disposed(by: disposeBage)
        
        // Do any additional setup after loading the view.
    }
//异步任务线程组 一个一个添加任务当其他一系列任务完成后最后去执行监听完成任务后的回调
    public func DispatchQueueTest(){
    let queue = DispatchQueue.global()
    let group = DispatchGroup()
    group.enter()
    queue.async(group: group) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
             print("Task one finished")
             group.leave()
        })
     }
     group.enter()
     queue.async(group: group) {
         print("Task two finished")
         group.leave()
     }
   
     group.enter()
     queue.async(group: group) {
         print("Task three finished")
         group.leave()
     }
   
     group.notify(queue: queue) {
         print("All task has finished")
     }
}
//监听任务一个一个的按照一定的顺讯的依次执行 信号量使用single加1使用value减一一一对应起来去满足我们开发需求
    
    public func dealWithTest(){
    
        let serialQueue = DispatchQueue(label: "com.my.queue")
        serialQueue.async {
           print("task one")
        }
        serialQueue.async {
           print("task two")
        }
        serialQueue.async {
           print("task three")
        }
    }
    
    public func twoTest(){
    
          let queue = DispatchQueue.global()
          let group = DispatchGroup()
          let semaphore = DispatchSemaphore(value: 1)
           
           semaphore.wait()
         
           queue.async(group: group) {
                    
           print("Task one finished")
            
           semaphore.signal()
            
          }
        
         semaphore.wait()
        
         queue.async(group: group) {
                     
           print("Task two finished")
            
             semaphore.signal()
                  
          }
         
         semaphore.wait()
         queue.async(group: group) {
              print("Task three finished")
            
             semaphore.signal()
          }
        
  }
    func testONE (){
    let 队列 = DispatchQueue(label: "队列的名称")
        队列.sync {
            for i in 0..<3{
                
                print(i,terminator: "")
                
            }
            print(Thread.current)
        }
    
    队列.sync {
               for i in 3..<6{
                   
                   print(i,terminator: "")
                   
               }
               print(Thread.current)
           }
    
    for i in 6..<9{
        
        print(i,terminator: "")
        print(Thread.current)
    }
        
    }
       
        func testONE1 (){
        let 队列 = DispatchQueue(label: "队列的名称")
            队列.async {
                for i in 0..<3{
                    
                    print(i,terminator: "")
                    
                }
                print(Thread.current)
            }
        
        队列.async {
                   for i in 3..<6{
                       
                       print(i,terminator: "")
                       
                   }
                   print(Thread.current)
               }
        
        for i in 6..<9{
            
            print(i,terminator: "")
            print(Thread.current)
        }
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
