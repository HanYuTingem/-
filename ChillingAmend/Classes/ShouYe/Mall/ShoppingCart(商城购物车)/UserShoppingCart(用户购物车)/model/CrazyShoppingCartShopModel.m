//
//  CrazyShoppingCartShopModel.m
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartShopModel.h"

@implementation CrazyShoppingCartShopModel

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    if (self) {
        

        //全选 与 取消
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalSelect:) name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
        
        self.mArray = [NSMutableArray arrayWithCapacity:10];
        self.mSelectArray = [NSMutableArray arrayWithCapacity:10];
        
        for (NSDictionary *infoDic in dic[@"list"]) {
            CrazyShoppingCartShopCommodityModel *model = [[CrazyShoppingCartShopCommodityModel alloc]initWithDic:infoDic];
            if (model.mNumber != 0) { // 库存不为0
                [self.mArray addObject:model];
            }
        }
    }
    return self;
}

#pragma mark 全选改变商品小计
-(void)totalSelect:(NSNotification *)no
{
    BOOL select = [[no userInfo][@"select"] boolValue];
    
    
    if (select == YES) {
        NSLog(@"%@",self.mArray);
        self.mSelectArray = [self.mArray mutableCopy];
//        [self.mSelectArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            CrazyShoppingCartShopCommodityModel *model = obj;
//            if (model.mIsPurchase == NO) {
//                [self.mSelectArray removeObject:model];
//            }
//        }];
    }
    else
    {
        [self.mSelectArray removeAllObjects];
    }
    
    self.mShowPrice = [self mShowPrice];
    
}


-(float)mCellHeight
{
    int intervar = 0;
    __block int intervarBlock = intervar;
    [self.mArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CrazyShoppingCartShopCommodityModel *model = obj;
        if ([model.mRestrictionmNumber integerValue]) {
            intervarBlock += 20;
        }
    }];
    return CELLSIZE.height* self.mArray.count + CELL_FOOT_VIEW_HEIGHT - (self.mArray.count -1) * CELL_INTERVAR_VIEW + CELL_COLOR_INTERVAR + intervarBlock;
}

//计算小计
-(NSString *)mShowPrice
{
    NSString *showPrice ;
    
    float price = 0;
    float integral = 0;
    
    for (CrazyShoppingCartShopCommodityModel *model in self.mSelectArray) {
        
        price += [model.mPrice floatValue] * model.mNumber;
        integral += [model.mIntegral floatValue] *  model.mNumber;
        
        showPrice =  [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowPriceWithPrice:[NSString stringWithFormat:@"%f",price] integral:[NSString stringWithFormat:@"%f",integral] number:1];
    }
    self.mTotalIntegral = integral;
    self.mTotalPrice = price;
    
    return [NSString stringWithFormat:@"小计:%@",showPrice];
    
}



@end
