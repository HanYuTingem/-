//
//  BalanceTableViewCell.m
//  Wallet
//
//  Created by GDH on 15/10/21.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "BalanceTableViewCell.h"
#import "WalletHome.h"
@implementation BalanceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        upLine.backgroundColor = WalletHomeBackGRD;
        [self.contentView addSubview:upLine];
        self.upLine = upLine;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(WalletHomeLeftSize, WalletHomeUpSize, 80, 20)];
        self.title.font = [UIFont systemFontOfSize:12];
        self.title.textColor = [UIColor colorWithRed:0.22f green:0.22f blue:0.22f alpha:1.00f];
        [self.contentView addSubview:self.title];
        //红色提示小圆点
        self.redPoint = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 7, 7)];
        self.redPoint.image = [UIImage imageNamed:@"content_ico_more"];
        self.redPoint.hidden = YES;
        [self.title addSubview:self.redPoint];
        
        self.money = [[UILabel alloc] init];
        [self.contentView addSubview:self.money];
        self.money.frame = CGRectMake(CGRectGetMaxX(self.title.frame), WalletHomeUpSize, ScreenWidth - WalletHomeLeftSize - 80 - 25, 20);
        self.money.textColor = [UIColor colorWithRed:0.22f green:0.22f blue:0.22f alpha:1.00f];
        self.money.textAlignment = NSTextAlignmentRight;
        self.money.font = [UIFont systemFontOfSize:12];
        
        self.arrow = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 20, WalletHomeUpSize+4, 8, 13)];
        [self.arrow setImage:[UIImage imageNamed:@"content_btn_more"]];
        [self.contentView addSubview:self.arrow];
        
        
        UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 0.5, ScreenWidth, 0.5)];
        line.backgroundColor = WalletHomeBackGRD;
        self.donwLine = line;
        [self.contentView addSubview:line];
    }
    return self;
}
/** 刷新现金 */
-(void)makeRefreshUI:(NSString *)money{
    
    self.money.text = [NSString stringWithFormat:@"%@",money];
//    self.money.frame = CGRectMake( ScreenWidth - [GCUtil widthOfString:self.money.text withFont:15].width - self.arrow.frame.size.width-15, WalletHomeUpSize, [GCUtil widthOfString:self.money.text withFont:15].width, 20);
}

@end
