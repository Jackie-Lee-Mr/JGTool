//
//  QJHttpModel.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJHttpModel.h"

@implementation QJHttpModel

- (instancetype)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        self.resultCode    = [[object valueForKey:@"code"] integerValue];
        self.resultMessage = [object valueForKey:@"msg"];
        self.data          = [object valueForKey:@"data"];
    }
    return self;
}


@end
