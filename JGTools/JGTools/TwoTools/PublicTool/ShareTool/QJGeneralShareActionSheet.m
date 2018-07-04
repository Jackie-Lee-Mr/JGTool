//
//  QJGeneralShareActionSheet.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJGeneralShareActionSheet.h"


@interface GeneralShareButton : UIButton

@end


@implementation GeneralShareButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = JGFont(11);
        [self setTitleColor:JG333Color forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat x = (w - 35) / 2.0;
    
    self.imageView.frame = CGRectMake(x, 9, 35, 35);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.frame = CGRectMake(0, self.imageView.bottom + 9, w, 13);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end





@interface QJGeneralShareActionSheet() {
    
    CGFloat _HelpFreeHight;
    UITapGestureRecognizer *_TapGesture;
}


/** 商品整体内容 */
@property(nonatomic,retain) UIView *ContentView;
//商品图片
@property (nonatomic, strong) UIImageView *Icon;
//用户图像
@property (nonatomic, strong) UIImageView *UserIcon;
//用户昵称
@property (nonatomic, strong) UILabel *UserNameLbl;
//商品名称
@property (nonatomic, strong) UILabel *GoodNameLbl;
//描述
@property (nonatomic, strong) UILabel *DescLbl;
//商品价格
@property (nonatomic, strong) UILabel *PriceLbl;
//商品价格
@property (nonatomic, strong) UILabel *PriceLbl1;
//二维码领取
@property (nonatomic, strong) UILabel *CodeLbl;
//二维码
@property (nonatomic, strong) UIImageView *CodeIcon;

@property(nonatomic,retain) UIView *ShareView;

@end






@implementation QJGeneralShareActionSheet



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //        self.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, kDeviceHight - SJHeight);
        //        self.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, kDeviceHight - SJHeight);
        
        
        self.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.7];
        
        
        _ContentView = [UIView new];
        _ContentView.backgroundColor = [UIColor whiteColor];
        _ContentView.clipsToBounds = YES;
        _ContentView.layer.cornerRadius = 5.0f;
        _ContentView.hidden = YES;
        
        _Icon = [UIImageView new];
        _Icon.backgroundColor = [UIColor yellowColor];
        
        
        _UserIcon = [UIImageView new];
        _UserIcon.backgroundColor = [UIColor blueColor];
        
        
        _UserNameLbl = [UILabel new];
        _UserNameLbl.text = @"爱吃鱼的猫";
        _UserNameLbl.textColor = JG333Color;
        _UserNameLbl.font = JGFont(14);
        
        _GoodNameLbl = [UILabel new];
        //        _GoodNameLbl.text = @"我免费领取了好吃的好喝的零食";
        _GoodNameLbl.textColor = JG666Color;
        _GoodNameLbl.font = JGFont(12);
        
        
        _DescLbl = [UILabel new];
        _DescLbl.text = @"快来和我一起免费领取吧";
        _DescLbl.textColor = [UIColor colorWithHexCode:@"#e73a33"];
        _DescLbl.font = JGFont(12);
        
        
        UILabel *PriceL = [UILabel new];
        PriceL.text = @"¥";
        PriceL.textColor = JGMainColor;
        PriceL.font = JGFont(12);
        
        
        _PriceLbl = [UILabel new];
        _PriceLbl.text = @"0";
        _PriceLbl.textColor = JGMainColor;
        _PriceLbl.font = JGFont(20);
        
        
        _PriceLbl1 = [UILabel new];
        //        _PriceLbl1.text = @"¥29.00";
        _PriceLbl1.textColor = JG666Color;
        _PriceLbl1.font = JGFont(11);
        
        
        _CodeLbl = [UILabel new];
        _CodeLbl.text = @"长按二维码领取";
        _CodeLbl.textColor = JG666Color;
        _CodeLbl.font = JGFont(11);
        
        _CodeIcon = [UIImageView new];
        _CodeIcon.backgroundColor = [UIColor brownColor];
        
        
        
        _ShareView = [UIView new];
        _ShareView.backgroundColor = [UIColor whiteColor];
        
        
        GeneralShareButton *wcfBtn = [GeneralShareButton new];
        [wcfBtn setTitle:@"朋友圈" forState:UIControlStateNormal];
        [wcfBtn setImage:Image(@"share_wx_friend") forState:UIControlStateNormal];
        [wcfBtn addTarget:self action:@selector(wcfBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        GeneralShareButton *wcBtn = [GeneralShareButton new];
        [wcBtn setTitle:@"微信好友" forState:UIControlStateNormal];
        [wcBtn setImage:Image(@"share_wx") forState:UIControlStateNormal];
        [wcBtn addTarget:self action:@selector(wcBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        GeneralShareButton *qqBtn = [GeneralShareButton new];
        [qqBtn setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqBtn setImage:Image(@"share_qq") forState:UIControlStateNormal];
        [qqBtn addTarget:self action:@selector(qqBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        GeneralShareButton *qqZoneBtn = [GeneralShareButton new];
        [qqZoneBtn setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneBtn setImage:Image(@"share_qq_zone") forState:UIControlStateNormal];
        [qqZoneBtn addTarget:self action:@selector(qqZoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self addSubview:_ContentView];
        [_ContentView addSubview:_Icon];
        [_ContentView addSubview:_UserIcon];
        [_ContentView addSubview:_UserNameLbl];
        [_ContentView addSubview:_GoodNameLbl];
        [_ContentView addSubview:_DescLbl];
        [_ContentView addSubview:PriceL];
        [_ContentView addSubview:_PriceLbl];
        [_ContentView addSubview:_PriceLbl1];
        [_ContentView addSubview:_CodeLbl];
        [_ContentView addSubview:_CodeIcon];
        
        [self addSubview:_ShareView];
        [_ShareView addSubview:wcfBtn];
        [_ShareView addSubview:wcBtn];
        [_ShareView addSubview:qqBtn];
        [_ShareView addSubview:qqZoneBtn];
        
        
        
        [_ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(_ShareView.mas_top).mas_offset(-112);
            make.width.equalTo(@(315));
            make.height.equalTo(@(354));
        }];
        
        [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_ContentView);
            make.height.equalTo(@(210));
        }];
        
        [_UserIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ContentView.mas_left).mas_offset(10);
            make.top.equalTo(_Icon.mas_bottom).mas_offset(15);
            make.width.height.equalTo(@(37));
        }];
        
        [_UserNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_UserIcon.mas_centerY);
            make.left.equalTo(_UserIcon.mas_right).mas_offset(10);
        }];
        
        [_GoodNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_UserIcon.mas_bottom).mas_offset(8);
            make.left.equalTo(_UserIcon.mas_left);
            make.right.equalTo(_CodeIcon.mas_left).mas_offset(-10);
        }];
        
        [_DescLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_GoodNameLbl.mas_bottom).mas_offset(9);
            make.left.equalTo(_UserIcon.mas_left);
        }];
        
        [PriceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_PriceLbl.mas_bottom).mas_offset(-2);
            make.left.equalTo(_UserIcon.mas_left);
        }];
        
        [_PriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_DescLbl.mas_bottom).mas_offset(10);
            make.left.equalTo(PriceL.mas_right);
        }];
        
        [_PriceLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_PriceLbl.mas_bottom).mas_offset(-2);
            make.left.equalTo(_PriceLbl.mas_right);
        }];
        
        [_CodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_CodeIcon.mas_top).mas_offset(-7);
            make.centerX.equalTo(_CodeIcon.mas_centerX);
        }];
        
        [_CodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_ContentView.mas_right).mas_offset(-15);
            make.width.height.equalTo(@(67));
            make.bottom.equalTo(_ContentView.mas_bottom).mas_offset(-23);
        }];
        
        
        [_ShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(75 + IphoneXTH));
        }];
        
        
        CGFloat btnW = kDeviceWidth / 4.0f;
        [wcfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ShareView.mas_left);
            make.top.equalTo(_ShareView.mas_top);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(75));
        }];
        
        [wcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wcfBtn.mas_right);
            make.top.equalTo(_ShareView.mas_top);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(75));
        }];
        
        [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wcBtn.mas_right);
            make.top.equalTo(_ShareView.mas_top);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(75));
        }];
        
        [qqZoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(qqBtn.mas_right);
            make.top.equalTo(_ShareView.mas_top);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(75));
        }];
        
        _TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseBtnClick:)];
        _TapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_TapGesture];
    }
    return self;
}


