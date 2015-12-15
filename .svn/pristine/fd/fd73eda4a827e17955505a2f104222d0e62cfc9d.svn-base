//
//  LSYUserAdressTableViewCell.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYUserAdressTableViewCell.h"

@implementation LSYUserAdressTableViewCell

- (void)awakeFromNib {
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getAdress)];
    [self addGestureRecognizer:tap];
}
-(void)getAdress
{
    if (self.delegate&& [self.delegate respondsToSelector:@selector(getAdress:)]) {
      [self.delegate getAdress:_oderModel.addressId];
    }
}

/** 设置用户地址*/
- (void)setUserAddress
{
    _oderModel = [ZXYCommitOrderRequestModel shareInstance];
    if([_oderModel.address isEqualToString:@""]){
        [self.noAdress setHidden:NO];

    }else{
        [self.noAdress setHidden:YES];
        self.userName.text=_oderModel.connect_name;;
        self.userTel.text=_oderModel.connect;
        self.userAdress.text=[NSString stringWithFormat:@"%@%@",_oderModel.area,_oderModel.address];
    }
  
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
