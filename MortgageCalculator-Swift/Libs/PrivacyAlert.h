//
//  Alert.h
//  WMDoctor
//
//  Created by Mr.Zmac on 2021/7/2.
//  Copyright © 2021 Choice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface PrivacyAlert : UIView


- (void)showOnComplete:(void(^)(BOOL result))completion;

@end

@interface UIButton (targetBlock)
/**点击回调block,代替addTarget:action:forControlEvents,注意回环引用*/
- (void)addTargetActionBlock:(void (^)(UIButton *aButton))atBlock;
 
/**主动执行以上回调*/
- (void)performTargetActionBlock;
@end
NS_ASSUME_NONNULL_END
