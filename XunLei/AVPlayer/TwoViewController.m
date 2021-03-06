//
//  TwoViewController.m
//  XunLei
//
//  Created by abc on 2020/10/27.
//  Copyright © 2020 abc. All rights reserved.
//

#import "TwoViewController.h"
typedef void(^block)();
static  const CFTimeInterval duration = 3.0;

@interface TwoViewController ()<NSURLSessionDataDelegate>
@property(nonatomic,strong) CABasicAnimation * animation;
@property(nonatomic,strong)UIImageView *grayHeadImgView;
@property (copy, nonatomic) block myBlock;  // 2
/** green */
@property(nonatomic,strong)UIImageView *greenHeadImgView;
@property (nonatomic, strong) CAShapeLayer *maskLayerUp;
@property (nonatomic, strong) CAShapeLayer *maskLayerDown;
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation TwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//使用__weak打破循环的方法只在ARC下才有效，在MRC下应该使用__block
//双向持有对象self.block里面再去调用self这次就会造城循环引用的效果
    __weak typeof(self) weakSelf = self;
    //一个网络请求的地址range 范围 Content—length///Content-length
    self.myBlock = ^() {
        //其实注释中的代码，同样会造成循环引用
        weakSelf.view.backgroundColor = [UIColor blueColor]; // 1
          //NSString *localString = _blockString;
          //[self doSomething];
    };
    UIButton * oneBUtton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [self.view addSubview:oneBUtton];
    oneBUtton.backgroundColor = [UIColor purpleColor];
    [oneBUtton addTarget:self action:@selector(clickUPShowView) forControlEvents:UIControlEventTouchUpInside];
    //    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    NSURL * url = [NSURL URLWithString:@"http://api.nohttp.net/method?name=yanzhenjie&pwd=123"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];
    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    //或者用下面这种方式添加所有请求头信息
    request.allHTTPHeaderFields = @{@"Content-Encoding":@"gzip"};
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    //NSURLSession * shredSesson = [NSURLSession sharedSession]; apple会提供session
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
    configuration.timeoutIntervalForRequest = 10;//设置请求超时时间10分钟
    configuration.allowsCellularAccess = NO;//在蜂窝情况下是否继续上传下载
    configuration.HTTPAdditionalHeaders = @{@"Content-Encoding":@"gzip"};
    NSURLSessionDataTask * task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        printf("%s", object);
    }];
//[uploadTask resume]; 文件上传 下载以及恢复线程 启动任务去进行任务的操作
/*
 NSSessionTask一般有4种下列情况 NSURLSesionDataTask//一般的get post等请求
 NSURLSessionUploadTak//用于上传文件或者数据量比较大的请求
 NSURLSessionDownloadTask//用于下载文件或者数据量比较大的请求
NSURLSessionStreamTask//建立一个TCp//IP连接的主机名和端口或一个网络服务对象
 task的三个函数///第一个 suspend 暂停/resume 开始或者恢复///cancle 关闭任务
 */
