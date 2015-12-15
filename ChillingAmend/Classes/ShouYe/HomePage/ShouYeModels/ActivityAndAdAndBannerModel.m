//
//  ActivityModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-25.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "ActivityAndAdAndBannerModel.h"
#import "BXAPI.h"
@implementation ActivityAndAdAndBannerModel

+ (ActivityAndAdAndBannerModel *)getActivityModelWithDic:(NSDictionary *)dic
{
    ActivityAndAdAndBannerModel *model = [[ActivityAndAdAndBannerModel alloc]init];
    model.activityID = [dic objectForKey:@"ad_id"];
    model.activityImage = [NSString stringWithFormat:@"%@/%@",activity_url,[dic objectForKey:@"ad_img"] ];
    model.activityType  = [dic objectForKey:@"ad_type"];
    model.activityUrl = [dic objectForKey:@"ad_url"];
    model.activityName = [dic objectForKey:@"ad_name"];
    model.activityDetail = [dic objectForKey:@"ad_depict"];
    model.browser_type = [dic objectForKey:@"browser_type"];
    model.ad_activity = [dic objectForKey:@"ad_activity"];
    model.share_content = dic[@"share_content"];
    model.share_url = dic[@"share_url"];
    return model;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"------%@--------%@--------%@--------%@------%@",self.activityID,self.activityImage,self.activityType,self.activityUrl,self.ad_activity];
    
}
@end
