//
//  LSYEntityGoodsView.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"
@protocol LSYEntityGoodsViewDelegate <NSObject>
@optional
-(void)entityNeedReload;
-(void)tapShare;
@end

@interface LSYEntityGoodsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *goos_Name;
@property (weak, nonatomic) IBOutlet UILabel *goods_Price;
/** 价格的宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goods_PriceW;

@property (weak, nonatomic) IBOutlet UILabel *goods_Num;
@property (weak, nonatomic) IBOutlet UILabel *goods_Kucun;
@property (weak, nonatomic) IBOutlet UILabel *goods_CanBuyNum;
@property (weak, nonatomic) IBOutlet UIImageView *clockIMG;
/** 库存Label的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repertoryHeight;


@property (nonatomic,weak) id<LSYEntityGoodsViewDelegate> delegate;
@property(nonatomic,strong)LSYGoodsInfo * goods;
@property(nonatomic,assign)int time;
@property(nonatomic,strong)NSTimer * timer;
@end
