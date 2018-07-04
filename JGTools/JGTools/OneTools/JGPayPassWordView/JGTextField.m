//
//  JGTextField.m
//  JGPayPassWordDemo
//
//  Created by 郭军 on 2017/9/15.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import "JGTextField.h"

@implementation JGTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
