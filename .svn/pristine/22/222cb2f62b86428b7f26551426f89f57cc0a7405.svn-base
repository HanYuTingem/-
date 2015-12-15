//
//  MyBookSeatCell.m
//  QQList
//
//  Created by sunsu on 15/7/1.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MyBookSeatCell.h"
static NSString * identifier = @"MYBOOKSEATCELL";

@interface MyBookSeatCell ()

@property(nonatomic,strong)UIImageView      * iconImageView;
@property(nonatomic,strong)UILabel          * orderStatusLabel;
@property(nonatomic,strong)UILabel          * timeLabel;
@property(nonatomic,strong)UILabel          * shopNameLabel;
@property(nonatomic,strong)UILabel          * placeLabel;
@property(nonatomic,strong)UILabel          * customNameLabel;
@property(nonatomic,strong)UILabel          * phoneNumberLabel;
@property(nonatomic,strong)UILabel          * peopleNumberLabel;
@property(nonatomic,strong)UIImageView      * backImage;

@end

@implementation MyBookSeatCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MyBookSeatCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyBookSeatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView              = [[UIImageView alloc]init];
        self.backImage                  = [[UIImageView alloc]init];
        self.orderStatusLabel           = [[UILabel alloc]init];
        self.timeLabel                  = [[UILabel alloc]init];
        self.shopNameLabel              = [[UILabel alloc]init];
        self.placeLabel                 = [[UILabel alloc]init];
        self.customNameLabel            = [[UILabel alloc]init];
        self.phoneNumberLabel           = [[UILabel alloc]init];
        self.peopleNumberLabel          = [[UILabel alloc]init];
        
        
        [self.contentView addSubview:self.backImage];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.orderStatusLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.shopNameLabel];
        [self.contentView addSubview:self.placeLabel];
        [self.contentView addSubview:self.customNameLabel];
        [self.contentView addSubview:self.phoneNumberLabel];
        [self.contentView addSubview:self.peopleNumberLabel];
        [self.contentView addSubview:self.phoneNumberLabel];
    }
    return self;
}

-(void)getCellWithModel:(BookSeatModel * )model{
    self.iconImageView.frame = CGRectMake(PADDING, 20, 25, 25);
    
    self.orderStatusLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+PADDING, 15, 110, 20);
    self.orderStatusLabel.font = [UIFont systemFontOfSize:16.0f];
    self.orderStatusLabel.textColor = RGBCOLOR(102, 107, 113);
    
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+PADDING, 40, 100, 20);
    self.timeLabel.textColor = RGBCOLOR(125, 125, 125);
    self.timeLabel.font = [UIFont systemFontOfSize:12.0f];
    self.timeLabel.numberOfLines = 0;

    self.shopNameLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame)+PADDING, 10, 140, 20);
    self.shopNameLabel.textColor = RGBCOLOR(45, 45, 45);
    self.shopNameLabel.font = [UIFont systemFontOfSize:18.0f];
 
    
    self.peopleNumberLabel.frame = CGRectMake(SCREEN_WIDTH-40-PADDING, CGRectGetMaxY(self.shopNameLabel.frame), 40, 20);
    self.peopleNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    self.peopleNumberLabel.textColor = RGBCOLOR(120, 123, 130);;
    
    self.customNameLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame)+PADDING , CGRectGetMaxY(self.peopleNumberLabel.frame), 70, 20);
    self.customNameLabel.font = [UIFont systemFontOfSize:13.0f];
    self.customNameLabel.textColor = RGBCOLOR(120, 123, 130);
    
    self.phoneNumberLabel.frame = CGRectMake(SCREEN_WIDTH-PADDING-90, self.customNameLabel.frame.origin.y, 90, 20);//CGRectGetMaxX(self.customNameLabel.frame)+PADDING
    self.phoneNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    self.phoneNumberLabel.textColor = RGBCOLOR(120, 123, 130);
    self.phoneNumberLabel.textAlignment = NSTextAlignmentRight;

//    self.timeLabel.text = [GCUtil timeToMyTime:model.updateTime];
    self.timeLabel.text = model.updateTime;
    self.shopNameLabel.text = model.ownerName;
    self.peopleNumberLabel.text = [NSString stringWithFormat:@"%@人",model.seatPeople];
    self.phoneNumberLabel.text = model.phone;
    if ([model.sex isEqualToString:@"1"])
    {
        self.customNameLabel.text = [NSString stringWithFormat:@"%@先生",model.userName];
    }else
    {
        self.customNameLabel.text = [NSString stringWithFormat:@"%@女士",model.userName];
    }
    
    NSString *image;
    NSString *title;
    if ([model.operationState isEqualToString:@"0"])
    {
        image = @"myorder_title_ico_ok";
        title = @"等待中";
        
    }else if ([model.operationState isEqualToString:@"1"])
    {
        image = @"myorder_title_ico_ok";
        title = @"预订成功";
        
    }else if ([model.operationState isEqualToString:@"2"])
    {
        image = @"myorder_title_ico_ok";//myorder_title_ico_already
        title = @"已到店";
        
    }else if([model.operationState isEqualToString:@"3"])
    {
        image = @"myorder_title_ico_delete";
        title = @"商家关闭";
    }else if([model.operationState isEqualToString:@"4"])
    {
        image = @"myorder_title_ico_delete";
        title = @"已拒绝";
    }else if([model.operationState isEqualToString:@"5"])
    {
        image = @"myorder_title_ico_delete";
        title = @"已取消";
    }else
    {
        image = @"myorder_title_ico_delete";
        title = @"已过期";
    }

    [self.iconImageView setImage:[UIImage imageNamed:image]];
    self.orderStatusLabel.text = title;
    
    self.backImage.frame = CGRectMake(0, 1, SCREEN_WIDTH, 79);
    self.backImage.image = [UIImage imageNamed:@"dz_bg.png"];
    
    if ([model.readFlag isEqualToString:@"1"]) {
    //已读就隐藏背景
    NSLog(@"%@",model.readFlag);
        self.backImage.hidden = YES;
    }else {
        self.backImage.hidden = NO;
    }
}


-(void)layoutSubviews{
    
}

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
