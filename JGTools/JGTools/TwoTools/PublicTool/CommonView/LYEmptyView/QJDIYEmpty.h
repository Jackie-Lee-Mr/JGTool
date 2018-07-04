//
//  QJDIYEmpty.h
//  LH_QJ
//
//  Created by 郭军 on 2018/6/16.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "LYEmptyView.h"

@interface QJDIYEmpty : LYEmptyView


+ (instancetype)diyNoDataEmpty;

+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action;

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action;


@end
