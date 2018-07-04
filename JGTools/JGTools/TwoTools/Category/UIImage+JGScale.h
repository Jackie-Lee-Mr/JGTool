//
//  UIImage+JGScale.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/22.
//  Copyright © 2017年 ZJNY. All rights reserved.
//  裁剪图片和等比列缩放图片

#import <UIKit/UIKit.h>

@interface UIImage (JGScale)

-(UIImage*)getSubImage:(CGRect)rect;

-(UIImage*)scaleToSize:(CGSize)size;

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
