//
//  ZXYRecommendView.h
//  MarketManage
//
//  Created by Rice on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

/*********************************
            推荐商品单元
 ********************************/

#import <UIKit/UIKit.h>
#import "MarketAPI.h"
#import "UIImageView+WebCache.h"
#import "ZXYRecommendModel.h"

@protocol DidSelectProductDelegate <NSObject>

-(void)didSelectProductWithId:(NSString *)productID;

@end

@interface ZXYRecommendView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgeView;
@property (weak, nonatomic) IBOutlet UILabel     *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsNameLabel;

@property (strong, nonatomic) ZXYRecommendModel  *recommendModel;

@property (assign, nonatomic)  id <DidSelectProductDelegate> delegate;

@property (copy, nonatomic) NSString *imageHostUrl;

-(void)setData;

@end
