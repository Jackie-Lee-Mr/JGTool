//
//  QJGeneralShareModel.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJGeneralShareModel : NSObject

//商品图片
@property (nonatomic, copy) NSString *Icon;
//用户图像
@property (nonatomic, copy) NSString *UserIcon;
//用户昵称
@property (nonatomic, copy) NSString *UserName;
//商品名称
@property (nonatomic, copy) NSString *GoodName;
//描述
@property (nonatomic, copy) NSString *Desc;
//商品价格
@property (nonatomic, copy) NSString *Price;
//二维码
@property (nonatomic, copy) NSString *CodeStr;


/***********************  辅助字段  *******************************/
//分享方式 Index_Share 1 微信朋友圈 2 微信好友 3 qq好友 4 qq空间
@property (nonatomic, assign) NSInteger Index_Share;
//截屏图片
@property (nonatomic, strong) UIImage *snapImage;

@end
