//
//  UITapGestureRecognizer+KTapGesture.m
//  jiamengwang
//
//  Created by like on 14-2-27.
//  Copyright (c) 2014年 purplepeng. All rights reserved.
//

#import "UITapGestureRecognizer+KTapGesture.h"
#import <objc/runtime.h>

@implementation UITapGestureRecognizer (KTapGesture)
@dynamic tag;
- (void)setTag:(NSString *)tag
{
    objc_setAssociatedObject(self, @"kTag", tag, OBJC_ASSOCIATION_RETAIN);
}
- (NSString *)tag
{
    return objc_getAssociatedObject(self,@"kTag");
}
@end
