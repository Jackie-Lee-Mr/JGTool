//
//  QJProgressBar.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/28.
//  Copyright © 2018年 LHYD. All rights reserved.
//  进度条

#import <UIKit/UIKit.h>

@interface QJProgressBar : UIView

@property (nonatomic, assign) CGFloat progress;

/** 进度条颜色 */
@property (nonatomic, strong) UIColor *ProgressColor;


@end
