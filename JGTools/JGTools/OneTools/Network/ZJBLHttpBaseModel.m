//
//  ZJBLHttpBaseModel.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/17.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLHttpBaseModel.h"

@implementation ZJBLHttpBaseModel

- (instancetype)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        self.resultCode    = [[object valueForKey:@"resultCode"] integerValue];
        self.resultMessage = [object valueForKey:@"resultMessage"];
        self.data          = [object valueForKey:@"data"];
    }
    return self;
}


@end
