//
//  FindController.swift
//  XunLei
//
//  Created by abc on 2020/9/28.
//  Copyright © 2020 abc. All rights reserved.
import UIKit
import WebKit
import WebViewJavascriptBridge
/* https://blog.csdn.net/zjpjay/article/details/103310279#1.JS%20与%20OC%20交互
 如果没有进行交互即oc端与swift的交互用如果不能去满足上述开发需求的情况下我们使用wkwebview的时候需要去使用当前的
 第一步如果uiwebview消耗太多内存会造成appcrasj
 如果wkwebview占用太多消耗内存会造成wkwebview展示出来的页面为nil
 这种情况下需要去借助uinavigationDelegate去处理当前的事件【webview reload】
 判断当前webview.title是否为nil进行重新加载
 wkewbview与oc进行交互
 wkwbview调用js方法 直接evaluteJavaScript后面加String给js传递参数或者调用js方法一般是方法名称()里面是要传递的参数
 js调用oc的方法并传值 WKuserController声明方法 然后再代理方法里面WkScriptMessagehandler里面进行方法的didReceiver方法里面进行最后的代码使用去满足开发需求。
 注意创建wkuserController的时候的内存泄漏问题然后一般是重新的controller来处理，新的controller再绕用delegate绕回来。避免在使用过程中内存泄漏
 wkwebviewBriger
 regieset/callhandler 一边注册一边调用
 */
class FindController: UIViewController,WKUIDelegate,WKNavigationDelegate {
  var webview = WKWebView()
  var btnBack = UIBarButtonItem()
  var btnForward = UIBarButtonItem()
  var progBar = UIProgressView()
  //register//callHandler 去再这两块去注册
  override func viewDidLoad() {
        super.viewDidLoad()
        let navHeight = self.navigationController?.navigationBar.frame.height
        //获取状态栏高度
        let statusHeight = SystemUtil.getStatusBarHight()
        // 创建wkwebview
        webview = WKWebView(frame: CGRect(x: 0, y: statusHeight+navHeight!, width: self.view.frame.width, height: self.view.frame.height))
         setNavBar()
        webview.navigationDelegate = self
        // 创建网址
        let url = NSURL(string: "http://www.baidu.com")
        // 创建请求
        let request = NSURLRequest(url: url! as URL)
        // 加载请求
        webview.load(request as URLRequest)
        // 添加wkwebview
        self.view.addSubview(webview)
        
        // 加载网页的进度条
        progBar = UIProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        progBar.progress = 0.0
        self.view.bringSubviewToFront(progBar)
        progBar.tintColor = UIColor.red
        webview.addSubview(progBar)
        // 监听网页加载的进度
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        // Do any additional setup after loading the view.
    }
  override func viewWillDisappear(_ animated: Bool) {
      webview.removeObserver(self, forKeyPath: "estimatedProgress")
  }
  // MARK: - WKNavigationDelegate
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      self.navigationItem.title = webview.title
  }
  
  // MARK: - WKUIDelegate
  func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
      // 实现非安全链接的跳转。如果目标主视图不为空,则允许导航
      if !(navigationAction.targetFrame?.isMainFrame != nil) {
          webview.load(navigationAction.request)
      }
      return nil
  }
  func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
      // 修复弹窗弹出的问题
      let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
          completionHandler()
      }))
      self.present(alert, animated: true, completion: nil)
  }
  
  // MARK: - webview function
  
  @objc func toBack() {
      if webview.canGoBack {
          webview.goBack()
      }
  }
   
  @objc func toForward() {
      if webview.canGoForward {
          webview.goForward()
      }
  }
  
  func setNavBar() {
      btnBack = UIBarButtonItem(title: "后退", style: .plain, target: self, action: #selector(toBack))
      btnForward = UIBarButtonItem(title: "前进", style: .plain, target: self, action: #selector(toForward))
      self.navigationItem.rightBarButtonItems = [btnBack, btnForward]
  }
  
  // MARK: - KVO

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
      if keyPath == "estimatedProgress" {
          self.progBar.alpha = 1.0
          print(webview.estimatedProgress);
          progBar.setProgress(Float(webview.estimatedProgress), animated: true)
           //进度条的值最大为1.0
          if(self.webview.estimatedProgress >= 1.0) {
              UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: { () -> Void in
                  self.progBar.alpha = 0.0
              }, completion: { (finished:Bool) -> Void in
                  self.progBar.progress = 0
              })
          }
      }
  }
  
  override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
      
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
