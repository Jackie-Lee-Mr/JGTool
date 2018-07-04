//
//  JGEnlargedImageTool.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "JGEnlargedImageTool.h"

#define MaxSCale 2.0  //最大缩放比例
#define MinScale 0.7  //最小缩放比例

static CGRect oldRect;
static id tempImageView;
static CGFloat enlargedTime;
static CGFloat totalScale;
static CGPoint originalCenter;


@implementation JGEnlargedImageTool

+ (void)enlargedImage:(UIImageView*)oldImageview enlargedTime:(CGFloat)uesTime{
    
    oldImageview.alpha = 0;
    enlargedTime = uesTime;
    tempImageView = oldImageview;
    
    totalScale = 1.0;
    
    UIImage *image = oldImageview.image;
    CGRect rect = [UIScreen mainScreen].bounds;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    oldRect= [oldImageview convertRect:oldImageview.bounds toView:window];
    
    UIView *backView = [[UIView alloc]initWithFrame:window.bounds];
    backView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1.0];
    backView.alpha=1;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldRect];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    imageView.tag = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [backView addSubview:imageView];
    
    [window addSubview:backView];
    
    //捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImg:)];
    [imageView addGestureRecognizer:pinch];
    
    //拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPanned:)];
    [imageView addGestureRecognizer:pan];
    
    
    float scaleHeight = rect.size.width/oldImageview.image.size.width * oldImageview.image.size.height;
    
    [UIView animateWithDuration:enlargedTime animations:^(){
        imageView.frame = CGRectMake(0, (rect.size.height - scaleHeight)/2 ,rect.size.width,scaleHeight);
        backView.alpha = 1;
    } completion:^(BOOL flished){
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
        [backView addGestureRecognizer: tap];
    }];
}


+ (void)pinchImg:(UIPinchGestureRecognizer *)recognizer{
    
    UIImageView *imageView= (UIImageView *)recognizer.view;
    
    CGFloat scale = recognizer.scale;
    
    //放大情况
    if(scale > 1.0){
        if(totalScale > MaxSCale) return;
    }
    
    //缩小情况
    if (scale < 1.0) {
        if (totalScale < MinScale) return;
    }
    
    imageView.transform = CGAffineTransformScale(imageView.transform, scale, scale);
    totalScale *=scale;
    
    recognizer.scale = 1.0;
}

+ (void)imageViewPanned:(UIPanGestureRecognizer *)pan{
    
    if (totalScale == 1.0) return;
    
    UIImageView *imageView= (UIImageView *)pan.view;
    
    //先记录一下起始位置
    if (pan.state == UIGestureRecognizerStateBegan) {
        originalCenter = imageView.center;
    }
    
    CGPoint transPoint = [pan translationInView:imageView];
    //    NSLog(@"%@", NSStringFromCGPoint(transPoint));
    
    CGPoint center = originalCenter;
    center.x += transPoint.x;
    center.y += transPoint.y;
    
    imageView.center = center;
    
    //    CGPoint velocityPoint = [pan velocityInView:imageView];
    //    NSLog(@"%@", NSStringFromCGPoint(velocityPoint));
}



+ (void)hideImage:(UITapGestureRecognizer*)sender{
    UIView *backgroundView=sender.view;
    backgroundView.userInteractionEnabled = NO;
    UIImageView *imageView=(UIImageView*)[backgroundView viewWithTag:1];
    UIImageView *oldImage = tempImageView;
    
    [UIView animateWithDuration:enlargedTime animations:^(){
        imageView.frame = oldRect;
    } completion:^(BOOL finished){
        [backgroundView removeGestureRecognizer:backgroundView.gestureRecognizers[0]];
        oldImage.alpha = 1;
        [backgroundView removeFromSuperview];
    }];
}



@end
