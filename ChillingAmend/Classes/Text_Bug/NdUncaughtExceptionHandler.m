//
//  NdUncaughtExceptionHandler.m
//  Text_Bug
//
//  Created by pipixia on 15/1/19.
//  Copyright (c) 2015年 pipixia. All rights reserved.
//

#import "NdUncaughtExceptionHandler.h"

#define THE_DEVELOPMENT_STATUS @"2"//1,为开发状态  2,为测试状态  3,为上线状态

NSString *applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
//错误信息
void UncaughtExceptionHandler(NSException *exception) {
    //堆栈信息
    NSArray *arr = [exception callStackSymbols];
    //异常摘要
    NSString *reason = [exception reason];
    //异常名..空指针之类
    NSString *name = [exception name];
    NSString *url = [NSString stringWithFormat:@"name:<br>%@<br>reason:<br>%@<br>callStackSymbols:<br>%@",
                     name,reason,[arr componentsJoinedByString:@"<br>"]];
//    NSString *BUGStr = [url stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
//    NSLog(@"xx = %@",BUGStr);
//    NSLog(@"%@",url);
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"BXBUG.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //除了可以选择写到应用下的某个文件，通过后续处理将信息发送到服务器等
    //还可以选择调用发送邮件的的程序，发送信息到指定的邮件地址
    //或者调用某个处理程序来处理这个信息
//    NSLog(@"%@",path);
  
}
static NdUncaughtExceptionHandler *instence;
@implementation NdUncaughtExceptionHandler

+(id) Instence
{
    if(!instence)
    {
        instence = [[NdUncaughtExceptionHandler alloc] init];
    }
    
    return instence;
}

-(NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}
- (void)sethttpBug
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //获取文件路劲
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"BXBUG.txt"];
    NSData* reader = [NSData dataWithContentsOfFile:path];
    NSLog(@"文件地址%@",path);
    NSLog(@"文件的data%@",reader);
    NSLog(@"文件信息%@",[[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding]);
    if ([THE_DEVELOPMENT_STATUS isEqualToString:@"2"]) {
        //判断文件下是否有东西
        if (![[[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding] isEqualToString:@""]) {
            NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
            //名字
            NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
            NSLog(@"名字%@",strAppName);
            //版本号
            NSString *strAppBuild = [dicInfo objectForKey:@"CFBundleShortVersionString"];
            NSLog(@"版本号%@",strAppBuild);
            
            ASIFormDataRequest *requestBUG = [self requestAppName:strAppName andSystem:@"IOS" andVersion:strAppBuild andLogInfo:[[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding]];
            requestBUG.timeOutSeconds=30;
            requestBUG.requestMethod=@"POST";
            //        [requestBUG addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
            [requestBUG setDelegate:self];
            [requestBUG setTimeOutSeconds:40];
            //        [requestBUG setDidFailSelector:@selector(requestFinished:)];
            //        [requestBUG setDidFinishSelector:@selector(xxx:)];
            [requestBUG startAsynchronous];
        }
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"====%@",request);
    NSData *data = [request responseData];
    NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"2222 = %@",aString);
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //获取文件路劲
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"BXBUG.txt"];
    NSData* reader = [NSData dataWithContentsOfFile:path];
    NSLog(@"%@",path);
    NSLog(@"%@",[[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding]);
    //删除路径
    [fileManager removeItemAtPath:path error:nil];
    
//    //获取文件路劲
//    NSString* path1 = [documentsDirectory stringByAppendingPathComponent:@"BXBUG.txt"];
//    NSData* reader1 = [NSData dataWithContentsOfFile:path1];
//    NSLog(@"%@",path1);
//    NSLog(@"%@",[[NSString alloc] initWithData:reader1 encoding:NSUTF8StringEncoding]);
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"====%@",request);
    
}
/*
 *appName   项目名
 *system    系统
 *version   版本
 *logInfo   错误信息
 */
- (ASIFormDataRequest *)requestAppName:(NSString *)AappName
                             andSystem:(NSString *)Asystem
                            andVersion:(NSString *)Aversion
                            andLogInfo:(NSString *)AlogInfo
{
    NSString *url = @"http://192.168.10.86:8080/logpanel/api/logs/save";
    //    NSString *properlyEscapedURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setPostValue: AappName forKey: @"appName"];
    [request setPostValue: Asystem forKey: @"system"];
    [request setPostValue: Aversion forKey: @"version"];
    [request setPostValue: AlogInfo forKey: @"logInfo"];
    return request;
}
@end
