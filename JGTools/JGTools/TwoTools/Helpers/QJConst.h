//
//  QJConst.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/4.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 用于界面传值 */
typedef void(^ReturnBackInfo)(id data);


/** 刷新时 每次 加载 数据量 */
UIKIT_EXTERN NSString const *JGRefreshCount;


/** 跳转到 指定控制器 通知名称 */
UIKIT_EXTERN NSString * const JGGoToVCNotification;

/** 我的界面 点击登录 通知名称 */
UIKIT_EXTERN NSString * const JGMineHeaderLoginNotification;
