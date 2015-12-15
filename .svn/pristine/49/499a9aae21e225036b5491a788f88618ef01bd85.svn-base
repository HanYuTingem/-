//
//  UIImageScale.m
//  SINOCutOutPictureDemo
//
//  Created by like on 14-7-6.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "UIImageScale.h"
#import "JPCommonMacros.h"

@implementation UIImageScale

//按比例更改图片大小,短的那个边等于toSize对应的边的长度,长的那个变>=toSize对应的边的长度
+ (UIImage *)resizeImageToFitSize:(UIImage *)aImage
{
    CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 70);
    int imageWith = aImage.size.width;
    int imageHeight = aImage.size.height;
    if (imageWith>frame.size.width) {
        if (imageHeight>frame.size.height) {
            if (imageWith/frame.size.width > imageHeight/frame.size.height) {
                //width缩小到frame.size.width 算出比例得到高度
                imageHeight = imageHeight/(imageWith/frame.size.width);
                imageWith = frame.size.width;
            } else {
                //height 缩小到frame.size.height 算出比例得到宽度
                imageWith = imageWith/(imageHeight/frame.size.height);
                imageHeight = frame.size.height;
            }
        } else {
            //按照width缩小到frame.size.width 算出比例得到高度
            imageHeight = imageHeight/(imageWith/frame.size.width);
            imageWith = frame.size.width;
        }
    } else {
        if (imageHeight>frame.size.height) {
            //height 缩小到frame.size.height 算出比例得到宽度
            imageWith = imageWith/(imageHeight/frame.size.height);
            imageHeight = frame.size.height;
        }
    }
    //重绘uiimage
//    UIGraphicsBeginImageContext(CGSizeMake(imageWith, imageHeight));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWith, imageHeight), YES, 2.0);
    // 绘制改变大小的图片
    [aImage drawInRect:CGRectMake(0, 0, imageWith, imageHeight)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
