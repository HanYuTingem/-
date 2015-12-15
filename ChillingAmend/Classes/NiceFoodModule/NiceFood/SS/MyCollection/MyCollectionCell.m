//
//  MyCollectionCell.m
//  MyNiceFood
//
//  Created by sunsu on 15/8/3.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "MyCollectionCell.h"
#import "StarsView.h"
@interface MyCollectionCell()
{
    UIButton    * _selectBtn;
    UIImageView * _imageView;
    UILabel     * _ownerNameLabel;
    UILabel     * _addressLabel;
    UILabel     * _industryLabel;
    UILabel     * _consumptionLabel;
    StarsView   * _starView;
    UIView      * _addView;
}
@end

@implementation MyCollectionCell
static NSString * identifier = @"MYCOLLECTIONCELL";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MyCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.bgView];
        
        self.selectButton = [[UIButton alloc]initWithFrame:CGRectMake(PADDING, (80-30)/2, 30, 30)];
        [self.selectButton setImage:[UIImage imageNamed:@"mycoupon_function_btn_default_bg.png"] forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage imageNamed:@"mycoupon_function_btn_selected_bg.png"] forState:UIControlStateSelected];
        self.bgView.userInteractionEnabled = YES;
        [self.bgView addSubview:self.selectButton];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selectButton.frame)+PADDING, PADDING, 90, 60)];
        [self.bgView addSubview:_imageView];
        
        CGFloat ownerNameX = CGRectGetMaxX(_imageView.frame)+PADDING;
        _ownerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ownerNameX, PADDING, SCREEN_WIDTH - ownerNameX - PADDING, 20)];
        _ownerNameLabel.font = [UIFont systemFontOfSize:18.0f];
        [self.bgView addSubview:_ownerNameLabel];
        
        CGRect starFrame = CGRectMake(ownerNameX,CGRectGetMaxY(_ownerNameLabel.frame)+5, 94, 14);
        _addView = [[UIView alloc]initWithFrame:starFrame];
        [self.bgView addSubview:_addView];
        
        CGFloat addressY = CGRectGetMaxY(_addView.frame)+5;
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_ownerNameLabel.frame.origin.x, addressY, _ownerNameLabel.frame.size.width, 20)];
        _addressLabel.font = [UIFont systemFontOfSize:14.0f];
        _addressLabel.textColor = RGBACOLOR(118, 118, 118, 1);
        [self.bgView addSubview:_addressLabel];
        
        _consumptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 3*PADDING, 70, 20)];
        _consumptionLabel.textColor = RGBACOLOR(82, 82, 82, 1);
        _consumptionLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.bgView addSubview:_consumptionLabel];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.frame.origin.x, CGRectGetMaxY(_imageView.frame)+PADDING, SCREEN_WIDTH-2*PADDING-30, 1)];
        lineLabel.backgroundColor = RGBACOLOR(154, 154, 154, 1);
        [self.bgView addSubview:lineLabel];
    }
    return self;
}

-(void)getCellWithModel:(CollectionModel *)model{
    
    NSString * str = [NSString stringWithFormat:@"%@%@",NiceFood_ImageUrl,model.shopImageUrl];
    [_imageView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:DefaultPicture]];
    _ownerNameLabel.text = model.ownerName;
    //
    
    //NSString * labelStr = [model.address substringToIndex:6];
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@",model.address,model.industry];
    _consumptionLabel.text = [NSString stringWithFormat:@"￥%d/人",[model.consumption intValue]];
    _starView = [StarsView setStarsWithFrame:CGRectMake(0, 0, 0, 0) number:[model.star intValue]];
    [_addView addSubview:_starView];
    

}

@end
