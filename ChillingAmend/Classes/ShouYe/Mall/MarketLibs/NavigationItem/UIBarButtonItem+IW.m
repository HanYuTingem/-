//
//  UIBarButtonItem+IW.m
//  01-ItcastWeibo
//
//  Created by apple on 14-1-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIBarButtonItem+IW.h"
#import "UIImage+MJ.h"
@implementation UIBarButtonItem (IW)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置按钮背景图片
    UIImage *normal = [UIImage imageWithName:image];
    [btn setBackgroundImage:normal forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:higlightedImage] forState:UIControlStateHighlighted];
    
    // 3.设置按钮的尺寸
    btn.bounds = CGRectMake(0, 0, normal.size.width/2, normal.size.height/2);
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString * )titleName target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置按钮背景图片
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    // 3.设置按钮的尺寸
    btn.bounds = CGRectMake(0, 0, 64, 64);
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
