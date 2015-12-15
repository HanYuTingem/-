//
//  DHSelectMarketCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHSelectMarketCell.h"
#import "UIButton+WebCache.h"


@interface DHSelectMarketCell (){
    ModularListModel *leftModel;//左侧模型
    ModularListModel *rightUpModel;//右侧上面模型
    ModularListModel *rightUnderModel;//右侧下面模型
}

@end

@implementation DHSelectMarketCell

-(void)refreshThreeOneUI:(NSArray *)modularListArr andImagViewURL:(NSString *)imgStr{
    
    for(NSDictionary *dic in modularListArr){
        NSLog(@"%@",dic);
    }
    ModularListModel *leftButtonModel = modularListArr[0];
    [self.threeOneLeftButton setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgStr,leftButtonModel.img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"list_placeholder.png"]];
    
    leftModel = leftButtonModel;
    [self.threeOneLeftButton addTarget:self action:@selector(threeOneLeftButtonDown) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@",modularListArr);
    
    ModularListModel *rightUpButtonModel = modularListArr[1];
    rightUpModel = rightUpButtonModel;
   [self.threeOneRightUpButton setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgStr,rightUpButtonModel.img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"list_placeholder.png"]];
    [self.threeOneRightUpButton addTarget:self action:@selector(threeOneRightUpButtonDown) forControlEvents:UIControlEventTouchUpInside];
    
    
    ModularListModel *rightUnderButtonModel = modularListArr[2];
    rightUnderModel = rightUnderButtonModel;
    [self.threeOneRightUnderButton setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgStr,rightUnderButtonModel.img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"list_placeholder.png"]];
    [self.threeOneRightUnderButton addTarget:self action:@selector(threeOneRightUnderButtonDown) forControlEvents:UIControlEventTouchUpInside];

}

/**
 *  左侧第一个图片
 */
-(void)threeOneLeftButtonDown{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":leftModel}];
}

/**
 *  右侧上面
 */
-(void)threeOneRightUpButtonDown{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":rightUpModel}];
}

/**
 *  右侧下面
 */
-(void)threeOneRightUnderButtonDown{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":rightUnderModel}];
}
@end
