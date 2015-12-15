//
//  GDHAddBlankTableViewCell.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHAddBlankTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation GDHAddBlankTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    
    }
    return self;
}
-(void)refresh:(GDHBankModel *)model{
    self.bankLabel.text = [NSString stringWithFormat:@"%@（%@）",model.bankName,[self cardSn:model.cardSn]];

    [self.bankImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",walletMybankimh_UrL,model.bankIcon]] placeholderImage:[UIImage imageNamed:@""]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/** 截取后四位字符串 */
- (NSString *)cardSn:(NSString *)card{
    NSString *str = [NSString stringWithFormat:@"%@",card];
    NSRange range = NSMakeRange(str.length - 4, 4);
    return [str substringWithRange:range];
}
@end
