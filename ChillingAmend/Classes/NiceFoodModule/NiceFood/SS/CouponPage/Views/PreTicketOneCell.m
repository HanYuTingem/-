//
//  PreTicketOneCell.m
//  PRJ_NiceFoodModule
//
//  Created by Liu on 15/8/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "PreTicketOneCell.h"
#import "FoodInfoBaseView.h"
#import "ProtiketModel.h"
#import "CouponListView.h"
@interface PreTicketOneCell ()
{
    CGRect baseViewFrame;
}
@property (nonatomic,strong) CouponListView * baseView;
@end
@implementation PreTicketOneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        baseViewFrame = CGRectMake(10,5, SCREEN_WIDTH-20, 60);
        _baseView = [[CouponListView alloc] initWithCouponListViewFrame:baseViewFrame];
        [self.contentView addSubview:_baseView];
    }
    return self;
}
- (void)reshCellMode:(ProtiketModel*) model andName:(NSString *)name{
//    CGRect baseViewFram = CGRectMake(10,5, SCREEN_WIDTH-20, 60);
//    CouponListView * baseView = [[CouponListView alloc]initWithCouponListViewFrame:baseViewFram];
    //   baseView.iconView.image = [UIImage imageNamed:@"meishi_list_icon_hui.png"];
    _baseView.shopName.text = name;
    _baseView.coupontimeLabel.text = [NSString stringWithFormat:@"%@至%@",model.validBeginTime,model.validEndTime];
    _baseView.descLabel.text = model.couponName;
    
}

@end
