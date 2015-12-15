//
//  OtherShopListTableViewCell.h
//  HCheap
//
//  Created by 杨 玉龙 on 14/12/12.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 其他商户cell
 */
#import <UIKit/UIKit.h>

@class OtherShopListTableViewCell;

@protocol OtherShopListTableViewCellDelegate <NSObject>

-(void)clickPhone:(UIButton*)sender cell:(OtherShopListTableViewCell*)cell;

@end

@interface OtherShopListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *shopNameLabel;//商家名
@property (strong, nonatomic) IBOutlet UILabel *shopAddressLabel;//商家地址
@property(nonatomic,assign)id<OtherShopListTableViewCellDelegate>delegate;
@property(nonatomic,strong)NSString *phone;//电话
@end
