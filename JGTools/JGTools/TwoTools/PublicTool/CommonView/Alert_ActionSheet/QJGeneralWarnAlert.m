//
//  QJGeneralWarnAlert.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJGeneralWarnAlert.h"


@interface QJGeneralWarnAlert ()

/** 弹窗 */
@property(nonatomic,strong) UIView *alertView;
/** title */
@property(nonatomic,strong) UILabel *titleLbl;
/** 内容 */
@property(nonatomic,strong) UILabel *msgLbl;
/** 确认按钮 */
@property(nonatomic,strong) UIButton *sureBtn;
/** 取消按钮 */
@property(nonatomic,strong) UIButton *cancleBtn;
/** 横线 */
@property (nonatomic, strong) UIView *HLine;
/** 竖线 */
@property (nonatomic, strong) UIView *VLine;




@end

@implementation QJGeneralWarnAlert


-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    if(self == [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.4];
        
        
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 9.0;
        _alertView.layer.position = self.center;
        
        _titleLbl = [UILabel new];
        _titleLbl.text = title;
        _titleLbl.textColor = [UIColor colorWithHexCode:@"#333333"];
        _titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        
        _msgLbl = [UILabel new];
        _msgLbl.numberOfLines = 0;
        _msgLbl.textColor = [UIColor colorWithHexCode:@"#333333"];
        _msgLbl.font = JGFont(14);
        
        NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
        paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
        paraStyle01.headIndent = 0.0f;//行首缩进
        //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
        CGFloat emptylen = _msgLbl.font.pointSize * 2;
        paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
        paraStyle01.tailIndent = 0.0f;//行尾缩进
        paraStyle01.lineSpacing = 2.0f;//行间距
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:message attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
        _msgLbl.attributedText = attrText;
        
        
        _HLine = [UIView new];
        _HLine.backgroundColor = [UIColor colorWithHexCode:@"#eeeeee"];
        
        
        _cancleBtn = [UIButton new];
        _cancleBtn.tag = 1;
        _cancleBtn.titleLabel.font = JGFont(17);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor colorWithHexCode:@"#666666"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        _VLine = [UIView new];
        _VLine.backgroundColor = [UIColor colorWithHexCode:@"#eeeeee"];
        
        _sureBtn = [UIButton new];
        _sureBtn.tag = 2;
        _sureBtn.titleLabel.font = JGFont(17);
        NSString *TitleStr = sureTitle.length ? sureTitle : @"确定";
        [_sureBtn setTitle:TitleStr forState:UIControlStateNormal];
        [_sureBtn setTitleColor:JGMainColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:_alertView];
        [_alertView addSubview:_titleLbl];
        [_alertView addSubview:_msgLbl];
        [_alertView addSubview:_HLine];
        [_alertView addSubview:_cancleBtn];
        [_alertView addSubview:_VLine];
        [_alertView addSubview:_sureBtn];
        
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(45);
            make.right.equalTo(self.mas_right).mas_offset(-45);
            make.centerY.equalTo(self.mas_centerY).mas_offset(-35);
            make.bottom.equalTo(_sureBtn.mas_bottom);
        }];
        
        
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_alertView.mas_centerX);
            make.top.equalTo(_alertView.mas_top).mas_offset(18);
        }];
        
        [_msgLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLbl.mas_bottom).mas_offset(12);
            make.left.equalTo(_alertView.mas_left).mas_offset(24);
            make.right.equalTo(_alertView.mas_right).mas_offset(-24);
        }];
        
        
        [_HLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_alertView.mas_left);
            make.right.equalTo(_alertView.mas_right);
            make.top.equalTo(_msgLbl.mas_bottom).mas_offset(19);
            make.height.equalTo(@(1));
        }];
        
        CGFloat W = (kDeviceWidth - 90) / 2.0;
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_alertView.mas_left);
            make.top.equalTo(_HLine.mas_bottom);
            make.width.equalTo(@(W));
            make.height.equalTo(@(45));
        }];
        
        [_VLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cancleBtn.mas_top);
            make.right.equalTo(_cancleBtn.mas_right);
            make.height.equalTo(_cancleBtn.mas_height);
            make.width.equalTo(@(1));
        }];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_VLine.mas_right);
            make.top.equalTo(_cancleBtn.mas_top);
            make.width.equalTo(_cancleBtn.mas_width);
            make.height.equalTo(_cancleBtn.mas_height);
        }];
        
    }
    return self;
}





#pragma mark - 弹出
-(void)showAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

-(void)creatShowAnimation {
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 回调 只设置2 -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender {
    if (sender.tag == 2) {
        if (self.backInfo) {
            self.backInfo(@(sender.tag));
        }
    }
    [self removeFromSuperview];
}


@end
