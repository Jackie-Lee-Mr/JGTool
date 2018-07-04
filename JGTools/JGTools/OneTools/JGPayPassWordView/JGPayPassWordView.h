//
//  JGPayPassWordView.h
//  JGPayPassWordDemo
//
//  Created by 郭军 on 2017/9/15.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGPayPassWordView;
@protocol JGPayPasswordViewDelegate <NSObject>

/**
 输入密码完毕的回调
 
 @param passwordView 输入密码视图
 @param password 回调输入的密码
 */
@optional
- (void)passwordView:(JGPayPassWordView *)passwordView didFinishInputPayPassword:(NSString *)password;

/**
 忘记密码
 */
- (void)forgetPayPassword;
@end


@interface JGPayPassWordView : UIView



@property (nonatomic, weak) id<JGPayPasswordViewDelegate> delegate;

- (void)showInView:(UIView *)view;

- (void)hide;

- (void)paySuccess;

- (void)payFailureWithPasswordError:(BOOL)passwordError withErrorLimit:(NSInteger)limit;






@end
