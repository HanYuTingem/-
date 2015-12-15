//
//  BalanceTableViewCell.h
//  Wallet
//
//  Created by GDH on 15/10/21.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceTableViewCell : UITableViewCell

/** 账号余额 */
@property(nonatomic,strong)UILabel  *title;

/** lable 显示 金钱 */
@property(nonatomic,strong)UILabel *money;

/** 箭头 */
@property(nonatomic,strong)UIImageView *arrow;
/** 变更红点 */
@property (nonatomic, strong) UIImageView *redPoint;
/** 上面的横线 */
@property (nonatomic, strong) UIView *upLine;

/** 下面的线 */
@property(nonatomic,strong)UIView *donwLine;

-(void)makeRefreshUI:(NSString *)money;


@end
