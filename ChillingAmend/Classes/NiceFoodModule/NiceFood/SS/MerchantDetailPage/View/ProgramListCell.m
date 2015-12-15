//
//  ProgramListCell.m
//  QQList
//
//  Created by sunsu on 15/6/25.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "ProgramListCell.h"

@implementation ProgramListCell
static NSString * identifier = @"PROGRAMLISTCELL";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    ProgramListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ProgramListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    _backImgView         = [[UIImageView alloc]init];
    _nameAndTimeLabel    = [[UILabel alloc]init];
    _maskImgView         = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_backImgView];
    [self.contentView addSubview:_maskImgView];
    [self.maskImgView addSubview:_nameAndTimeLabel];

}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat padding = RECTFIX_WIDTH(10);
    CGFloat backImgViewX = padding;
    CGFloat backImgViewY = 10;
    CGFloat backImgViewW = SCREEN_WIDTH - 2*backImgViewX;
    CGFloat backImgViewH = self.frame.size.height - 2*backImgViewY;
    _backImgView.frame = CGRectMake(backImgViewX, backImgViewY, backImgViewW, backImgViewH);
    _backImgView.image = [UIImage imageNamed:@"tejidatu.jpg"];
    
    CGFloat maskImgViewW = backImgViewW;
    CGFloat maskImgViewH = 30;
    CGFloat maskImgViewX = backImgViewX;
    CGFloat maskImgViewY = backImgViewY+(backImgViewH-maskImgViewH);
    _maskImgView.frame = CGRectMake(maskImgViewX, maskImgViewY , maskImgViewW, maskImgViewH);
    _maskImgView.image = [UIImage imageNamed:@"programme_list_abg.png"];
    
    CGFloat labelW = maskImgViewW;
    CGFloat labelH = 30;
    CGFloat labelX = maskImgViewX + 5;
    CGFloat labelY = (maskImgViewH - labelH)/2;
    _nameAndTimeLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    _nameAndTimeLabel.text = @"《搜食记》 2015-01-13";
    _nameAndTimeLabel.font = [UIFont systemFontOfSize:13.0f];
    _nameAndTimeLabel.textColor = [UIColor whiteColor];
    
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
