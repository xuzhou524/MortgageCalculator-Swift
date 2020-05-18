//
//  MortgageCalculator-Swift.m
//  MortgageCalculator-Swift
//
//  Created by gozap on 2020/3/19.
//  Copyright © 2020 com.longdai. All rights reserved.
//

#import "MortgageCalculator-Swift.h"

#import <GoogleMobileAds/GADInterstitialDelegate.h>
@import GoogleMobileAds;

@interface MortgageCalculator_Swift()<GADInterstitialDelegate>{
    
    UIViewController * _adViewController;
}

@property (nonatomic, strong) UIWindow* window;

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation MortgageCalculator_Swift

//在load 方法中，启动监听，可以做到无注入
+ (void)load{
    [self shareInstance];
}

+ (instancetype)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        #ifdef DEBUG
        #else
        [self views];
        #endif
        
    }
    return self;
}

-(void)views{
 
    ///如果是没啥经验的开发，请不要在初始化的代码里面做别的事，防止对主线程的卡顿，和 其他情况
    ///应用启动, 首次开屏广告
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        ///要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
        [self show];
        [self CheakAd];
    }];
    ///进入后台
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
    }];
    ///后台启动,二次开屏广告
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self show];
        [self CheakAd];
    }];
    
}

-(void)CheakAd{//这一部分的逻辑大家根据自身需求定制
    //谷歌插屏广告
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-9353975206269682/2521277821"];
    self.interstitial.delegate=self;
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
}

- (void)show{
    ///初始化一个Window， 做到对业务视图无干扰。
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _adViewController = [UIViewController new];
    window.rootViewController = _adViewController;
    window.rootViewController.view.backgroundColor = [UIColor clearColor];
    window.rootViewController.view.userInteractionEnabled = NO;

    ///广告布局
//    [self setupSubviews:window];
    
    ///设置为最顶层，防止 AlertView 等弹窗的覆盖
    window.windowLevel = UIWindowLevelStatusBar + 1;
    
    ///默认为YES，当你设置为NO时，这个Window就会显示了
    window.hidden = NO;
    window.alpha = 1;
    
    ///防止释放，显示完后  要手动设置为 nil
    self.window = window;
}

- (void)hide{
    ///来个渐显动画
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}

///初始化显示的视图， 可以挪到具
- (void)setupSubviews:(UIWindow*)window{
    ///随便写写
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
    //和启动图一样，给用户造成错觉
    imageView.image = [UIImage imageNamed:@"ADImage.png"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    [window addSubview:imageView];
}

#pragma mark -GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{//接收到插屏广告
    [self.interstitial presentFromRootViewController:_adViewController];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{//插屏广告请求失败
    [self hide];
}

/**********************/
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    //插屏广告即将开始
    NSLog(@"插屏广告即将开始");
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];
}

- (void)Timered:(NSTimer*)timer {
    [self hide];
}

- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad{
    //插屏广告失败
    NSLog(@"插屏广告失败");
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    //插屏广告即将消失
    NSLog(@"插屏广告即将消失");
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    //插屏广告已经消失
    NSLog(@"插屏广告已经消失");
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    //插屏广告即将离开APP
    NSLog(@"插屏广告即将离开APP");
}

@end
