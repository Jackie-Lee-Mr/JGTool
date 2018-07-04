//
//  QJDatePickerView.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/13.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>


//@class QJDatePickerView;

//@protocol QJDatePickerViewDelegate <NSObject>
//
//@optional
///**
// 返回选择的时间字符串
//
// @param pickerView pickerView
// @param dateString 时间字符串
// */
//- (void)pickerView:(QJDatePickerView *)pickerView didSelectDateString:(NSString *)dateString;
//
//@end


@interface QJDatePickerView : UIView


//@property (nonatomic, weak) id<QJDatePickerViewDelegate> delegate;
@property (nonatomic, copy) ReturnBackInfo backInfo;

/**
 初始化QJDatePickerView
 
 @param date 默认时间
 @param mode 时间显示格式
 @return QJDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode;

/**
 移除PickerView
 */
- (void)remove;

/**
 显示PickerView
 */
- (void)show;

@end
