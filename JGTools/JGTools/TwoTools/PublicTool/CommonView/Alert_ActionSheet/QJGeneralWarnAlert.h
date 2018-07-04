//
//  QJGeneralWarnAlert.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJGeneralWarnAlert : UIView

@property(nonatomic,copy) ReturnBackInfo backInfo;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

-(void)showAlertView;


@end