//标记 分享方式 Index_Share 1 微信朋友圈 2 微信好友 3 qq好友 4 qq空间

- (void)wcfBtnClick {
    
    self.ShareModel.Index_Share = 1;
    self.ShareModel.snapImage = [UIImage snapshotWithView:_ContentView] ;

    if (self.backInfo) {
        self.backInfo(self.ShareModel);
    }
    
    [self CloseBtnClick:_TapGesture];
}

- (void)wcBtnClick {
    
    self.ShareModel.Index_Share = 2;
    self.ShareModel.snapImage = [UIImage snapshotWithView:_ContentView] ;

    
    if (self.backInfo) {
        self.backInfo(self.ShareModel);
    }
    
    [self CloseBtnClick:_TapGesture];
}

- (void)qqBtnClick {
    
    self.ShareModel.Index_Share = 3;
    self.ShareModel.snapImage = [UIImage snapshotWithView:_ContentView] ;

    
    if (self.backInfo) {
        self.backInfo(self.ShareModel);
    }
    
    [self CloseBtnClick:_TapGesture];
}


- (void)qqZoneBtnClick {
    
    self.ShareModel.Index_Share = 4;
    self.ShareModel.snapImage = [UIImage snapshotWithView:_ContentView] ;

    if (self.backInfo) {
        self.backInfo(self.ShareModel);
    }
    
    [self CloseBtnClick:_TapGesture];
}



