//
//  LSYUserAdressTableViewCell.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYCommitOrderRequestModel.h"
@protocol LSYUserAdressTableViewCellDelegate <NSObject>
@optional
-(void)getAdress:(NSString *)adress_Id;
@end

@interface LSYUserAdressTableViewCell : UITableViewCell
@property (weak,nonatomic)id <LSYUserAdressTableViewCellDelegate>delegate;
//无地址时显示
@property (weak, nonatomic) IBOutlet UIView *noAdress;
//联系人
@property (weak, nonatomic) IBOutlet UILabel *userName;
//联系地址
@property (weak, nonatomic) IBOutlet UILabel *userAdress;
//联系电话
@property (weak, nonatomic) IBOutlet UILabel *userTel;

@property (nonatomic,strong) ZXYCommitOrderRequestModel  * oderModel;

/** 设置用户地址*/
- (void)setUserAddress;

@end
