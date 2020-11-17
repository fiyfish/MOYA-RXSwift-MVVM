//
//  JWWavesAnimationViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2016/12/15.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "JWWavesAnimationViewController.h"
#import "JWWavesAnimationView.h"
#import "JWSameDirectionWavesAnimationView.h"

@interface JWWavesAnimationViewController ()
@property (nonatomic, strong) JWSameDirectionWavesAnimationView *sameWave;
@property (nonatomic, strong) JWWavesAnimationView *waveView;

@end

@implementation JWWavesAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"波浪";
    
    self.sameWave = [[JWSameDirectionWavesAnimationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.view addSubview:_sameWave];
    
    
    self.waveView = [[JWWavesAnimationView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 200) / 2, ([[UIScreen mainScreen] bounds].size.height - 120) / 2, 200, 120)];
    [_waveView.layer setCornerRadius:50];
    [_waveView setClipsToBounds:YES];
    
    [self.view addSubview:_waveView];
    
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
    
    //mask 蒙版
    CALayer *maskLayer = [CALayer layer];
    [maskLayer setFrame:self.waveView.bounds];
    maskLayer.contents = (id)[UIImage imageNamed:@"123456"].CGImage;
    self.waveView.layer.mask = maskLayer;

    [_waveView setUp];
    [_sameWave setUp];
    
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [self.sameWave toDealloc];
    [self.waveView toDealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
