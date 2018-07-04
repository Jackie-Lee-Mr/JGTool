//
//  QJCountDownView.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/9.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimerStopBlock)(void);

@interface QJCountDownView : UIView

// 时间戳
@property (nonatomic,assign)double timestamp;
// 背景
@property (nonatomic,copy)NSString *backgroundImageName;
// 时间停止后回调
@property (nonatomic,copy)TimerStopBlock timerStopBlock;
/** *  字体 default is [UIFont fontWithName:@"Arial" size:11] */
@property (nonatomic, strong) UIFont *TitleFont;
/** *  文字颜色 default is 999 */
@property (nonatomic, strong) UIColor *TitleColor;

/**
 *  创建单例对象
 */
+ (instancetype)shareCountDown;// 工程中使用的倒计时是唯一的

/**
 *  创建非单例对象
 */
+ (instancetype)countDown; // 工程中倒计时不是唯一的

/**
 *  关闭定时器
 */
- (void)CloseTimer;



@end
