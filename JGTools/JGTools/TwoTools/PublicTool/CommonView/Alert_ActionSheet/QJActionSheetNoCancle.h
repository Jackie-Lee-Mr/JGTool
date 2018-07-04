//
//  QJActionSheetNoCancle.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/12.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJActionSheetNoCancle : UIView

@property (nonatomic, copy) ReturnBackInfo backInfo;



- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

/**
 显示弹出框
 */
- (void)showView;

@end
