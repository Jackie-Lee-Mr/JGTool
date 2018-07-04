//
//  JGPasswordErrorView.h
//  JGPayPassWordDemo
//
//  Created by 郭军 on 2017/9/15.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGPasswordErrorView : UIView

@property (nonatomic, strong) UIButton *onceButton;
@property (nonatomic, strong) UIButton *forgetPwdButton;
@property (nonatomic, assign) NSInteger limit;

- (void)showInView:(UIView *)view;
- (void)hide;

@end
