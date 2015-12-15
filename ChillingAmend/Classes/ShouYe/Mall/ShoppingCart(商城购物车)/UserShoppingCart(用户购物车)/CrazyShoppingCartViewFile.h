//
//  CrazyShoppingCartViewFile.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

/**
 *  用户购物车 公共属性
 */
#ifndef MarketManage_CrazyShoppingCartViewFile_h
#define MarketManage_CrazyShoppingCartViewFile_h


#import "BSaveMessage.h"

#import "CrazyBasisFile.h"

#import "CrazyShoppingCartShopModel.h"
#import "CrazyShoppingCartShopCommodityModel.h"

//一个商品大小
#define CELLSIZE CGSizeMake(SCREENWIDTH, 112+37)
#define CELL_BIG_SIZE CGSizeMake(SCREENWIDTH, 132+37)

//cell灰色边
#define CELL_COLOR_INTERVAR 12
//一个店面 2个上面间隔差
#define CELL_INTERVAR_VIEW 15

//间距
#define INTERVAL 9


//控制器底部视图高度
#define CONTROLLER_FOOT_VIEW_HEIGHT 60


#define CELL_FOOT_VIEW_HEIGHT 37


#endif
