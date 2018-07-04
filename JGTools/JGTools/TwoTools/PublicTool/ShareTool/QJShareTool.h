//
//  QJShareTool.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/18.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>

@interface QJShareTool : NSObject

/**
 *  获取单例
 */
+ (instancetype)sharedTool;



/**
  分享图片

 @param platformType 分享的平台
 @param thumb 缩略图（UIImage或者NSData类型，或者image_url）
 @param image 要分享的图片
 */
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType withThumb:(id)thumb image:(id)image;



/**
 分享网页

 @param platformType 分享的平台
 @param title 分享标题
 @param descr 描述
 @param url 分享的链接
 @param thumb 缩略图（UIImage或者NSData类型，或者image_url）
 */
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title descr:(NSString *)descr url:(NSString *)url thumb:(id)thumb;


@end
