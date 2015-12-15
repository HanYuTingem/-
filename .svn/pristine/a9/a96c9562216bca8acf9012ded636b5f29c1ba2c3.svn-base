//
//  CrazyShoppingCartListCell.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisCell.h"

#import "CrazyShoppingCartViewFile.h"


#import "CrazyShoppingCartListCellView.h"





//
//typedef NS_ENUM(int, ifShowViewOrEditView)
//{
//    showView= 0,
//    editView = 1
//};

/**
 *  通知控制器 总价
 */
#define CrazyShoppingCartListCellChangeShowPrice @"CrazyShoppingCartListCellChangeShowPrice"


/**
 *  商品被选中或取消
 */
#define CrazyShoppingCartListCellWithSlelct @"CrazyShoppingCartListCellWithSlelct"

/**
 *  购物车视图
 */


@interface CrazyShoppingCartListCell : CrazyBasisCell<CrazyShoppingCartListCellViewDelegate>{
    NSMutableDictionary* namedic;
}


/**
 *  数据信息
 */
@property (retain,nonatomic) CrazyShoppingCartShopModel *mModel;

//@property (nonatomic,assign) ifShowViewOrEditView showOrEdit;
@property(nonatomic,assign) BOOL ifShowOrEdit;

//-(void)refreshUI:(BOOL)ifEitd;

@end
