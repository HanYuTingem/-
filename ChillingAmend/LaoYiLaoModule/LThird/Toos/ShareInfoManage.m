//
//  ShareInfoManage.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/16.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "ShareInfoManage.h"

@implementation ShareInfoManage

//+ (void)shareJiaoziInfoWithButton:(UIButton *)btn andController:(LaoYiLaoBaseViewController *)controller{
//    
//    if(btn.selected) return;
//    btn.selected=YES;
//    /**
//     *     获取已捞到的饺子的信息  登陆状态
//     */
//    NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
//    if(!dumplingInforArray){
//        dumplingInforArray = [NSMutableArray array];
//    }
//    /**
//     *  饺子失效说明   新的一天开始
//     */
//    if([MyObjectForKey(DumplingNoLogingTimeKey) intValue] != [[LYLTools currentDateWithDay]intValue]){
//        [dumplingInforArray removeAllObjects];//饺子失效 清除缓存
//    }
//    
//    if(dumplingInforArray.count == 0 || !dumplingInforArray){
//        [LYLTools showInfoAlert:@"没有可分享饺子"];
//    }else{
//        NSMutableArray * moneyDumArr = [NSMutableArray array];
//        CGFloat totalMoney = 0.00;
//        for (NSDictionary *subDic in dumplingInforArray) {
//            DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
//            if([model.resultListModel.dumplingModel.dumplingType isEqualToString:DumplingTypeMoney]){
//                totalMoney = totalMoney +  [model.resultListModel.dumplingModel.prizeAmount floatValue];
//                [moneyDumArr addObject:subDic];
//            }
//        }
//        [LYLTools showloadingProgressView];
//        DumplingInforModel * dumpInfoModel = [DumplingInforModel dumplingInforModelWithDic:[moneyDumArr lastObject]];
//        NSString * starName = dumpInfoModel.resultListModel.starName;
//        NSString * starIcon = dumpInfoModel.resultListModel.starIcon;
//        
//        NSError *error ;
//        NSDictionary * shareInfoDic = @{@"@starName":starName,@"@prizeMoney":[NSString stringWithFormat:@"%.2f",totalMoney]};
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shareInfoDic options:NSJSONWritingPrettyPrinted error:&error];
//        NSString *parameter_des =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//        NSString * url = [LYLHttpTool getShareInfoWithTempid:@"10002" andProduct:@"" andShareplat:@"all" andPicurl:starIcon andParameterdes:parameter_des];
//        [LYLAFNetWorking postWithBaseURL:url success:^(id json) {
//            if ([[json objectForKey:@"code"]intValue] == 100) {
//                //成功
//                NSDictionary * resultListDict = [(NSDictionary *)json objectForKey:@"resultList"];
//                NSString * content = [resultListDict objectForKey:@"content"];
//                NSString * jsonUrl = [resultListDict objectForKey:@"url"];
//                if ([jsonUrl rangeOfString:@"http://"].location != NSNotFound) {
//                    
//                }else{
//                    jsonUrl = [@"http://" stringByAppendingString:jsonUrl];
//                }
//                
//                NSString * picUrl = [resultListDict objectForKey:@"picurl"];
//                NSString * title = [resultListDict objectForKey:@"title"]; //饺子捞起来~我包！众明星携手为你包饺子，捞一捞，2亿现金等你拿！~;//待产品确定分享内容
//                NSString * proUrl = [NSString stringWithFormat:@"%@?productCode=%@",jsonUrl,ProductCode];
//                NSString * newTitle = [NSString stringWithFormat:@"%@ %@",content,proUrl];
//                [LYLTools hideloadingProgressView];
//                [controller baseShareText:content withUrl:proUrl withContent:content withImageName:url ImgStr:picUrl domainName:@"" withqqTitle:title withqqZTitle:title withweCTitle:title withweChtTitle:title withsinaTitle:newTitle];
//            }
//        } failure:^(NSError *error) {
//            [LYLTools hideloadingProgressView];
//            [LYLTools showInfoAlert:@"网络状态不佳"];
//        }];
//    }
//    
//    btn.selected = NO;
//}
//
//
//+ (void) shareActivityWithButton:(UIButton *)btn andController:(LaoYiLaoBaseViewController *)controller{
//    if(btn.selected) return;
//    btn.selected=YES;
//    NSString * requestUrl = [LYLHttpTool getShareInfoWithTempid:@"10001" andProduct:@"" andShareplat:@"all" andPicurl:@"" andParameterdes:@""];
//    [LYLTools showloadingProgressView];
//    [LYLAFNetWorking postWithBaseURL:requestUrl success:^(id json) {
//        if ([[json objectForKey:@"code"]intValue] == 100) {
//            //成功
//            NSDictionary * resultListDict = [(NSDictionary *)json objectForKey:@"resultList"];
//            NSString * content = [resultListDict objectForKey:@"content"];
//            NSString * jsonUrl = [resultListDict objectForKey:@"url"];
//            NSLog(@"%@",jsonUrl);
//            if ([jsonUrl rangeOfString:@"http://"].location == NSNotFound) {
//                jsonUrl = [@"http://" stringByAppendingString:jsonUrl];
//            }else{
//                
//            }
//            NSString * picUrl = [resultListDict objectForKey:@"picurl"];
//            NSString * title = [resultListDict objectForKey:@"title"];
//            NSString * proUrl = [NSString stringWithFormat:@"%@?productCode=%@",jsonUrl,ProductCode];
//            NSString * newTitle = [NSString stringWithFormat:@"%@ %@",content,proUrl];
//            [LYLTools hideloadingProgressView];
//            
//            [controller baseShareText:content withUrl:proUrl withContent:content withImageName:picUrl ImgStr:picUrl domainName:@"" withqqTitle:title withqqZTitle:title withweCTitle:title withweChtTitle:title withsinaTitle:newTitle];
//        }
//    } failure:^(NSError *error) {
//        [LYLTools hideloadingProgressView];
//        [LYLTools showInfoAlert:@"网络状态不佳"];
//    }];
//    btn.selected = NO;
//}
//
////炫耀分享
//+ (void)shareJiaoziInfoWithButton:(UIButton *)btn andController:(LaoYiLaoBaseViewController *)controller andAllMoney:(NSString * )allMoney{
//    
//    if(btn.selected) return;
//    btn.selected=YES;
//    
//    NSError *error ;
//    NSDictionary * shareInfoDic = @{@"@allMoney":allMoney};
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shareInfoDic options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *parameter_des =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    NSString * url = [LYLHttpTool getShareInfoWithTempid:@"10003" andProduct:@"" andShareplat:@"all" andPicurl:@"" andParameterdes:parameter_des];
//    [LYLAFNetWorking postWithBaseURL:url success:^(id json) {
//        
//        int  code = [[json objectForKey:@"code"]intValue];
//        switch (code) {
//            case 100://成功
//            {
//                NSDictionary * resultListDict = [(NSDictionary *)json objectForKey:@"resultList"];
//                NSString * content = [resultListDict objectForKey:@"content"];
//                NSString * jsonUrl = [resultListDict objectForKey:@"url"];
//                if ([jsonUrl rangeOfString:@"http://"].location != NSNotFound) {
//                    
//                }else{
//                    jsonUrl = [@"http://" stringByAppendingString:jsonUrl];
//                }
//                
//                NSString * picUrl = [resultListDict objectForKey:@"picurl"];
//                NSString * title = [resultListDict objectForKey:@"title"]; //饺子捞起来~我包！众明星携手为你包饺子，捞一捞，2亿现金等你拿！~;//待产品确定分享内容
//                NSString * proUrl = [NSString stringWithFormat:@"%@?productCode=%@",jsonUrl,ProductCode];
//                NSString * newTitle = [NSString stringWithFormat:@"%@ %@",content,proUrl];
//                [LYLTools hideloadingProgressView];
//                [controller baseShareText:content withUrl:proUrl withContent:content withImageName:url ImgStr:picUrl domainName:@"" withqqTitle:title withqqZTitle:title withweCTitle:title withweChtTitle:title withsinaTitle:newTitle];
//                
//            }
//                break;
//            case 102:
//            {
//                [LYLTools showInfoAlert:json[@"message"]];
//            }
//                break;
//                
//                
//            default:
//                break;
//        }
//        
//    } failure:^(NSError *error) {
//        [LYLTools hideloadingProgressView];
//        [LYLTools showInfoAlert:@"网络状态不佳"];
//    }];
//    
//    
//    btn.selected = NO;
//}

