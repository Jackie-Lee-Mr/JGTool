//
//  JGUIConstumButton.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/19.
//  Copyright © 2018年 LHYD. All rights reserved.
//  自定义按钮

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JGUIConstumButtonType) {
    /** 默认图片在左边 */
   JGUIConstumButtonTypeNormal = 0,
    /** 默认图片在右边 */
   JGUIConstumButtonTypeRight = 1,
    /** 默认图片在上边 */
   JGUIConstumButtonTypeTop = 2,
    /** 默认图片在下边 */
   JGUIConstumButtonTypeBottom = 3,
};



@interface JGUIConstumButton : UIControl

/** 按钮图片 */
@property (nonatomic, strong) UIImageView *CBImageView;
/** 按钮标签 */
@property (nonatomic, strong) UILabel *CBTitleLabel;

- (instancetype)initWithFrame:(CGRect)frame buttonType:(JGUIConstumButtonType)type;
@end
