//
//  JGBannarView.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/10/13.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface JGBannarView : UIView

- (id)initWithFrame:(CGRect)frame viewSize:(CGSize)viewSize;

@property (strong, nonatomic) NSArray *items;


@property (copy, nonatomic) void(^imageViewClick)(JGBannarView *barnerview,NSInteger index);
//点击图片
- (void)imageViewClick:(void(^)(JGBannarView *barnerview,NSInteger index))block;



NS_ASSUME_NONNULL_END
@end
