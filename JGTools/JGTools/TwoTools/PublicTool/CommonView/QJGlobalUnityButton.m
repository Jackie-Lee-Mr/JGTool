//
//  QJGlobalUnityButton.m
//  LH_QJ
//
//  Created by 郭军 on 2018/6/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJGlobalUnityButton.h"

@implementation QJGlobalUnityButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = JGFont(17);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:JGMainColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexCode:@"#cccccc"]] forState:UIControlStateDisabled];

        self.clipsToBounds = YES;
        self.layer.cornerRadius = 20.0f;
    }
    return self;
}


@end
