//
//  QJTimeCountDownView.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJTimeCountDownView : UIView


// 时间戳
@property (nonatomic,assign)NSInteger timestamp;
// 背景
@property (nonatomic,copy)NSString *backgroundImageName;
// 时间停止后回调
@property (nonatomic,copy)TimerStopBlock timerStopBlock;

// 分割 : 的宽度
@property (nonatomic,assign)NSInteger PaddingWidth;
// 时间数字的宽度
@property (nonatomic,assign)NSInteger TimeLblWidth;
/**
 *  创建单例对象
 */
+ (instancetype)shareCountDown;// 工程中使用的倒计时是唯一的

/**
 *  创建非单例对象
 */
+ (instancetype)countDown; // 工程中倒计时不是唯一的

@end
