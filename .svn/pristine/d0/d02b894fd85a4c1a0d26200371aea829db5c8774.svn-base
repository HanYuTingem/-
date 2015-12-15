//
//  ITTPictureDealWithObject.m
//  ITTDownloadImage
//
//  Created by nsstring on 14-5-16.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ITTPictureDealWithObject.h"

@implementation ITTPictureDealWithObject

//将图片压缩成Base64字符串
+(NSString *)imageEncodedAsBase64StringWithOriginalImage:(UIImage *) originalImage
{
    NSData * originalImageData = UIImageJPEGRepresentation(originalImage, 1.0);
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version < 7.0) {
        
        NSString * encodedImageStr = [originalImageData base64EncodedStringWithOptions:0];
        
        return encodedImageStr;
    }else
    {
        NSData * encodedData = [originalImageData base64EncodedDataWithOptions:0];
        NSString * encodedImageStr = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
        
        return encodedImageStr;
    }
}

//将Base64字符串转换为image
+(UIImage*)originalImageWithEncodedBase64String:(NSString*)encodeBase64String
{
    NSData *  _decodedImageData = [[NSData alloc]initWithBase64EncodedString:   encodeBase64String options:0];
    UIImage * _decodedImage = [UIImage imageWithData:_decodedImageData];
    
    return _decodedImage;
}

+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
//拉伸图片
+(UIImage *)resizeImageWithImage:(UIImage*)resizeImage
{
    float systemVersion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    UIImage * image = nil;
    UIEdgeInsets inserts = UIEdgeInsetsMake(0, 0, 0, 0);

    if(systemVersion>=5.0){
        image = [resizeImage resizableImageWithCapInsets:inserts];
        return image;
    }
    image = [resizeImage stretchableImageWithLeftCapWidth:inserts.left topCapHeight:inserts.top];
    
    return image;
}

//保存图片到本地
+(NSString*)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName

{
    NSData* imageData;
    //判断图片格式
    if(UIImagePNGRepresentation(tempImage)){
        imageData = UIImagePNGRepresentation(tempImage);
        
    } else {
        imageData = UIImageJPEGRepresentation(tempImage, 1.0);
    }
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    NSArray *nameAry=[fullPathToFile componentsSeparatedByString:@"/"];
    NSLog(@"===fullPathToFile===%@",fullPathToFile);
    NSLog(@"===FileName===%@",[nameAry objectAtIndex:[nameAry count]-1]);

    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
    
}
+(NSString*)cutImageChangedformatWithImage:(UIImage*)image
{
   // CGSize imagesize = image.size;
    NSData *imageData;
    if(UIImagePNGRepresentation(image)==nil){
        imageData = UIImageJPEGRepresentation(image,0.00001);
    } else {
        imageData = UIImagePNGRepresentation(image);
    }
    UIImage * imageNew = [UIImage imageWithData:imageData];
    NSString * imageStr = [self imageEncodedAsBase64StringWithOriginalImage:imageNew];

    return imageStr;
}

@end
