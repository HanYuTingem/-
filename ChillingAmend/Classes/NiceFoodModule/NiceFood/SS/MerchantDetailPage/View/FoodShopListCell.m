//
//  FoodShopListCell.m
//  NiceFoodModular
//
//  Created by sunsu on 15/6/18.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "FoodShopListCell.h"


@interface FoodShopListCell(){
    UIImageView  *_shopImgView;
    UILabel      *_shopNameLabel;
    UILabel      *_descLabel;
    UILabel      *_priceLabel;
}

@end

@implementation FoodShopListCell
static NSString * identifier = @"FOODSHOPLISTCELL";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    FoodShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FoodShopListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shopImgView        = [[UIImageView alloc]init];
        _shopNameLabel      = [[UILabel alloc]init];
        _descLabel          = [[UILabel alloc]init];
        _priceLabel         = [[UILabel alloc]init];
        
        [self.contentView addSubview:_priceLabel];
        [self.contentView addSubview:_descLabel];
        [self.contentView addSubview:_shopNameLabel];
        [self.contentView addSubview:_shopImgView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat shopImgViewW = 50;
    CGFloat shopImgViewH = 50;
    CGFloat shopImgViewX = PADDING;
    CGFloat shopImgViewY = 5;
    _shopImgView.frame  = CGRectMake(shopImgViewX, shopImgViewY, shopImgViewW, shopImgViewH);
    
    CGFloat shopNameX       = CGRectGetMaxX(_shopImgView.frame)+PADDING;
    CGFloat shopNameY       = shopImgViewY;
    CGSize shopNameSize     = CGSizeMake(100, 20);
    _shopNameLabel.font     = [UIFont systemFontOfSize:14.0f];
    _shopNameLabel.frame    = CGRectMake(shopNameX, shopNameY, shopNameSize.width, shopNameSize.height);
    _shopNameLabel.textColor= RGBCOLOR(38, 38, 38);
    
    CGFloat descriptY   = CGRectGetMaxY(_shopNameLabel.frame)+5;
    CGFloat descriptX   = shopNameX;
    _descLabel.numberOfLines = 0;
    [_descLabel sizeToFit];
    CGSize descriptSize = [MyUtils sizeWithString:_descLabel.text font:14.0f maxSize:CGSizeMake(SCREEN_WIDTH-80, MAXFLOAT)];
    CGFloat descriptW = SCREEN_WIDTH-80;
    CGFloat descriptH = descriptSize.height;
    _descLabel.font     = [UIFont systemFontOfSize:12.0f];
    _descLabel.textColor= RGBCOLOR(95, 95, 96);
    _descLabel.frame    = CGRectMake(descriptX, descriptY,descriptW, descriptH);
    _descLabel.textAlignment = NSTextAlignmentJustified;
    
    
    CGFloat priceW = 40;
    CGFloat priceH = shopNameSize.height;
    CGFloat priceX = SCREEN_WIDTH - priceW - 3*PADDING;
    CGFloat priceY = shopNameY;
    
    _priceLabel.textColor   = [UIColor lightGrayColor];
    _priceLabel.font        = [UIFont systemFontOfSize:12.0f];
    _priceLabel.frame       = CGRectMake(priceX, priceY, priceW, priceH);
    
}


-(void)setChannelContentListModel:(NSDictionary *)channelContentListModel{
    _channelContentListModel = channelContentListModel;
    NSDictionary * dict = _channelContentListModel;
    NSString * str = [NSString stringWithFormat:@"%@%@",NiceFood_ImageUrl,[dict objectForKey:@"contentImageUrl"]];
    [_shopImgView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:DefaultPicture]];
    _shopNameLabel.text = [dict objectForKey:@"contentName"];
    _descLabel.text = [dict objectForKey:@"contentDetail"];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"price"]];
    
}

//画cell线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, RGBCOLOR(229, 229, 229).CGColor);
    CGContextStrokeRect(context, CGRectMake(5, 0, rect.size.width, 0.5));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, RGBCOLOR(229, 229, 229).CGColor);
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width, 0.5));
}



@end
