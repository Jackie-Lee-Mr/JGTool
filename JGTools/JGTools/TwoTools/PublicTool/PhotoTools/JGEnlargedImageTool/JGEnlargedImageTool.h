//
//  JGEnlargedImageTool.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGEnlargedImageTool : NSObject

/**
 @param oldImageview 原图片
 @param uesTime 放大缩小时间
 */
+ (void)enlargedImage:(UIImageView*)oldImageview enlargedTime:(CGFloat)uesTime;

@end
