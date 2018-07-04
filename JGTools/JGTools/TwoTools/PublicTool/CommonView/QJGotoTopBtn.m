//
//  QJGotoTopBtn.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/27.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJGotoTopBtn.h"

@implementation QJGotoTopBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.titleLabel.font = JGFont(8);
        [self setTitleColor:[UIColor colorWithHexCode:@"#666666"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        
        [self setTitle:@"返回顶部" forState:UIControlStateNormal];
        [self setImage:Image(@"Global_go_top") forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat x = (w - 14) / 2.0;
    
    self.titleLabel.frame = CGRectMake(0, 5, w, 10);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(x, self.titleLabel.bottom + 10, 14, 14);
    self.imageView.contentMode = UIViewContentModeCenter;

}


@end
