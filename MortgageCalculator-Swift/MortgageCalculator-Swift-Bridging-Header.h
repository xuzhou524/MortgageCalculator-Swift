//
//  MortgageCalculator-Swift-Bridging-Header.h
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/6.
//  Copyright © 2017年 com.longdai. All rights reserved.
//


#if DEBUG
//官方测试id
#define CONST_MEDIA_ID @"194254620"
#define CONST_SPLASH_ID @"141846962557" //开屏
#define CONST_BANNER_ID @"106467382054" //横幅广告iOS

#else
//线上真实id
#define CONST_MEDIA_ID @"162037215"
#define CONST_SPLASH_ID @"139294856223" //开屏
#define CONST_BANNER_ID @"137668415637" //横幅广告iOS

#endif


#import "XZNumberKeyBoard.h"
#import "YBPopupMenu.h"
#import "PrivacyAlert.h"
