//
//  PRJ_GuaGuaLeListModel.m
//  ChillingAmend
//
//  Created by svendson on 15-1-4.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "PRJ_GuaGuaLeListModel.h"
#import "BXAPI.h"
@implementation PRJ_GuaGuaLeListModel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(PRJ_GuaGuaLeListModel *)getGuaGuaLeListModelWithDic:(NSDictionary *)dic
{
    PRJ_GuaGuaLeListModel *model = [[PRJ_GuaGuaLeListModel alloc]init];
    model.classId = [dic objectForKey:@"classid"];
    model.content = [dic objectForKey:@"content"];
    model.fanWei  = [dic objectForKey:@"fanwei"];
    model.ggImage = [NSString stringWithFormat:@"%@%@",img_url, [dic objectForKey:@"ggimg"]];
     model.lbImage = [NSString stringWithFormat:@"%@%@",img_url, [dic objectForKey:@"lbimg"]];
    return model;

}
@end
