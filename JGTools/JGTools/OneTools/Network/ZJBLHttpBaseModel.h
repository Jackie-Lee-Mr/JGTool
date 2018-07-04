//
//  ZJBLHttpBaseModel.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/17.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBLHttpBaseModel : NSObject


@property (assign, nonatomic) NSInteger resultCode;

@property (strong, nonatomic) NSString *resultMessage;

@property (strong, nonatomic) id data;

- (instancetype)initWithObject:(id)object;

@end