//          1. 奖励次的分享接口 捞饺子的弹框  2.导航的分享 分享活动 3.炫耀一下的分享，分享饺子的
+ (void)shareWithType:(NSString *)type andAllMoney:(NSString *)allMoney andViewController:(LaoYiLaoBaseViewController *)viewController{

    [LYLTools showloadingProgressView];

    NSString *requestUrl = @"";
    if([type isEqualToString:@"1"]){//1. 奖励次的分享接口 捞饺子的弹框
 
        /**
         *     获取已捞到的饺子的信息  登陆状态
         */
        NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
        if(!dumplingInforArray){
            dumplingInforArray = [NSMutableArray array];
        }
        /**
         *  饺子失效说明   新的一天开始
         */
        if([MyObjectForKey(DumplingNoLogingTimeKey) intValue] != [[LYLTools currentDateWithDay]intValue]){
            [dumplingInforArray removeAllObjects];//饺子失效 清除缓存
        }
        
        if(dumplingInforArray.count == 0 || !dumplingInforArray){
            [LYLTools showInfoAlert:@"没有可分享饺子"];
        }else{

            CGFloat totalMoney = [LYLTools todayTotalMoneyWithPath:DumplingInforLogingPath];
            DumplingInforModel *lastModel = [DumplingInforModel dumplingInforModelWithDic:(NSDictionary *)[dumplingInforArray lastObject]];
            NSString * starName = lastModel.resultListModel.starName;
            NSString * starIcon = lastModel.resultListModel.starIcon;
            
            NSError *error ;
            NSDictionary * shareInfoDic = @{@"@starName":starName,@"@prizeMoney":[NSString stringWithFormat:@"%.2f",totalMoney]};
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shareInfoDic options:NSJSONWritingPrettyPrinted error:&error];
            NSString *parameter_des =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            requestUrl = [LYLHttpTool getShareInfoWithTempid:@"10002" andProduct:@"" andShareplat:@"all" andPicurl:starIcon andParameterdes:parameter_des];
        }

    }else if ([type isEqualToString:@"2"]){//2.导航的分享 分享活动
        
        requestUrl = [LYLHttpTool getShareInfoWithTempid:@"10001" andProduct:@"" andShareplat:@"all" andPicurl:@"" andParameterdes:@""];
        
    }else if ([type isEqualToString:@"3"]){//
    
        NSError *error ;
        NSDictionary * shareInfoDic = @{@"@allMoney":allMoney};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shareInfoDic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *parameter_des =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        requestUrl = [LYLHttpTool getShareInfoWithTempid:@"10003" andProduct:@"" andShareplat:@"all" andPicurl:@"" andParameterdes:parameter_des];
    }
    
    
    
    
    [LYLAFNetWorking postWithBaseURL:requestUrl success:^(id json) {
        [LYLTools hideloadingProgressView];
        ZHLog(@" 1. 奖励次的分享接口 2.导航的分享 3.炫耀一下的分享 type ==%@,%@",type,json);
        int  code = [[json objectForKey:@"code"]intValue];
        switch (code) {
            case 100://成功
            {
                NSDictionary * resultListDict = [(NSDictionary *)json objectForKey:@"resultList"];
                NSString * content = [resultListDict objectForKey:@"content"];
                NSString * jsonUrl = [resultListDict objectForKey:@"url"];
                if ([jsonUrl rangeOfString:@"http://"].location != NSNotFound) {
                    
                }else{
                    jsonUrl = [@"http://" stringByAppendingString:jsonUrl];
                }
                
                NSString * picUrl = [resultListDict objectForKey:@"picurl"];
                NSString * title = [resultListDict objectForKey:@"title"]; //饺子捞起来~我包！众明星携手为你包饺子，捞一捞，2亿现金等你拿！~;//待产品确定分享内容
                NSString * proUrl = [NSString stringWithFormat:@"%@?productCode=%@",jsonUrl,ProductCode];
                NSString * newTitle = [NSString stringWithFormat:@"%@ %@",content,proUrl];
                [viewController baseShareText:content withUrl:proUrl withContent:content withImageName:picUrl ImgStr:picUrl domainName:@"" withqqTitle:title withqqZTitle:title withweCTitle:title withweChtTitle:title withsinaTitle:newTitle];
                
            }
                break;
            case 102:
            {
                [LYLTools showInfoAlert:json[@"message"]];
            }
                break;
                
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        [LYLTools hideloadingProgressView];
        [LYLTools showInfoAlert:@"网络状态不佳"];
    }];


}
@end
