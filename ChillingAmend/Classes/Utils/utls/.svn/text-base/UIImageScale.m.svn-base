/********************************************************************
 文件名称 :  scaleToSize.m
 作   者	 :  
 创建时间 : 2011-1-13
 文件描述 : image缩放
 版权声明 : Copyright (C) 2010-2012 
 修改历史 : 2011-1-13      1.00    初始版本 
 调用    :  
 *********************************************************************/
#import "UIImageScale.h"
#import <UIKit/UIKit.h>

@implementation UIImage (scale) 
/******************************************************************************
 函数名称  : scaleToSize
 函数描述  : image缩放
 输入参数  :	目的尺寸
 输出参数  : N/A
 返回值	  : 缩放后的image
 备注	  :
 ******************************************************************************/
-(UIImage*)scaleToSize:(CGSize)size 
{ 
    // 创建一个bitmap的context 
    // 并把它设置成为当前正在使用的context 
    UIGraphicsBeginImageContext(size); 
    // 绘制改变大小的图片 
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)]; 
    // 从当前context中创建一个改变大小后的图片 
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext(); 
    // 使当前的context出堆栈 
    UIGraphicsEndImageContext(); 
    // 返回新的改变大小后的图片 
    return scaledImage; 
} 
@end