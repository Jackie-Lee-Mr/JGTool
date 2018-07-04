//
//  JGBannerCollectionViewCell.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/10/13.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "JGBannerCollectionViewCell.h"

@implementation JGBannerCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        /*
         *  图片的添加
         */
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.frame.size.height)];
        //    _imageView.contentMode = UIViewContentModeScaleAspectFill;
        //    _imageView.layer.cornerRadius = 4;
        //    _imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_imageView];

    }
    
    return self;
    
}



@end
