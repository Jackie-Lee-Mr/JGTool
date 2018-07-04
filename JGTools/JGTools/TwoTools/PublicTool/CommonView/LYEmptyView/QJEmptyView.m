//
//  QJEmptyView.m
//  LH_QJ
//
//  Created by 郭军 on 2018/6/16.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJEmptyView.h"

@implementation QJEmptyView

+ (instancetype)diyEmptyView{
    
    return [QJEmptyView emptyViewWithImageStr:@"noData"
                                       titleStr:@"暂无数据"
                                      detailStr:@"请稍后再试!"];
}

+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action{
    
    return [QJEmptyView emptyActionViewWithImageStr:@"noNetwork"
                                             titleStr:@"无网络连接"
                                            detailStr:@"请检查你的网络连接是否正确!"
                                          btnTitleStr:@"重新加载"
                                               target:target
                                               action:action];
}

- (void)prepare{
    [super prepare];
    
    self.autoShowEmptyView = NO;
    
    self.titleLabTextColor = JGRGBColor(180, 30, 50);
    self.titleLabFont = [UIFont systemFontOfSize:18];
    
    self.detailLabTextColor = JGRGBColor(80, 80, 80);
}


@end
