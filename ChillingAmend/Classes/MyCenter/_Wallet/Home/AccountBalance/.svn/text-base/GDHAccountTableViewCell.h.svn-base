//
//  GDHAccountTableViewCell.h
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDHRsModel.h"
@interface GDHAccountTableViewCell : UITableViewCell
/** 交易类型 */
@property (weak, nonatomic) IBOutlet UILabel *RechargeTypeLabel;
/** 年月日 */
@property (weak, nonatomic) IBOutlet UILabel *YearMDLale;
/** 时分秒 */
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
/** 金钱 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

/**   刷新数据 */
-(void)refreshAccount:(GDHRsModel *)model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
