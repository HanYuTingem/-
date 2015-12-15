//
//  LoginPublicObject.m
//  LANSING
//
//  Created by nsstring on 15/6/4.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "LoginPublicObject.h"

static LoginPublicObject *publicInstance;

@implementation LoginPublicObject

+ (id) Instance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (publicInstance == nil)
        {
            publicInstance = [[LoginPublicObject alloc]init];
        }
    }
    return publicInstance;
}

+(id) allocWithZone:(NSZone *)zone{//重写allocWithZone用于确定：不能使用其他方法创建类的实例<br>
    @synchronized(self){
        if (publicInstance == nil) {
            publicInstance = [super allocWithZone:zone];
            return publicInstance;
        }
    }
    return nil;//如果写成这样 return [self getInstance] 当试图创建新的实例时候，会调用到单例的方法，达到共享类的实例
}


@end
