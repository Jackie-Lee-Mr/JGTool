//
//  QJDatePickerView.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/13.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJDatePickerView.h"


@interface QJDatePickerView ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolBar;

// 保存PickView的Y值
@property (nonatomic, assign) CGFloat toolViewY;

@end

static float ToolbarH  = 44;

@implementation QJDatePickerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 初始化QJDatePickerView
 
 @param date 默认时间
 @param mode 时间显示格式
 @return QJDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode
{
    self = [super init];
    
    if (self)
    {
        [self addSubview:self.toolBar];
        [self addSubview:self.datePicker];
        self.datePicker.datePickerMode = mode;
        if (date) [self.datePicker setDate:date];
        
        [self setUpFrame];
    }
    return self;
}

/**
 设置Frame
 */
- (void)setUpFrame
{
    // self 高度
    CGFloat ViewH = self.datePicker.frame.size.height + ToolbarH;
    // 默认self Y值
    self.toolViewY = kDeviceHight - ViewH;
    // 默认设置self的Y值在屏幕下方
    self.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, ViewH);
}

/**
 确定
 */
- (void)doneClick
{
    NSDate *select = self.datePicker.date;
    NSDateFormatter *dateFormmater = [[NSDateFormatter alloc]init];
    [dateFormmater setDateFormat:@"yyyy-MM-dd"];
    NSString *resultString = [dateFormmater stringFromDate:select];
    
    if (self.backInfo) {
        self.backInfo(resultString);
    }
    
    [self remove];
}

/**
 显示PickerView
 */
- (void)show
{
    UIView *screenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHight)];
    screenView.tag     = 1001;
    screenView.backgroundColor = [UIColor colorWithRed:0/255.0
                                                 green:0/255.0
                                                  blue:0/255.0
                                                 alpha:0.3];
    
    [screenView addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview:screenView];
    
    [UIView animateWithDuration:0.35 animations:^
     {
         screenView.alpha = 1.0;
         self.frame = CGRectMake(0, self.toolViewY, kDeviceWidth, self.datePicker.frame.size.height + ToolbarH);
         
     } completion:^(BOOL finished)
     {
         
     }];
}

/**
 移除PickerView
 */
- (void)remove
{
    [UIView animateWithDuration:0.35 animations:^
     {
         self.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, self.datePicker.frame.size.height + ToolbarH);
         
     } completion:^(BOOL finished)
     {
         for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews])
         {
             if (view.tag == 1001)
             {
                 [view removeFromSuperview];
             }
         }
     }];
    
}

#pragma mark -- 懒加载

/**
 DatePicker
 */
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker   = [[UIDatePicker alloc] init];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        // UIDatePicker默认高度216
        _datePicker.frame = CGRectMake(0, ToolbarH , kDeviceWidth, _datePicker.frame.size.height);
    }
    return _datePicker;
}

/**
 工具栏
 */
- (UIToolbar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, ToolbarH)];
        _toolBar.barStyle = UIBarStyleBlackTranslucent;
        // 设置UIToolbar背景色
        _toolBar.barTintColor = [UIColor colorWithRed:239.0/255.0
                                                green:239.0/255.0
                                                 blue:244.0/255.0
                                                alpha:1.0];
        // 取消按钮
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"   取消"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(remove)];
        
        [leftItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                forState:UIControlStateNormal];
        [leftItem setTintColor:[UIColor grayColor]];
        
        UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        // 确定按钮
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定   "
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(doneClick)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                 forState:UIControlStateNormal];
        // 设置字体颜色
        //[rightItem setTintColor:[UIColor colorWithRed:67.0/255.0 green:199.0/255.0 blue:203.0/255.0 alpha:1.0]];
        
        _toolBar.items = @[leftItem,centerSpace,rightItem];
    }
    return _toolBar;
}


@end