//pose请求
//    NSURL * ur = [NSURL URLWithString:@"http://api.nohttp.net/postBody"];
//    NSMutableURLRequest * request1 = [NSMutableURLRequest requestWithURL:url];
//    [request1 setTimeoutInterval:10.0];
//    [request1 setHTTPMethod:@"POST"];
//    [request1 addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
//    NSDictionary *parametersDict = @{@"name":@"yanzhenjie",@"pwd":@"123"};NSMutableString *parameterString = [[NSMutableString alloc]init];
//    int pos =0;
//    for (NSString *key in parametersDict.allKeys) {
//        // 拼接字符串
//        [parameterString appendFormat:@"%@=%@", key, parametersDict[key]];
//        if(pos<parametersDict.allKeys.count-1){
//            [parameterString appendString:@"&"];
//        }
//        pos++;
//    }
//     NSData *parametersData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:parametersData];
//      NSURLSessionConfiguration *configuration1 = [NSURLSessionConfiguration defaultSessionConfiguration];
//     NSURLSession *session1 = [NSURLSession sessionWithConfiguration:configuration1];
//    NSURLSessionDataTask * task1 = [session dataTaskWithURL:ur completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//
//    }];
//
//    [task1 resume];//在这里去执行任务去进行代码的开发
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //在layer层级上添加一个核心动画一般绘制动画用的是贝塞尔曲线+cashaper描点+cabasicanimatoin进行绘制过程中的动画
    self.view.backgroundColor = UIColor.whiteColor;
        CGFloat imgWH = 60;
       self.grayHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWH, imgWH)];
       self.grayHeadImgView.image = [UIImage imageNamed:@"bull_head_gray"];
       self.grayHeadImgView.center = self.view.center;
       [self.view addSubview:self.grayHeadImgView];
       
       self.greenHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWH, imgWH)];
       self.greenHeadImgView.image = [UIImage imageNamed:@"bull_head_green"];
       self.greenHeadImgView.center = self.view.center;
       [self.view addSubview:self.greenHeadImgView];
        self.greenHeadImgView.layer.mask = [self greenHeadMaskLayer];
       
    
    CABasicAnimation* animationDown = [CABasicAnimation animationWithKeyPath:@"position"];
    animationDown.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    animationDown.toValue = [NSValue valueWithCGPoint:CGPointMake(25.0f, 25.0f)];
    animationDown.duration = duration;
    animationDown.removedOnCompletion = 0;
    animationDown.repeatCount = MAXFLOAT;
    [self.maskLayerUp addAnimation:animationDown forKey:@"downAnimation"];
    
    CABasicAnimation* animationUp = [CABasicAnimation animationWithKeyPath:@"position"];
    animationUp.fromValue = [NSValue valueWithCGPoint:CGPointMake(65.f, 65.f)];
    animationUp.toValue = [NSValue valueWithCGPoint:CGPointMake(35.f, 35.f)];
    animationUp.duration = duration;
    animationUp.removedOnCompletion = 0;
    animationUp.repeatCount = MAXFLOAT;
    [self.maskLayerDown addAnimation:animationUp forKey:@"upAnimation"];
    
    UILabel * oneLable = [[UILabel alloc]init];
    [self.view addSubview:oneLable];
    oneLable.hidden = YES;
    oneLable.frame = CGRectMake(50,50,100,100);
    oneLable.backgroundColor = UIColor.purpleColor;
    self.animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
    self.animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.animation.duration = 0.88;       //执行时间
    self.animation.repeatCount = 9999999;      //执行次数
    self.animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    self.animation.fromValue = [NSNumber numberWithFloat:1];   //初始伸缩倍数
    self.animation.toValue = [NSNumber numberWithFloat:0.8];
    self.animation.removedOnCompletion = NO;//结束伸缩倍数
    [oneLable.layer addAnimation:self.animation forKey:@"is_show"];
    // Do any additional setup after loading the view.
  
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(375/2-100, 667/2-100, 200, 200)];
        
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3.0;
    animation.fromValue = @(0);
    animation.toValue = @(0.85);
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;//结束伸缩倍数
        
    CAShapeLayer *layer = [self createShapeLayerNoFrame:[UIColor clearColor]];
    layer.path = path.CGPath;
    layer.lineWidth = 25.0;
    //圆的起始位置，默认为0
    layer.strokeStart = 0;
    //圆的结束位置，默认为1，如果值为0.75，则显示3/4的圆
    layer.strokeEnd = 1;
    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
}
- (void)updateTimer {
    NSLog(@"%s",__func__);
}
- (CAShapeLayer *)createShapeLayerNoFrame:(UIColor *)color
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    //    layer.frame = CGRectMake(0, 0, 50, 50);
    //设置背景色
    //    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置描边色
    layer.strokeColor = [UIColor yellowColor].CGColor;
    //设置填充色
    layer.fillColor = color.CGColor;
    [self.view.layer addSublayer:layer];
    
    return layer;
}
- (CALayer*)greenHeadMaskLayer {
    CALayer* mask = [CALayer layer];
    mask.frame = self.greenHeadImgView.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 60.0f, 60.f);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:30.0f startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 60.f,60.f);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:30.0 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    self.maskLayerDown.position = CGPointMake(65.f, 65.f);
    [mask addSublayer:self.maskLayerDown];
    
    return mask;
}
-(void)clickUPShowView
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
//UI层 UI层级别的优化 动画 列表 分组元素
//网络层 网络数据的获取//不同数据的区别
//数据解析层 json转model 模型的创建
//第三方功能集成 git的使用分支的合并 swift和oc的混合开发//主要是视频播放和直播相关的内容
//方法 响应式编程 函数式编程 rxswift/raC的使用
//设计模式 单利 代理 block 工程模式 监听模式
//项目架构 mvc//mvvm（rxswift负责双向数据绑定）
//开发语言 swift oc
//组件化项目功能 cocoapods 本地仓库以及私有仓库 cocoapods的使用以及了解 carthage的使用以及了解
//单元测试///性能优化///用户行为监听///
//按照业务逻辑划分项目层级 --基础层--
//项目容错处理避免崩溃是否以性能的代价避免app出现崩溃的情况
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
