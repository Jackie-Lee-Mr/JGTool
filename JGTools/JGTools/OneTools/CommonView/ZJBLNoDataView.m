//
//  ZJBLNoDataView.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/7/5.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLNoDataView.h"

@implementation ZJBLNoDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _Icon = [UIImageView new];
        _Icon.image = [UIImage imageNamed:@"no_data"];
        
        
        [self addSubview:_Icon];
        
        [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).mas_offset(145);
            make.width.equalTo(@(94));
            make.height.equalTo(@(130));
        }];
        
    }
    return self;
}

@end
