/********************************************************************
 文件名称 :  scaleToSize.h
 作   者	 :  
 创建时间 : 2011-1-13
 文件描述 : image缩放
 版权声明 : Copyright (C) 2010-2012 
 修改历史 : 2011-1-13      1.00    初始版本 
 调用    :  
 *********************************************************************/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage (scale) 
-(UIImage*)scaleToSize:(CGSize)size; 
@end