//
//  UIViewController+QJPopBlock.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "UIViewController+QJPopBlock.h"
#import <objc/runtime.h>

static char popBlockKey;

@implementation UIViewController (QJPopBlock)

-(void)setPopBlock:(PopBlock)popBlock{
    objc_setAssociatedObject(self, &popBlockKey, popBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(PopBlock)popBlock{
    
    PopBlock popBlock = objc_getAssociatedObject(self, &popBlockKey);
    
    return popBlock;
}
@end
