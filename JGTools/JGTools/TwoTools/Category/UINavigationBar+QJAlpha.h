//
//  UINavigationBar+QJAlpha.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (QJAlpha)
- (void)jg_setBackgroundColor:(UIColor *)backgroundColor isHiddenBottomBlackLine:(BOOL)isHiddenBottomBlackLine;
///获取UINavigationBar的颜色
- (UIColor *)jg_getBackgroundColor;

- (void)jg_setContentAlpha:(CGFloat)alpha;
- (void)jg_setTranslationY:(CGFloat)translationY;
- (void)jg_reset;
@end
