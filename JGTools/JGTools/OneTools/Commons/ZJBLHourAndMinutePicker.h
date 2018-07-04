//
//  ZJBLHourAndMinutePicker.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/10.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJBLHourAndMinutePickerDelegate <NSObject>

//改变了
- (void)changeTime:(NSDate *)date;
//确定选择
- (void)determinSelected:(NSDate *)date;

@end

@interface ZJBLHourAndMinutePicker : UIView

@property (nonatomic,assign)id<ZJBLHourAndMinutePickerDelegate> delegate;


@property (nonatomic,assign)UIDatePickerMode  type;

@property (nonatomic,strong)UIView            *bgView;
@property (nonatomic,strong)UIView            *backgroundView;
@property (nonatomic,strong)UIView            *topView;
@property (nonatomic,strong)UIDatePicker      *datePicker;

@property (nonatomic,strong)UIButton          *cancleButton;

@property (nonatomic,strong)UIButton          *determineButton;


//类方法创建
+(instancetype)datePickerViewWithType:(UIDatePickerMode)type andDelegate:(id)delegate;;
//实例方法创建
- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type  andDelegate:(id)delegate;

- (void)show;

// NSDate <-- NSString
- (NSDate*)dateFromString:(NSString*)dateString;
// NSDate --> NSString
- (NSString*)stringFromDate:(NSDate*)date;


@end
