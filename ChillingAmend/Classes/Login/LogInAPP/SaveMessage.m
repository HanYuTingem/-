//
//  SaveMessage.m
//  LANSING
//
//  Created by nsstring on 15/6/17.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "SaveMessage.h"

@implementation SaveMessage
+ (void)saveUserMessagePHP:(NSDictionary *)userMsg
{
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    
    [userData setObject:userMsg
                                              forKey:usernameMessagePHP];
//    [[NSUserDefaults standardUserDefaults] setValue:archiveDic forKey:usernameMessage];
    [userData synchronize];
    
    NSLog(@"_-------%@-----",[[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP]);
}

+ (void)saveUserMessageJava:(NSDictionary *)userMsg
{
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    
    [userData setObject:userMsg
                 forKey:usernameMessageJava];
    //    [[NSUserDefaults standardUserDefaults] setValue:archiveDic forKey:usernameMessage];
    [userData synchronize];
    
    NSLog(@"_-------%@-----",[[NSUserDefaults standardUserDefaults]objectForKey:usernameMessageJava]);
}

+(void)clearPHP
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:usernameMessagePHP];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)publicLoadDataWithNoLoginGetMoney{
    
    //未登录饺子存储的饺子
    NSMutableArray *dumplingInforNoLogingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
    NSMutableArray *dumplingIdArray = [NSMutableArray array];//未登录没有领取的饺子钱
    for (NSDictionary *subDic in dumplingInforNoLogingArray) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        [dumplingIdArray addObject:model.resultListModel.dumplingModel.prizeId];
    }
    
    if(dumplingIdArray.count == 0){
        
    }else{
        NSString *dumplingStr =  [dumplingIdArray componentsJoinedByString:@","];
        [LYLAFNetWorking getWithBaseURL:[LYLHttpTool noLogingGetMoneyWithProductCode:ProductCode sysType:SysType sessionValue:SessionValue phone:kkUserName  prizeidList:dumplingStr andUserId:kkUserCenterId] success:^(id json) {
            ZHLog(@"%@",json);
            
            switch ([[json objectForKey:@"code"] intValue]) {
                case 100://领取成功
                {
                    NSMutableArray *logingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
                    if(!logingArray){
                        logingArray = [NSMutableArray array];
                    }
                    [logingArray addObjectsFromArray:dumplingInforNoLogingArray];
                    ZHLog(@"已登陆数组%@",logingArray);
                    //将未登录的饺子存为已登陆的
                    if([logingArray writeToFile:DumplingInforLogingPath atomically:YES]){
                        ZHLog(@"写入已登陆成功");
                    }else{
                        ZHLog(@"写入已登陆失败");
                    }
                    
                    /**
                     *  更给储存未登陆的饺子信息
                     */
                    [dumplingInforNoLogingArray removeAllObjects];
                    ZHLog(@"未登陆数组%@",dumplingInforNoLogingArray);
                    if([dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES]){
                        ZHLog(@"写入未登陆成功");
                    }else{
                        ZHLog(@"写入未登陆失败");
                    }
                }
                    break;
                case 101:
                {
                    [LYLTools showInfoAlert:@"系统错误"];
                }
                    break;
                case 102:
                {
                    [LYLTools showInfoAlert:@"领取失败，可以换个手机号领取"];
                    
                }
                    break;
                case 103:
                {
                    
                    [LYLTools showInfoAlert:@"登陆失败"];
                }
                    break;
                case 104:
                {
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    
                    
                    [LYLTools showInfoAlert:@"饺子已过期"];
                }
                    break;
                case 105:{
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    
                    
                    [LYLTools showInfoAlert:@"饺子已被领取"];
                    
                }
                    break;
                    
                case 106:
                {
                    //                [Tools showInfoAlert:@"参数不正确"];
                }
                    break;
                case 107:
                case 108:
                case 109:{
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    [LYLTools showInfoAlert:@"饺子信息无效"];
                }
                    break;
                    
                default:
                    break;
            }
            [[NoGetMoneyView shareGetMoneyView] refreshShareGetMoneyView];//刷新捞一捞界面未领取金额的数据
            
        } failure:^(NSError *error) {
            ZHLog(@"%@",error);
            
            
        }];
    }
}

+ (NSString *)getAuthUserId {
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userData valueForKey:usernameMessageJava];
    return dict[@"auth"];
}


+(void)clearJava
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:usernameMessageJava];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
