//
//  QJActionSheetNoCancle.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/12.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJActionSheetNoCancle.h"

@interface QJActionSheetNoCancle()

@property (nonatomic, strong) UIView *TotalV;
@end


@implementation QJActionSheetNoCancle


- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    if (self = [super init]) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        
        self.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHight);
        
        
        _TotalV = [UIView new];
        _TotalV.backgroundColor = [UIColor whiteColor];
        
        UIButton *FirstBtn = [UIButton new];
        FirstBtn.titleLabel.font = JGFont(15);
        [FirstBtn setTitleColor:JG333Color forState:UIControlStateNormal];
        [FirstBtn setTitle:titles[0] forState:UIControlStateNormal];
        [FirstBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *Line = [UIView new];
        Line.backgroundColor = JGLineColor;
        
        UIButton *SecondBtn = [UIButton new];
        SecondBtn.titleLabel.font = JGFont(15);
        [SecondBtn setTitleColor:JG333Color forState:UIControlStateNormal];
        [SecondBtn setTitle:titles[1] forState:UIControlStateNormal];
        [SecondBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_TotalV];
        [_TotalV addSubview:FirstBtn];
        [_TotalV addSubview:Line];
        [_TotalV addSubview:SecondBtn];

        [_TotalV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom).mas_offset((IphoneXTabbarH - 49));
            make.height.equalTo(@(100.5));
        }];
        
        [FirstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_TotalV.mas_left);
            make.right.equalTo(_TotalV.mas_right);
            make.top.equalTo(_TotalV.mas_top);
            make.height.equalTo(@(50));
        }];
        
        [Line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_TotalV.mas_left);
            make.right.equalTo(_TotalV.mas_right);
            make.top.equalTo(FirstBtn.mas_bottom);
            make.height.equalTo(@(0.5));
        }];
        
        [SecondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_TotalV.mas_left);
            make.right.equalTo(_TotalV.mas_right);
            make.top.equalTo(Line.mas_bottom);
            make.height.equalTo(@(50));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}



- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    [self dismissView];
}


- (void)BtnClick:(UIButton *)btn {
    
    if (self.backInfo) {
        [self dismissView];
        self.backInfo(btn.currentTitle);
    }    
}



- (void)showView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismissView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
