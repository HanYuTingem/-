//
//  LSYVirtualGoodsTableViewCell.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"

@protocol LSYVirtualGoodsTableViewCellDelegate <NSObject>
@optional
-(void)goodsNumChange:(int)count;
/** 点击对应的cellcontentView */
- (void)didSecectGoodsContentView;
@end

@interface LSYVirtualGoodsTableViewCell : UITableViewCell
/** 商品Model */
@property (nonatomic,strong)LSYGoodsInfo * goods;
@property (nonatomic,weak)id <LSYVirtualGoodsTableViewCellDelegate>delegate;
/** 传过来的商品购买数量 */
@property (nonatomic,assign)int count;
/** 是否秒杀 其他秒杀 0不秒杀 */
@property (copy, nonatomic) NSString * isSeckilling;
/** 是否有地址 1有0 没 有 */
@property (copy, nonatomic) NSString * isHaveAdd;

/** 购买数量标题 （需隐藏） */
@property (weak, nonatomic) IBOutlet UILabel *buyNumNameLabel;
/** 加减计数器图片 （需隐藏） */
@property (weak, nonatomic) IBOutlet UIImageView *goodsNumImage;
/** 减号按钮（需隐藏） */
@property (weak, nonatomic) IBOutlet UIButton *subtractionBtn;
/** 加号按钮（需隐藏） */
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
/** 购买的个数显示 */
@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@end
