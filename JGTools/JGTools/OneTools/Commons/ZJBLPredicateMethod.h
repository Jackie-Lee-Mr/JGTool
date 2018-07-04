//
//  ZJBLPredicateMethod.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/28.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBLPredicateMethod : NSObject

#pragma 正则匹配用户手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;

@end
