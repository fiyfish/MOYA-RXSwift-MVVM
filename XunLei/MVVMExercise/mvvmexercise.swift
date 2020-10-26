//
//  mvvmexercise.swift
//  XunLei
//
//  Created by abc on 2020/10/16.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class mvvmexercise: NSObject {
    let dispose = DisposeBag()
    //输出
    let username:Observable<Bool>
    let telePhoname:Observable<Bool>
    let allSure:Observable<Bool>
    //let dealThig:Observable<Bool>
    init(
       //输入
        userNameText:Observable<String>,
        telphomeText:Observable<String>,
        buttonClick:Observable<Void>
    
    ) {
        username = userNameText.map{$0.count>5}.share(replay:1)
        telePhoname = telphomeText.map{$0.count > 5}.share(replay:1)
        allSure = Observable.combineLatest(username,telePhoname){$0&&$1}.share(replay:1)
        buttonClick.asObservable().subscribe(onNext: { (next) in

            
            print("qqqqqqqqq")
            
        }).disposed(by: dispose)
    }
}
/*
 var optional1 String? = nil
 var optional2 String? =.None
 nil和.None有什么区别 optioanal和optioanal2的变量有何不同
 其实没有任何不同 Optioanl.none 下面写法是正确的 nil = .None
 请记住在底层下 optional是个枚举类型：
 enum Optional<T>{
 case None
 case some(T)
}
 enum Optional<T>{
 case None
 case some(T)
 }
 //可选值类型None/some（T）
可选值的底层实现是个枚举类型一个是case None 一个是Some(T)
 import Foundation
 import RxCocoa
 import RxSwift
 import SafariServices
 在结构体内部函数修改内部状态必须是可变类型数据即用var表明的而不是用let去表明修改函数内部值类型的用var/let去进行值类型表明升级的
 private只能访问当前数据文件中的实体/swift的文件范围是基于源文件作用于整个源文件如果一个源文件有两个类那个一个类可以访问另一个类的私有成员
 internal可以访问当前模块中的其他私有实体但是模块外无妨访问默认访问权限//程序中公有中访问权限 private文件内私有低访问权限 public内外公有高访问权限
 public可以访问模块内和模块外中的任何实体约束
 private let loginURL = URL(string: "http://github.com/login/oauth/authorize?client_id=\(Keys.github.appId)&scope=user+repo+notifications+read:org")!
 private let callbackURLScheme = "swifthub"

 class LoginViewModel: ViewModel, ViewModelType {

     struct Input {
         let segmentSelection: Driver<LoginSegments>
         let basicLoginTrigger: Driver<Void>
         let oAuthLoginTrigger: Driver<Void>
     }

     struct Output {
         let basicLoginTriggered: Driver<Void>
         let oAuthLoginTriggered: Driver<Void>
         let basicLoginButtonEnabled: Driver<Bool>
         let hidesBasicLoginView: Driver<Bool>
         let hidesOAuthLoginView: Driver<Bool>
     }

     let login = BehaviorRelay(value: "")
     let password = BehaviorRelay(value: "")
     let code = PublishSubject<String>()
     var tokenSaved = PublishSubject<Void>()
     private var _authSession: Any?

     private var authSession: SFAuthenticationSession? {
         get {
             return _authSession as? SFAuthenticationSession
         }
         set {
             _authSession = newValue
         }
     }

     func transform(input: Input) -> Output {
         let basicLoginTriggered = input.basicLoginTrigger
         let oAuthLoginTriggered = input.oAuthLoginTrigger

         basicLoginTriggered.drive(onNext: { [weak self] () in
             if let login = self?.login.value,
                 let password = self?.password.value,
                 let authHash = "\(login):\(password)".base64Encoded {
                 AuthManager.setToken(token: Token(basicToken: authHash))
                 self?.tokenSaved.onNext(())
             }
         }).disposed(by: rx.disposeBag)

         oAuthLoginTriggered.drive(onNext: { [weak self] () in
             self?.authSession = SFAuthenticationSession(url: loginURL, callbackURLScheme: callbackURLScheme, completionHandler: { (callbackUrl, error) in
                 if let error = error {
                     logError(error.localizedDescription)
                 }
                 if let codeValue = callbackUrl?.queryParameters?["code"] {
                     self?.code.onNext(codeValue)
                 }
             })
             self?.authSession?.start()
         }).disposed(by: rx.disposeBag)

         code.flatMapLatest { (code) -> Observable<RxSwift.Event<Token>> in
             let clientId = Keys.github.appId
             let clientSecret = Keys.github.apiKey
             return self.provider.createAccessToken(clientId: clientId, clientSecret: clientSecret, code: code, redirectUri: nil, state: nil)
                 .trackActivity(self.loading)
                 .trackError(self.error)
                 .materialize()
             }.subscribe(onNext: { [weak self] (event) in
                 switch event {
                 case .next(let token):
                     AuthManager.setToken(token: token)
                     self?.tokenSaved.onNext(())
                 case .error(let error):
                     logError(error.localizedDescription)
                 default: break
                 }
             }).disposed(by: rx.disposeBag)

         tokenSaved.flatMapLatest { () -> Observable<RxSwift.Event<User>> in
             return self.provider.profile()
                 .trackActivity(self.loading)
                 .trackError(self.error)
                 .materialize()
             }.subscribe(onNext: { (event) in
                 switch event {
                 case .next(let user):
                     user.save()
                     AuthManager.tokenValidated()
                     if let login = user.login, let type = AuthManager.shared.token?.type().description {
                         analytics.log(SwifthubEvent.login(login: login, type: type))
                     }
                     Application.shared.presentInitialScreen(in: Application.shared.window)
                 case .error(let error):
                     logError(error.localizedDescription)
                     AuthManager.removeToken()
                 default: break
                 }
             }).disposed(by: rx.disposeBag)

         let basicLoginButtonEnabled = BehaviorRelay.combineLatest(login, password, self.loading.asObservable()) {
             return $0.isNotEmpty && $1.isNotEmpty && !$2
         }.asDriver(onErrorJustReturn: false)

         let hidesBasicLoginView = input.segmentSelection.map { $0 != LoginSegments.basic }
         let hidesOAuthLoginView = input.segmentSelection.map { $0 != LoginSegments.oAuth }

         return Output(basicLoginTriggered: basicLoginTriggered,
                       oAuthLoginTriggered: oAuthLoginTriggered,
                       basicLoginButtonEnabled: basicLoginButtonEnabled,
                       hidesBasicLoginView: hidesBasicLoginView,
                       hidesOAuthLoginView: hidesOAuthLoginView)
     }
 }
 
 import UIKit
 import RxSwift
 import RxCocoa
 import SafariServices

 enum LoginSegments: Int {
     case oAuth, basic

     var title: String {
         switch self {
         case .oAuth: return R.string.localizable.loginOAuthSegmentTitle.key.localized()
         case .basic: return R.string.localizable.loginBasicSegmentTitle.key.localized()
         }
     }
 }
 //枚举 segmentedControl的布局展示效果
 class LoginViewController: ViewController {
 //使用懒加载去加载各种视图
     lazy var segmentedControl: SegmentedControl = {
         let items = [LoginSegments.oAuth.title, LoginSegments.basic.title]
         let view = SegmentedControl(sectionTitles: items)
         view.selectedSegmentIndex = 0
         view.snp.makeConstraints({ (make) in
             make.width.equalTo(250)
         })
         return view
     }()

     lazy var basicLoginStackView: StackView = {
         let subviews: [UIView] = [self.basicLogoImageView, self.loginTextField, self.passwordTextField, self.basicLoginButton]
         let view = StackView(arrangedSubviews: subviews)
         return view
     }()

     lazy var oAuthLoginStackView: StackView = {
         let subviews: [UIView] = [self.oAuthLogoImageView, self.titleLabel, self.detailLabel, self.oAuthLoginButton]
         let view = StackView(arrangedSubviews: subviews)
         return view
     }()

     lazy var basicLogoImageView: ImageView = {
         let view = ImageView(image: R.image.image_no_result()?.template)
         return view
     }()

     lazy var loginTextField: TextField = {
         let view = TextField()
         view.textAlignment = .center
         view.keyboardType = .emailAddress
         view.autocapitalizationType = .none
         return view
     }()

     lazy var passwordTextField: TextField = {
         let view = TextField()
         view.textAlignment = .center
         view.isSecureTextEntry = true
         return view
     }()

     lazy var basicLoginButton: Button = {
         let view = Button()
         view.imageForNormal = R.image.icon_button_github()
         view.centerTextAndImage(spacing: inset)
         return view
     }()

     lazy var oAuthLogoImageView: ImageView = {
         let view = ImageView(image: R.image.image_no_result()?.template)
         return view
     }()

     lazy var titleLabel: Label = {
         let view = Label()
         view.font = view.font.withSize(22)
         view.textAlignment = .center
         return view
     }()

     lazy var detailLabel: Label = {
         let view = Label()
         view.font = view.font.withSize(17)
         view.numberOfLines = 0
         view.textAlignment = .center
         return view
     }()

     lazy var oAuthLoginButton: Button = {
         let view = Button()
         view.imageForNormal = R.image.icon_button_github()
         view.centerTextAndImage(spacing: inset)
         return view
     }()

     private lazy var scrollView: ScrollView = {
         let view = ScrollView()
         self.contentView.addSubview(view)
         view.snp.makeConstraints({ (make) in
             make.edges.equalToSuperview()
         })
         return view
     }()

     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
     }

     override func makeUI() {
         super.makeUI()

         languageChanged.subscribe(onNext: { [weak self] () in
             self?.loginTextField.placeholder = R.string.localizable.loginLoginTextFieldPlaceholder.key.localized()
             self?.passwordTextField.placeholder = R.string.localizable.loginPasswordTextFieldPlaceholder.key.localized()
             self?.basicLoginButton.titleForNormal = R.string.localizable.loginBasicLoginButtonTitle.key.localized()
             self?.titleLabel.text = R.string.localizable.loginTitleLabelText.key.localized()
             self?.detailLabel.text = R.string.localizable.loginDetailLabelText.key.localized()
             self?.oAuthLoginButton.titleForNormal = R.string.localizable.loginOAuthloginButtonTitle.key.localized()
             self?.segmentedControl.sectionTitles = [LoginSegments.oAuth.title,
                                                     LoginSegments.basic.title]
             self?.navigationItem.titleView = self?.segmentedControl
         }).disposed(by: rx.disposeBag)

         stackView.removeFromSuperview()
         scrollView.addSubview(stackView)
         stackView.snp.makeConstraints({ (make) in
             make.top.bottom.equalToSuperview().inset(self.inset*2)
             make.centerX.equalToSuperview()
             make.width.equalTo(300)
         })

         themeService.rx
             .bind({ $0.text }, to: titleLabel.rx.textColor)
             .bind({ $0.textGray }, to: detailLabel.rx.textColor)
             .bind({ $0.text }, to: basicLogoImageView.rx.tintColor)
             .bind({ $0.text }, to: oAuthLogoImageView.rx.tintColor)
             .disposed(by: rx.disposeBag)

         stackView.addArrangedSubview(basicLoginStackView)
         stackView.addArrangedSubview(oAuthLoginStackView)
         bannerView.isHidden = true
     }

     override func bindViewModel() {
         super.bindViewModel()
         guard let viewModel = viewModel as? LoginViewModel else { return }

         let segmentSelected = Observable.of(segmentedControl.segmentSelection.map { LoginSegments(rawValue: $0)! }).merge()
         let input = LoginViewModel.Input(segmentSelection: segmentSelected.asDriverOnErrorJustComplete(),
                                          basicLoginTrigger: basicLoginButton.rx.tap.asDriver(),
                                          oAuthLoginTrigger: oAuthLoginButton.rx.tap.asDriver())
         let output = viewModel.transform(input: input)

         viewModel.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
         viewModel.parsedError.asObservable().bind(to: error).disposed(by: rx.disposeBag)

         isLoading.asDriver().drive(onNext: { [weak self] (isLoading) in
             isLoading ? self?.startAnimating() : self?.stopAnimating()
         }).disposed(by: rx.disposeBag)

         output.basicLoginButtonEnabled.drive(basicLoginButton.rx.isEnabled).disposed(by: rx.disposeBag)

         _ = loginTextField.rx.textInput <-> viewModel.login
         _ = passwordTextField.rx.textInput <-> viewModel.password

         output.hidesBasicLoginView.drive(basicLoginStackView.rx.isHidden).disposed(by: rx.disposeBag)
         output.hidesOAuthLoginView.drive(oAuthLoginStackView.rx.isHidden).disposed(by: rx.disposeBag)

         error.subscribe(onNext: { [weak self] (error) in
             var title = ""
             var description = ""
             let image = R.image.icon_toast_warning()
             switch error {
             case .serverError(let response):
                 title = response.message ?? ""
                 description = response.detail()
             }
             self?.view.makeToast(description, title: title, image: image)
         }).disposed(by: rx.disposeBag)
     }
 }

 */
