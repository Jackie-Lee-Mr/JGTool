//
//  QJGetPhotoPathTool.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/19.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJGetPhotoPathTool : NSObject

HMSingletonH(QJGetPhotoPathTool)


/**
 从相册或者图库选择 单张照片 上传服务器
 获取服务器图片路径
 
 @param way 1:图库 2:拍照
 @param type 1-商品,2-文件,3-身份证,4-新闻,5-头像,6-评价,7-售后,8-其他
 @param info 完成回调 返回路劲
 */
- (void)GetPhotoPathWithMethord:(NSInteger)way andType:(NSInteger)type andSize:(CGSize)PhotoSize complete:(ReturnBackInfo)info;

/**
 给定一张图片 获取服务器图片路径 (主要上传身份证正反面图片)
 
 @param image 给定一张图片
 @param type 1-商品,2-文件,3-身份证,4-新闻,5-头像,6-评价,7-售后,8-其他
 @param PhotoSize 图片尺寸
 @param info 完成回调 返回路劲
 */
- (void)GetPhotoPathWithImage:(UIImage *)image andType:(NSInteger)type toSize:(CGSize)PhotoSize complete:(ReturnBackInfo)info;



@end
