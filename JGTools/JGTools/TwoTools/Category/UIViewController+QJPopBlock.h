//
//  UIViewController+QJPopBlock.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopBlock)(UIBarButtonItem *backItem);

@interface UIViewController (QJPopBlock)

@property(nonatomic,copy)PopBlock popBlock;

@end
