//
//  ReactiveExtensiones.swift
//  
//
//  Created by Mohammad Zakizadeh on 7/27/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa

extension UIViewController: loadingViewable {}
//extension Reactive where Base: UIViewController为自己的代理方法添加Reactive扩展呢
extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}
/*
 使用binder创建观察者
 （1）不会处理错误事件 （2）确定绑定都是在给定的Scheduler上执行默认MainScheduler
   一旦产生错误事件在调试环境下将执行fatalError在发布环境下打印错误信息
 extensoion syntax
 第一个作用 extension可以给一个类添加一个或者多个协议
 extension可以让一个特定的类型实现一个或者多个协议也就是说无论对于class structure或者enum等类型而言可以都可以实现一个或者多个协议 类别/结构体/枚举
 第二种作用
 添加计算属性
 extension可以为已经存在的类型添加计算属性 swift有2种属性一种是存储熟悉一种是计算属性存储属性就是存储在特定class和Struct中的一个常量和变量可以在定义存储属性的时候设置和修改指定默认值也可以在构造过程中修改或设置存储属性的值需要注意的是enum中并不能定义存储属性而计算属性不能直接存粗而是提供了一个getter setter来获取和修改其他属性和变量的值。
 
 extension可以为已经存在的类(class)添加便捷初始化方法一般已经存在的class和结构体添加初始化方法去进行初始法操作
 extension 可以和category相似 可以为其添加实例方法和类型方法即我们常说的通过 static去区分
 extension Reactive where Base: UIViewController
 这句话就是通过extension为UIViewController添加一个Reactview属性
  public var isAnimating: Binder<Bool> 我们将isAnimating变量实现为类型Binder<Bool>的UIViewController以便可以绑定
 return Binder(self.base, binding: { (vc, active) in
 这里去进行绑定结果操作去绑定给当前视图添加rx属性通过闭包去获取view和active然后在适当的时候显示出来并将数据展示处理。
 */
