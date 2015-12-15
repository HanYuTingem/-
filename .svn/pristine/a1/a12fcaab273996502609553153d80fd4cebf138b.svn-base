//
//  MerchantBaseCell.m
//  MyNiceFood
//
//  Created by sunsu on 15/7/17.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "MerchantBaseCell.h"
#define LabelFont  14.0f
@interface MerchantBaseCell(){
    
    UIImageView * _shopImgView;
    UILabel     * _descLabel;

    
    CGFloat descLabelH;//label高度
    CGFloat descLabelW;//label宽度
}

@end
@implementation MerchantBaseCell

static NSString * identifier = @"MerchantBaseCell";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MerchantBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MerchantBaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat shopImgH = 20;
        CGFloat shopImgW = 20;
        CGFloat shopImgY = PADDING;
        CGRect imgViewFrame = CGRectMake(PADDING, shopImgY, shopImgW, shopImgH);
        _shopImgView = [[UIImageView alloc]initWithFrame:imgViewFrame];
        
        descLabelW = SCREEN_WIDTH-shopImgW-4*PADDING;
        descLabelH = 20;
        CGRect desFrame = CGRectMake(CGRectGetMaxX(imgViewFrame)+2*PADDING,_shopImgView.frame.origin.y, descLabelW, descLabelH);
        _descLabel = [[UILabel alloc]initWithFrame:desFrame];
        _descLabel.font = [UIFont systemFontOfSize:LabelFont];
        _descLabel.numberOfLines = 0 ;
        [_descLabel sizeToFit];
        _descLabel.textColor = RGBACOLOR(113, 113, 113, 1);
        
        CGRect otherLabelFrame = CGRectMake(SCREEN_WIDTH-PADDING-80, _shopImgView.frame.origin.y, 80, 20);
        self.otherLabel = [[UILabel alloc]initWithFrame:otherLabelFrame];
        self.otherLabel.textColor = [UIColor redColor];
        self.otherLabel.font  = [UIFont systemFontOfSize:14.0f];
        
        CGRect arrowImgViewFrame = CGRectMake(SCREEN_WIDTH-PADDING-10, _shopImgView.frame.origin.y, 10, 20);
        self.arrowImgView = [[UIImageView alloc]initWithFrame:arrowImgViewFrame];
        self.arrowImgView.image = [UIImage imageNamed:@"personalhome_list_arrow_right.png"];
        
        self.otherLabel.hidden = YES;
        self.arrowImgView.hidden = YES;
        
        [self.contentView addSubview:self.otherLabel];
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:_shopImgView];
        [self.contentView addSubview:_descLabel];
    }
    return self;
}

-(void)reshTabelViewCell:(NSString *)str andImage:(NSString*)imgStr{
    
    _shopImgView.image = [UIImage imageNamed:imgStr];
    _descLabel.text = str;
    CGFloat height = [MyUtils sizeWithString:_descLabel.text font:LabelFont maxSize:CGSizeMake(descLabelW, MAXFLOAT)].height;
    CGFloat y = PADDING;
    if (height <= 20) {
        descLabelH = 20;
        y = PADDING;
    }else{
        descLabelH = height+PADDING;
        y = _shopImgView.frame.origin.y-5;
    }
    _descLabel.frame = CGRectMake(CGRectGetMaxX(_shopImgView.frame)+2*PADDING, y, descLabelW, descLabelH);
}

@end