- (void)setShareModel:(QJGeneralShareModel *)ShareModel {
    _ShareModel = ShareModel;
    
    [_Icon sd_setImageWithURL:[NSURL URLWithString:ShareModel.Icon] placeholderImage: Image(@"placeholder_icon")];
    
    _GoodNameLbl.text = [NSString stringWithFormat:@"我免费领取了%@",ShareModel.GoodName];
    
    _PriceLbl1.text = [NSString stringWithFormat:@"¥%@",ShareModel.Price];
    [_PriceLbl1 setAttributedText:[JGCommonTools getDeleteLineWithString:_PriceLbl1.text]];
}



#pragma mark - 弹出
//type 1 邀请 2 分享
-(void)showActionSheetWithType:(NSInteger)type ViewInView:(UIView *)view {
    
//    _ContentView.hidden = type == 2;
    
    if (type == 1) {
        self.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.7];
    }else {
        self.backgroundColor = [UIColor clearColor];
    }
    

    if (view.height == kDeviceHight) {
        
        self.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, kDeviceHight);
        _HelpFreeHight = kDeviceHight;
    }else {
        
        self.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, kDeviceHight - SJHeight);
        _HelpFreeHight = kDeviceHight - SJHeight;
    }
    
    [view addSubview:self];
    [self creatShowAnimation];
}

-(void)creatShowAnimation {
    self.transform = CGAffineTransformMakeTranslation(0, 0);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, - _HelpFreeHight);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 关闭按钮点击才回调
- (void)CloseBtnClick:(UITapGestureRecognizer *)tap {
    
    if (_ContentView.hidden) {
        if(CGRectContainsPoint(_ShareView.frame, [tap locationInView:self])) return;

    }else {
        if( CGRectContainsPoint(_ContentView.frame, [tap locationInView:self]) || CGRectContainsPoint(_ShareView.frame, [tap locationInView:self])) return;
    }
    
    
    self.layer.position = self.center;
    self.transform = CGAffineTransformMakeTranslation(0, - _HelpFreeHight);
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)dealloc {
    JGLog(@"ActionSheetView销毁了");
}



@end
