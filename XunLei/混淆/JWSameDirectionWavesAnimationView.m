//
//  JWSameDirectionWavesAnimationView.m
//  JasonDemo
//
//  Created by jasonwang on 2017/2/6.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#define WATERCOLOR   [UIColor colorWithR:135 g:206 b:250 alpha:0.3]

#import "JWSameDirectionWavesAnimationView.h"
#import "UIColor+Hex.h"

@interface JWSameDirectionWavesAnimationView ()
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;

@property (nonatomic) double waveA; //水纹振幅    表示上面的A
@property (nonatomic) CGFloat waveW;//水纹周期  表示上面的ω
@property (nonatomic) CGFloat offsetX; //位移   表示上面的φ
@property (nonatomic) CGFloat currentK; //当前波浪高度Y   表示上面的C
@property (nonatomic) CGFloat waveSpeed;//水纹速度   表示波浪流动的速度
@property (nonatomic) CGFloat waterWaveWidth; //水纹宽度
@property (nonatomic, strong) UIColor *firstWaveColor; //波浪的颜色
@end
@implementation JWSameDirectionWavesAnimationView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor =  WATERCOLOR;
        self.layer.masksToBounds  = YES;
        self.offsetX = 0.0;
    }
    return self;
}

- (void)setUp {
    //设置波浪的宽度
    self.waterWaveWidth = self.bounds.size.width;
    //设置波浪的颜色
    self.firstWaveColor = WATERCOLOR;
    //设置波浪的速度
    self.waveSpeed = 0.4/M_PI;
    //初始化layer
    if (_firstWaveLayer == nil) {
        //初始化
        _firstWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        //        _firstWaveLayer.strokeColor = [UIColor blueColor].CGColor;
        //        //设置边缘线的宽度
        //        _firstWaveLayer.lineWidth = 4.0;
        //        _firstWaveLayer.strokeStart = 0.0;
        //        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (self.secondWaveLayer == nil) {
        //初始化
        self.secondWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        self.secondWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        //        _firstWaveLayer.strokeColor = [UIColor blueColor].CGColor;
        //        //设置边缘线的宽度
        //        _firstWaveLayer.lineWidth = 4.0;
        //        _firstWaveLayer.strokeStart = 0.0;
        //        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:self.secondWaveLayer];
    }
    //设置波浪流动速度
    self.waveSpeed = 0.04;
    //设置振幅
    self.waveA = 5;
    //设置周期
    self.waveW = 1/40.0;
    //设置波浪纵向位置
    self.currentK = 75;
    //启动定时器
    self.waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    //慢动作
//    self.waveDisplaylink.frameInterval = 10;
    [self.waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

}

-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    //实时的位移
    self.offsetX += self.waveSpeed;
    double intPart;
    //取得整数部分
    modf(self.offsetX, &intPart);
    NSLog(@"%lf",intPart);
    //整数取余，5秒中张开一秒
    if (fmod(intPart, 5) == 0) {
        if (self.waveA <= 8) {
            //张开速度
            self.waveA += 0.2;
            self.currentK += 0.2;
        }
    }
    else {
        if (self.waveA >= 5) {
            //闭合速度
            self.waveA -= 0.5;
            self.currentK -= 0.5;
        }
    }
    [self setCurrentFirstWaveLayerPath];
    [self setCurrentSecondWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath
{
    //创建一个路径
    UIBezierPath *path = [UIBezierPath new];
    CGFloat y = self.currentK;
    //将点移动到 x=0,y=currentK的位置
    [path moveToPoint:CGPointMake(0, y)];
    for (NSInteger x = 0.0f; x<=self.waterWaveWidth; x++) {
        //正玄波浪公式
        y = self.waveA * sin(self.waveW * x + self.offsetX)+self.currentK;
        //将点连成线
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.waterWaveWidth, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    self.firstWaveLayer.path = path.CGPath;
}

-(void)setCurrentSecondWaveLayerPath
{
    //创建一个路径
    UIBezierPath *path = [UIBezierPath new];
    CGFloat y = self.currentK;
    //将点移动到 x=0,y=currentK的位置
    [path moveToPoint:CGPointMake(0, y)];
    for (NSInteger x = 0.0f; x<=self.waterWaveWidth; x++) {
        //正玄波浪公式
        y = (self.waveA) * sin((self.waveW) * x + self.offsetX + M_PI)+self.currentK;
        //将点连成线
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.waterWaveWidth, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    self.secondWaveLayer.path = path.CGPath;
}

- (void)toDealloc
{
    [_waveDisplaylink invalidate];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
