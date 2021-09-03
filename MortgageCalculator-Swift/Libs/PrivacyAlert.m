//
//  Alert.m
//  WMDoctor
//
//  Created by Mr.Zmac on 2021/7/2.
//  Copyright © 2021 Choice. All rights reserved.
//

#import "PrivacyAlert.h"


#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

typedef void (^ButtonActionBlock)(UIButton *thisButton);
 
@implementation UIButton (targetBlock)
 
- (void)addTargetActionBlock:(void (^)(UIButton *aButton))atBlock
{
    [self setActionBlock:atBlock];
    
    [super addTarget:self action:@selector(buttonDidTouchIniside) forControlEvents:UIControlEventTouchUpInside];
}
 
 
- (void)buttonDidTouchIniside
{
    ButtonActionBlock aBlock = [self actionBlock];
    if (aBlock)
    {
        aBlock(self);
    }
}
 
 
- (void)performTargetActionBlock
{
    [self buttonDidTouchIniside];
}
 
 
- (ButtonActionBlock)actionBlock
{
    return objc_getAssociatedObject(self, "targetBlock");
}
 
 
- (void)setActionBlock:(ButtonActionBlock)actionBlock
{
    objc_setAssociatedObject(self, "targetBlock", actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

@interface PrivacyAlert ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *backgroundView;



@end

@implementation PrivacyAlert{
    
    UILabel *titleLabel;
    UITextView *textView;

    UIButton *cancelBtn;
    UIButton *bottomBtn;

}

- (void)showOnComplete:(void(^)(BOOL result))completion {
    __weak typeof(self) weakSelf = self;
    
    self.hidden = NO;
        
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [keyWindow  addSubview:self];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.2/2,SCREEN_HEIGHT*0.5/2, SCREEN_WIDTH*0.8, SCREEN_HEIGHT * 0.5)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 15.0;
    [self addSubview:_backgroundView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, _backgroundView.frame.size.width - 40, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGBA(73, 71, 102, 1);
    titleLabel.text = @"隐私权政策";
    [_backgroundView addSubview:titleLabel];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 50, _backgroundView.frame.size.width - 40, _backgroundView.frame.size.height - 190)];
    textView.text = @"";
//    textView.font = [UIFont systemFontOfSize:18];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.textColor = RGBA(73,71,102,1);
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.backgroundColor = [UIColor clearColor];
    textView.tintColor = [UIColor blackColor];
    textView.editable = NO;
    textView.scrollEnabled = YES;
//    textView.selectable = NO;
    
    NSMutableAttributedString *messageText = [[NSMutableAttributedString alloc] initWithString:@"感谢您使用【AdKleinSDKDemo】，为了让您更加放心地使用本产品，请您务必仔细阅读，充分理解政策中的条款内容后再点击同意,以便您能够更好地行使个人权利和保护个人信息。\n请您注意，如果您不同意其中任何条款约定，您可以点击不同意，暂停使用本产品。如果您点击同意即表示您已阅读和同意《隐私政策》。"];
    
    [messageText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [messageText length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing: 6];
    [messageText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [messageText length])];
    
//    NSRange rangeUserAgreement = [[messageText string] rangeOfString:@"《用户协议》"];
    NSRange rangePrivacyAgreement = [[messageText string] rangeOfString:@"《隐私政策》"];

    //设置富文本超链接属性
//    [messageText addAttribute:NSLinkAttributeName value:@"userAgreement://" range:rangeUserAgreement];
    [messageText addAttribute:NSLinkAttributeName value:@"privacyAgreement://" range:rangePrivacyAgreement];
    
    textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                         NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    textView.delegate = self;
    textView.attributedText = messageText;
    
    [_backgroundView addSubview:textView];
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(20, _backgroundView.frame.size.height - 130, _backgroundView.frame.size.width - 40, 50);
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.cornerRadius = 24.0;
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"ic_MyLoanBg"] forState:UIControlStateNormal];
//    bottomBtn.backgroundColor = [UIColor orangeColor];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTargetActionBlock:^(UIButton * _Nonnull aButton) {
        [weakSelf hide];
        if (completion)
        {
            completion(YES);
        }
    }];
    [bottomBtn setTitle:@"同意并继续" forState:UIControlStateNormal];
    [_backgroundView addSubview:bottomBtn];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(20, _backgroundView.frame.size.height - 70, _backgroundView.frame.size.width - 40, 50);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 24.0;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    cancelBtn.backgroundColor = RGBA(153, 151, 169, 0.3);
    [cancelBtn setTitleColor:RGBA(73, 71, 102, 1) forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn addTargetActionBlock:^(UIButton * _Nonnull aButton) {
        [weakSelf hide];
        if (completion)
        {
            completion(NO);
        }
    }];
    [cancelBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [_backgroundView addSubview:cancelBtn];
       
    cancelBtn.tag = 10000;
    bottomBtn.tag = 10001;
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_backgroundView.layer addAnimation:animation forKey:nil];
}



- (void)hide{
    self.hidden = YES;
    [self removeFromSuperview];
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"userAgreement"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.iusmob.com/doc/ua.html"] options: @{} completionHandler: nil];
        return NO;
    } else if ([[URL scheme] isEqualToString:@"privacyAgreement"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.iusmob.com/doc/privacy.html"] options: @{} completionHandler: nil];
        return NO;
    }
    return YES;
}

@end
