//
//  PRJ_GuaGuaLeListModel.h
//  ChillingAmend
//
//  Created by svendson on 15-1-4.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRJ_GuaGuaLeListModel : UIPageControl

@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *fanWei;
@property (nonatomic, strong) NSString *ggImage;
@property (nonatomic, strong) NSString *lbImage;

+(PRJ_GuaGuaLeListModel *)getGuaGuaLeListModelWithDic:(NSDictionary *)dic;

@end
