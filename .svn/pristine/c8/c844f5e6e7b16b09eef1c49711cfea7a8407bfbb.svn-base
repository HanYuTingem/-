//
//  MyTakeoutOrderTableViewCell.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/8/3.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MyTakeoutOrderTableViewCell.h"

@implementation MyTakeoutOrderTableViewCell



+ (MyTakeoutOrderTableViewCell *)cellWithTableView:(UITableView *)tabelView{
    
    static NSString * ident = @"coupon";
    
    MyTakeoutOrderTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTakeoutOrderTableViewCell" owner:self options:nil] lastObject];
        
        //        cell = [[CouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
}

- (void)setModel:(MyTakeoutOrderModel *)model{
    _model = model;
    
    [_orderTitle setText:_model.ownerName];
    
    
    [_orderPrice setText:[NSString stringWithFormat:@"¥ %.2f元", [_model.actualPrice floatValue]]];

    CGSize titleSize = [_orderPrice.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(1000, 21)];

    self.moneyW.constant = titleSize.width + 10;
    [_orderTime setText:_model.createTime];
    
    switch ([_model.orderFinishState intValue]) {
        case 0:
            [_orderState setImage:[UIImage imageNamed:@"daiqueding"]];
            break;
        case 1 ... 2:
            [_orderState setImage:[UIImage imageNamed:@"yiqueding"]];
            break;
        case 3:
            [_orderState setImage:[UIImage imageNamed:@"yisongda"]];
            break;
        case 4 ... 5:
            [_orderState setImage:[UIImage imageNamed:@"yiguanbi"]];
            break;
        case 6:
            [_orderState setImage:[UIImage imageNamed:@"yiquxiao"]];
            break;
        case 7:
            [_orderState setImage:[UIImage imageNamed:@"yiguoqi"]];
            break;
        default:
            break;
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
