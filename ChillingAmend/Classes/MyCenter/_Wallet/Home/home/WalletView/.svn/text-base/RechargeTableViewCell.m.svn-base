//
//  RechargeTableViewCell.m
//  Wallet
//
//  Created by GDH on 15/10/21.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "RechargeTableViewCell.h"
#import "WalletHome.h"

@interface RechargeTableViewCell ()
@end
@implementation RechargeTableViewCell




- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(0, 0.5, ScreenWidth/2, 37-.5);
        [self.leftButton setTitle:@"充值" forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = [UIFont systemFontOfSize:13];

        [self.leftButton setImage:[UIImage imageNamed:@"content_ico_personal_01"] forState:UIControlStateNormal];
        self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        self.leftButton.layer.cornerRadius=0.5;

        [self.leftButton setTitleColor: [UIColor colorWithRed:0.22f green:0.22f blue:0.22f alpha:1.00f] forState:UIControlStateNormal];
        /**  注释： 先不删除 */
//        [self.leftButton setBackgroundImage: [UIImage imageNamed:@"nav-btn-search-selected"] forState:UIControlStateSelected];
        [self.leftButton addTarget:self action:@selector(leftDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.leftButton];
        
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftButton.frame), 0.5, 0.5, 37-0.5)];
        line.backgroundColor = WalletHomeBackGRD;
        [self.contentView addSubview:line];
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(ScreenWidth/2, 0.5, ScreenWidth/2, 37-0.5);
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.rightButton.layer.cornerRadius=0.5;

        [self.rightButton setTitleColor:[UIColor colorWithRed:0.22f green:0.22f blue:0.22f alpha:1.00f] forState:UIControlStateNormal];
        [self.rightButton setTitle:@"提现" forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"content_ico_personal_02"] forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage: [UIImage imageNamed:@"nav-btn-search-selected"] forState:UIControlStateSelected];

        self.rightButton.titleEdgeInsets= UIEdgeInsetsMake(0, 10, 0, 0);
        [self.contentView addSubview:self.rightButton];
        [self.rightButton addTarget:self action:@selector(rightDown:) forControlEvents:UIControlEventTouchUpInside];
        
//        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 37 - 0.5, ScreenWidth, 0.5)];
//        NSLog(@"%f",37);
//        view.backgroundColor = WalletHomeBackGRD;
//        [self.contentView addSubview:view];
        
    }
    return self;
}
/** 充值 */
-(void)leftDown:(UIButton *)leftDown{
    
    leftDown.selected = YES;
    self.RechargeBlock(leftDown);
    NSLog(@"充值");
}
/** 提现 */
-(void)rightDown:(UIButton *)rightDown{
    NSLog(@"提现");
    rightDown.selected = YES;
    self.WithdrawalsBlock(rightDown);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
