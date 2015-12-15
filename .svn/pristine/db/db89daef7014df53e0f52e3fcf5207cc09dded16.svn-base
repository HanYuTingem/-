//
//  MyBookSeatMgCell.m
//  QQList
//
//  Created by sunsu on 15/7/1.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MyBookSeatMgCell.h"

static NSString * identifier = @"MYBOOKSEATMGCELL";
@implementation MyBookSeatMgCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MyBookSeatMgCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyBookSeatMgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.LVLevel          = [[UILabel alloc]init];
        self.phoneNumLabel    = [[UILabel alloc]init];
        CGRect bLabelFrame = CGRectMake(PADDING, 10, 80, 20);
        UILabel *bLabel  = [[UILabel alloc]initWithFrame:bLabelFrame];
        bLabel.text = @"订座手机号";
        bLabel.font = [UIFont systemFontOfSize:14.0f];
        bLabel.textColor = RGBCOLOR(50, 50, 50);
        [self.contentView addSubview:bLabel];
        
        CGRect phoneNumberFrame = CGRectMake(CGRectGetMaxX(bLabelFrame)+5, bLabelFrame.origin.y, 180, 20);
        self.phoneNumLabel.frame = phoneNumberFrame;
        [self.contentView addSubview:self.phoneNumLabel];

        [self.contentView addSubview:self.LVLevel];
        [self.contentView addSubview:self.phoneNumLabel];
    }
    return self;
}

-(void)reshTabelViewCell:(BookSeatModel *)model{

//    CGFloat y       = 5;
//    CGRect aLabelFrame = CGRectMake(PADDING, y, 70, 30);
//    UILabel * aLabel = [[UILabel alloc]initWithFrame:aLabelFrame];
//    aLabel.text = @"信誉指数";
//    aLabel.font = [UIFont systemFontOfSize:14.0f];
//    aLabel.textColor = RGBCOLOR(50, 50, 50);
//    [self addSubview:aLabel];
//    
//    CGRect aImgViewFrame = CGRectMake(CGRectGetMaxX(aLabelFrame)+10, y, 30, 30);
//    UIImageView * aImgView = [[UIImageView alloc]initWithFrame:aImgViewFrame];
//    aImgView.image = [UIImage imageNamed:@"huangguan.png"];
//    [self addSubview:aImgView];
//    
//    CGRect LVLevelFrame = CGRectMake(CGRectGetMaxX(aImgViewFrame)+5, y+5, 60, 20);
//    self.LVLevel.frame = LVLevelFrame;
//    self.LVLevel.textColor = RGBCOLOR(232, 133, 33);
//    self.LVLevel.text  = [NSString stringWithFormat:@"LV %d",5];//model.grade;
//    [self addSubview:self.LVLevel];
    
//    CGRect bLabelFrame = CGRectMake(PADDING, CGRectGetMaxY(aImgViewFrame)+5, 80, 20);
//    CGRect bLabelFrame = CGRectMake(PADDING, 10, 80, 20);
//    UILabel *bLabel  = [[UILabel alloc]initWithFrame:bLabelFrame];
//    bLabel.text = @"订座手机号";
//    bLabel.font = [UIFont systemFontOfSize:14.0f];
//    bLabel.textColor = RGBCOLOR(50, 50, 50);
//    [self.contentView addSubview:bLabel];
//    
//    CGRect phoneNumberFrame = CGRectMake(CGRectGetMaxX(bLabelFrame)+5, bLabelFrame.origin.y, 180, 20);
//    self.phoneNumLabel.frame = phoneNumberFrame;
//    //self.phoneNumLabel.text = model.customerPhone;
//    [self.contentView addSubview:self.phoneNumLabel];
    
//    CGFloat imgY = (self.frame.size.height - 20)/2;
//    CGRect bImgViewFrame = CGRectMake(SCREEN_WIDTH-PADDING-10, imgY, 10, 20);
//    UIImageView * bImgView = [[UIImageView alloc]initWithFrame:bImgViewFrame];
//    bImgView.image = [UIImage imageNamed:@"personalhome_list_arrow_right.png"];
//    [self addSubview:bImgView];
}



//-(void)layoutSubviews{
//    
//}

//-(void)setBookSeatModel:(BookSeatModel *)bookSeatModel{
//    _bookSeatModel = bookSeatModel;
//
//}




@end
