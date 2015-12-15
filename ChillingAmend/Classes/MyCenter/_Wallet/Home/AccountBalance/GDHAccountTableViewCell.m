//
//  GDHAccountTableViewCell.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHAccountTableViewCell.h"

@implementation GDHAccountTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *iden = @"iden";
    GDHAccountTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!accountCell) {
        accountCell = [[[NSBundle mainBundle] loadNibNamed:@"GDHAccountTableViewCell" owner:self options:nil] lastObject];
    }
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return accountCell;
    
}
/**  刷新数据 */
-(void)refreshAccount:(GDHRsModel *)model{
    
    self.RechargeTypeLabel.text = [NSString stringWithFormat:@"%@",model.bussinessName];
    self.YearMDLale.text  = [NSString stringWithFormat:@"%@",[WalletRequsetHttp WalletTimeDateFormatterWithStr:model.createDate]];
    if ([[NSString stringWithFormat:@"%@",model.amountType] isEqualToString:@"0"]) {// 0 标识收入，1表示 支出
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@",model.amount];
        self.moneyLabel.textColor =[UIColor colorWithRed:0.97f green:0.55f blue:0.24f alpha:1.00f];
    }else{
        self.moneyLabel.text = [NSString stringWithFormat:@"-%@",model.amount];
        self.moneyLabel.textColor =[UIColor colorWithRed:0.53f green:0.72f blue:0.47f alpha:1.00f];
    }
}
@end
