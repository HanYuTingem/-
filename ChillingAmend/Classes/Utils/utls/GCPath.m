//
//  GCPath.m
//  iMagazine2
//
//  Created by dreamRen on 12-11-16.
//  Copyright (c) 2012年 iHope. All rights reserved.
//

#import "GCPath.h"

@implementation GCPath

+(NSString*)getSysDocPath{
	NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	return docPath;
}

//创建一个文件夹
+(void)createFolder:(NSString*)aFolderPath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:aFolderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:aFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

//documents下的temp文件夹
+(NSString*)getTempPath{
	return [NSString stringWithFormat:@"%@/temp",[GCPath getSysDocPath]];
}

+(NSString*)getDownloadFolderPath{
    return [NSString stringWithFormat:@"%@/download",[GCPath getSysDocPath]];
}

+(NSString*)getDownloadTempFolderPath{
    return [NSString stringWithFormat:@"%@/downloadtemp",[GCPath getSysDocPath]];
}

//初始化目录
+(void)resetAllPath{
    [GCPath createFolder:[GCPath getTempPath]];
    [GCPath createFolder:[GCPath getDownloadTempFolderPath]];
    [GCPath createFolder:[GCPath getDownloadFolderPath]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[GCPath getHistoryFilePath]]) {
        NSMutableArray *tList=[NSMutableArray array];
        [tList writeToFile:[GCPath getHistoryFilePath] atomically:YES];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:[GCPath getDownloadFilePath]]) {
        NSMutableArray *tList=[NSMutableArray array];
        [tList writeToFile:[GCPath getDownloadFilePath] atomically:YES];
    }
}

+(NSString*)getHistoryFilePath{
    return [NSString stringWithFormat:@"%@/guankan.plist",[GCPath getSysDocPath]];
}

+(NSString*)getUserFilePath{
    return [NSString stringWithFormat:@"%@/userinfo.plist",[GCPath getSysDocPath]];
}

+(NSString*)getDownloadFilePath{
    return [NSString stringWithFormat:@"%@/download.plist",[GCPath getSysDocPath]];
}
+(NSString*)getautoUpdatePath{
    return [NSString stringWithFormat:@"%@/autoUpdate.plist",[GCPath getSysDocPath]];
}
@end
