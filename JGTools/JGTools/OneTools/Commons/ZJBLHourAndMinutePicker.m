//
//  ZJBLHourAndMinutePicker.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/10.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLHourAndMinutePicker.h"

#define ZERO 0
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define TOP_HEIGHGT 30
#define BUTTON_WIDTH 30
#define BUTTON_HEIGHT 30

#define DATAPICKER_HEIGHT 300

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


@implementation ZJBLHourAndMinutePicker

+(instancetype)datePickerViewWithType:(UIDatePickerMode)type andDelegate:(id)delegate;
{
    ZJBLHourAndMinutePicker *picker = [[ZJBLHourAndMinutePicker alloc] initWithFrame:[UIScreen mainScreen].bounds type:type andDelegate:delegate];
    
    return picker;
}

- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type  andDelegate:(id)delegate;
{
    if (frame.size.width>frame.size.height)
    {
        float a = frame.size.height;
        frame.size.height = frame.size.width;
        frame.size.height = a;
    }
    self = [super initWithFrame:frame];
    if (self)
    {
        self.type = type;
        self.delegate = delegate;
        [self addSubview:self.bgView];
        [self addSubview:self.backgroundView];
        [self initializationDatePicker];
        [self initializationTopView];
        [self initializationCancleButton];
        [self initializationDetermineButton];
    }
    
    
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHight - 300, kDeviceWidth, 300)];
        
        self.bgView.backgroundColor = [UIColor grayColor];
    }
    return _bgView;
}

- (UIView *)backgroundView
{
    //    不能用self.backgroundView  不然会循环引用
    if (!_backgroundView)
    {
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        
        self.backgroundView.backgroundColor = [UIColor grayColor];
        self.backgroundView.alpha = 0.7;
    }
    return _backgroundView;
}

//初始化TopView
- (void)initializationTopView
{
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor blackColor];
    [self.backgroundView addSubview:self.topView];
    WS(weakSelf);
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backgroundView).with.offset(0);
        make.right.equalTo(weakSelf.backgroundView).with.offset(0);
        make.bottom.equalTo(_datePicker.mas_top).with.offset(0);
        make.height.mas_equalTo(@TOP_HEIGHGT);
    }];
    
    
}



//初始化datePicker
- (void)initializationDatePicker
{
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = self.type;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.minimumDate = [NSDate date];
    [self.datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [self.backgroundView addSubview:self.datePicker];
    WS(weakSelf);
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backgroundView).with.offset(ZERO);
        make.right.equalTo(weakSelf.backgroundView).with.offset(ZERO);
        make.bottom.equalTo(weakSelf.backgroundView).with.offset(ZERO);
        make.height.mas_equalTo(@DATAPICKER_HEIGHT);
    }];
    
}

//初始化button
- (void)initializationCancleButton
{
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleButton setBackgroundImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
    [self.topView addSubview:self.cancleButton];
    WS(weakSelf);
    [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.topView).with.offset(10);
        make.top.equalTo(weakSelf.topView).with.offset(ZERO);
        make.bottom.equalTo(weakSelf.topView).with.offset(ZERO);
        make.width.mas_equalTo(@BUTTON_WIDTH);
        
    }];
}
- (void)initializationDetermineButton
{
    self.determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.determineButton addTarget:self action:@selector(determineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.determineButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [self.topView addSubview:self.determineButton];
    
    [_determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView).with.offset(-10);
        make.top.equalTo(_topView).with.offset(ZERO);
        make.bottom.equalTo(_topView).with.offset(ZERO);
        make.width.mas_equalTo(@BUTTON_WIDTH);
        
    }];
}

- (void)show
{
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationCurve:2];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //    [UIView commitAnimations];
}

- (void)end
{
    [self removeFromSuperview];
}

#pragma mark - DatePicker Method
- (void)datePickerChange:(UIDatePicker *)datePicker
{
    //    判断delegate 指向的类是否实现协议方法
    if ([self.delegate respondsToSelector:@selector(changeTime:)])
    {
        [_delegate changeTime:datePicker.date];
    }
    
}



#pragma mark - buttonMethod

- (void)cancleButtonClick:(UIButton *)sender
{
    [self removeFromSuperview];
}

- (void)determineButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(determinSelected:)])
    {
        [_delegate determinSelected:self.datePicker.date];
    }
    [self end];
}


- (NSDate*)dateFromString:(NSString*)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (self.type) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

- (NSString*)stringFromDate:(NSDate*)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (self.type) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

@end
