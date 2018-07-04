//
//  QJPassWordView.h
//  LH_QJ
//
//  Created by 郭军 on 2018/6/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSUInteger {
    passShow1 = 1,//黑点,框,没间隔
    passShow2,//显示数字,框,没间隔
    passShow3,//黑点,框,有间隔
    passShow4,//显示数字,框,有间隔
    passShow5,//显示数字,下划线,一般用做验证码
} passShowType;


typedef void(^textBlock) (NSString *str);


@interface QJPassWordView : UIView

@property(nonatomic,strong)UITextField *textF;
@property(nonatomic,strong)UIColor *tintColor;//主题色
@property(nonatomic,strong)UIColor *textColor;//字体颜色
@property(nonatomic, copy)textBlock textBlock;
@property(nonatomic,assign)passShowType showType;
@property(nonatomic,assign)NSInteger num;//格子数
-(void)show;
-(void)cleanPassword;


@end




/*
 //使用方法========================================
 self.passView = [[QJPassWordView alloc] init];
 self.passView.frame = CGRectMake(16, 100, 200, 200/6);
 
 self.passView.textBlock = ^(NSString *str) {//返回的内容
 NSLog(@"%@",str);
 };
 [self.view addSubview:_passView];
 self.passView.showType = 5;//五种样式
 self.passView.num = 6;//框框个数
 self.passView.tintColor = [UIColor orangeColor];//主题色
 [self.passView show];
 
 */



