//
//  XZNumberKeyBoard.h
//  MortgageCalculator-Swift
//
//  Created by gozap on 2021/6/4.
//  Copyright © 2021 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZNumberKeyBoard : UIView
/**
 *  传入想改变键盘的输入框
 *
 *  @param view & TextView
 */
- (void)setInputView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
