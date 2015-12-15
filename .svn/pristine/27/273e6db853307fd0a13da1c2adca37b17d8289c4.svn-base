//
//  PRJ_VideoShouYeBannerModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-29.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_VideoShouYeBannerModel.h"
#import "BXAPI.h"
@implementation PRJ_VideoShouYeBannerModel

+ (PRJ_VideoShouYeBannerModel *)getActivityModelWithDic:(NSDictionary *)dic
{

    PRJ_VideoShouYeBannerModel *model = [[PRJ_VideoShouYeBannerModel alloc]init];
    model.bannerID = dic[@"ad_id"];
    model.bannerImage = [NSString stringWithFormat:@"%@%@",img_url, dic[@"ad_img"] ];
    model.bannerName = dic[@"ad_name"];
    model.bannerType = dic[@"ad_type"];
    
    return model;
}


@end
