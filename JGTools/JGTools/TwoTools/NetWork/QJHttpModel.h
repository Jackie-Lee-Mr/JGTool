//
//  QJHttpModel.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJHttpModel : NSObject

@property (assign, nonatomic) NSInteger resultCode;

@property (strong, nonatomic) NSString *resultMessage;

@property (strong, nonatomic) id data;

- (instancetype)initWithObject:(id)object;

@end
