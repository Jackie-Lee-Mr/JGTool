//
//  QJGeneralShareActionSheet.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJGeneralShareModel.h"

@interface QJGeneralShareActionSheet : UIView

@property (nonatomic, strong) QJGeneralShareModel *ShareModel;

@property (nonatomic, copy) ReturnBackInfo backInfo;

//type 1 邀请 2 分享
-(void)showActionSheetWithType:(NSInteger)type ViewInView:(UIView *)view;





@end
