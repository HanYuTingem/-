//
//  CrazyShoppingCartShopCommodity.m
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartShopCommodityModel.h"

@implementation CrazyShoppingCartShopCommodityModel

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartFootViewTypeDelete" object:nil];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    if (self) {
        
        //接受全选 取消全选通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelect:) name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
        
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myDelegate:) name:@"CrazyShoppingCartFootViewTypeDelete" object:nil];
        
        self.mId = dic[@"goods_id"];
        
        self.mShopId = dic[@"shop_id"];
        
        self.mIntegral = dic[@"price"];
        
        self.mIsSelect = NO;
        
        self.mName = dic[@"goods_name"];
        
        self.mNumber = [dic[@"goods_nums"] intValue];
        
        self.mPrice = dic[@"cash"];
        
        self.mMaxNumber = [dic[@"nums"] intValue];
        
        self.mImageUrl = dic[@"goods_imgurl"];
        
        self.mRestrictionmNumber = [NSString stringWithFormat:@"%@", dic[@"restriction"] ];
        
        self.mAvailable = [dic[@"available"] integerValue] == -1 ? self.mMaxNumber: [dic[@"available"] integerValue];
      
//        if ([dic[@"available"] integerValue]==0 || self.mMaxNumber == 0) {
//            self.mIsPurchase = NO;
//        }
//        else
//        {
//            self.mIsPurchase = YES;
//        }
//          self.mIsOriginally = self.mIsPurchase;
//        NSLog(@"%d",self.mIsOriginally);
        
        if ([dic[@"available"] integerValue] == 0) {
            self.mNumber = 0;
        }
        
        if (self.mMaxNumber <= 0) {
            self.mAvailable = 0;
            self.mNumber = 0;
        }
    
        
        int max = self.mMaxNumber > self.mAvailable ? self.mAvailable: self.mMaxNumber;
        
        if (self.mNumber  > max) {
            self.mNumber = max;
        }
        
        
        
         self.mShowPrice = [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowPriceWithPrice:self.mPrice integral:self.mIntegral number:1];
        
//        self.mRestrictionmNumber = @"4";

        
//        self.mIntegral = @"200";
//        self.mName = @"非洲富有营养的黑土非洲富有营养的黑土非洲富有营养的黑土非洲富有营养的黑土";
//        self.mNumber = 2;
//        self.mPrice = @"1234";
//        self.mMaxNumber = 8;
        
        
    }
    return self;
}


-(void)changeSelect:(NSNotification *)no
{
//    if (self.mIsPurchase == NO) {
//         self.mIsSelect =NO;
//        return;
//    }
    
    NSLog(@"%@",no);
    NSLog(@"%@",[no userInfo]);
    self.mIsSelect = [[no userInfo][@"select"] boolValue];
}


//-(void)myDelegate:(NSNotification *)no
//{
//    NSDictionary *dic = [no userInfo];
//    if ([dic[@"delete"] boolValue]) {
//        self.mIsPurchase = YES;
//    } else
//    {
//        self.mIsPurchase = self.mIsOriginally;
//        NSLog(@"%d",self.mIsOriginally);
//    }
//}

//-(NSString *)mShowPrice
//{
//    return [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowPriceWithPrice:self.mPrice integral:self.mIntegral number:1];
//}


@end
