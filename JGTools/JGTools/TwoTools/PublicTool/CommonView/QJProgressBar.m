//
//  QJProgressBar.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/28.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJProgressBar.h"

#define KProgressBorderWidth 1.0f
#define KProgressPadding 0.01f
#define KProgressColor [UIColor colorWithHexCode:@"#ffa101"]

@interface QJProgressBar ()

@property (nonatomic, strong) UIView *tView;


@end

@implementation QJProgressBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //边框
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        CGFloat heigth = self.bounds.size.height;
        borderView.layer.cornerRadius = heigth * 0.5f;
        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = [UIColor colorWithHexCode:@"#eeeeee"];
        [self addSubview:borderView];
        
        
        //进度
        _tView = [[UIView alloc] init];
        _tView.backgroundColor = KProgressColor;
        _tView.layer.cornerRadius = heigth * 0.5f;
        _tView.layer.masksToBounds = YES;
        [self addSubview:_tView];
    }
    
    return self;
}


- (void)setProgressColor:(UIColor *)ProgressColor {
    _ProgressColor = ProgressColor;
    _tView.backgroundColor = ProgressColor;

}



- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat heigth = self.bounds.size.height;
    
    _tView.frame = CGRectMake(0, 0, maxWidth * progress, heigth);
}


@end
