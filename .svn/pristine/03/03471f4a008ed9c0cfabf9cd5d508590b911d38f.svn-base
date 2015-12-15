//
//  ITTPictureDealWithObject.h
//  ITTDownloadImage
//
//  Created by nsstring on 14-5-16.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ITTPictureDealWithObject : NSObject

//将图片压缩成Base64字符串
+(NSString *)imageEncodedAsBase64StringWithOriginalImage:(UIImage *) originalImage;

//将Base64字符串转换为image
+(UIImage*)originalImageWithEncodedBase64String:(NSString*)encodeBase64String;

//压缩图片尺寸
+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)size;

//拉伸图片
+(UIImage *)resizeImageWithImage:(UIImage*)resizeImage;

//保存图片
+(NSString*)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

+(NSString*)cutImageChangedformatWithImage:(UIImage*)image;
@end
