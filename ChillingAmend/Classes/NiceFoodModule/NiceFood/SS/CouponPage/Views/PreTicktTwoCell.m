//
//  PreTicktTwoCell.m
//  PRJ_NiceFoodModule
//
//  Created by Liu on 15/8/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "PreTicktTwoCell.h"
#import "FoodInfoBaseView.h"
#import "CouponModel.h"
#import "CouponListView.h"
@interface PreTicktTwoCell ()
{
    CGRect baseViewFrame;
}
@property (nonatomic,strong) CouponListView * baseView;
@end
@implementation PreTicktTwoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        baseViewFrame = CGRectMake(10, 15, SCREEN_WIDTH-20, 60);
        _baseView = [[CouponListView alloc] initWithCouponListViewFrame:baseViewFrame];
        [self.contentView addSubview:_baseView];
    }
    return self;
}
- (void)reshCelltoMode:(CouponModel*) model andWithIndex:(NSInteger)inDex{
    //   baseView.iconView.image = [UIImage imageNamed:@"meishi_list_icon_hui.png"];
    _baseView.shopName.text = model.merchantName;
    _baseView.coupontimeLabel.text = [NSString stringWithFormat:@"%@至%@",model.validBeginTime,model.validEndTime];
    _baseView.descLabel.text = model.couponName;
    if ([model.state isEqualToString:@"1"]) {
        _baseView.rightImageV.image = [UIImage imageNamed:@"mycoupon_listcoupon_bg_right_u"];
    }else if ([model.state isEqualToString:@"0"]){
        _baseView.rightImageV.image = [UIImage imageNamed:@"mycoupon_listcoupon_bg_right_s"];
    }
}

@end
