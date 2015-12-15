//
//  MessageFirstCell.m
//  QQList
//
//  Created by sunsu on 15/7/2.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MessageFirstCell.h"

@interface MessageFirstCell()
{
    UILabel * _colorLabel;
}

@end
@implementation MessageFirstCell

static NSString *identifier = @"MESSAGEFIRSTCELL";
+(instancetype)cellWithTableView:(UITableView *)tableView{
    MessageFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    CGFloat y = 10;
    UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING,y, 80,30)];
    numberLabel.text = @"信誉指数";
    numberLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.contentView addSubview:numberLabel];
    
    self.LVLevel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-PADDING-80, y, 80, 30)];
    self.LVLevel.textColor = RGBCOLOR(232, 133, 33);
    [self.contentView addSubview:self.LVLevel];
    
    UILabel * listLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(numberLabel.frame), 20, 50)];
    listLabel.numberOfLines = 0;
    listLabel.font = [UIFont systemFontOfSize:12];
    listLabel.text =@"黑名单";
    listLabel.textAlignment = NSTextAlignmentCenter;
    listLabel.textColor = [UIColor blackColor];
    listLabel.backgroundColor = RGBCOLOR(217, 217, 217);
    [self.contentView  addSubview:listLabel];
    
    //线和颜色方块之间的间隔
    CGFloat p = 5;
    CGFloat labelWidth = (SCREEN_WIDTH- listLabel.frame.size.width-2*PADDING-8*p)/8;
    NSArray * titleArray = @[@"LV6",@"LV11",@"LV21",@"LV41"];
    NSArray * colorArray = @[RGBCOLOR(234, 234, 234),RGBCOLOR(235, 192, 125),RGBCOLOR(252, 129, 32),RGBCOLOR(235, 56, 83)];
    
    //已经做好适配
    for (int i=0 ; i<4; i++) {
        CGFloat lineLabel0 = (CGRectGetMaxX(listLabel.frame));
        CGFloat lineLabelY = (listLabel.frame.size.height/2 + listLabel.frame.origin.y);
        CGFloat lineLabelX = i*2*(labelWidth+p)+p+lineLabel0;
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(lineLabelX, lineLabelY, labelWidth, 1)];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self.contentView  addSubview:lineLabel];
        
        CGFloat colorLabelX = (lineLabelX+labelWidth+p);
        CGFloat colorLabelH = 20;
        CGFloat colorLabelY = listLabel.frame.origin.y+(listLabel.frame.size.height-colorLabelH)/2;
        _colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(colorLabelX, colorLabelY, labelWidth, colorLabelH)];
        _colorLabel.backgroundColor  = colorArray[i];
        _colorLabel.text             = titleArray[i];
        _colorLabel.textAlignment = NSTextAlignmentCenter;
        _colorLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView  addSubview:_colorLabel];
    }
    
    CGRect downBtnFrame = CGRectMake(6*PADDING, CGRectGetMaxY(_colorLabel.frame)+10, SCREEN_WIDTH-12*PADDING, 25);
    self.downBtn = [[UIButton alloc]initWithFrame:downBtnFrame];
    [self.downBtn setImage:[UIImage imageNamed:@"myorder_arrow_down.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.downBtn];
    
    
    CGRect fLabelFrame = CGRectMake(2*PADDING+16, CGRectGetMaxY(downBtnFrame)+5, SCREEN_WIDTH-3*PADDING-25, 20);
    UILabel *fLabel = [[UILabel alloc]initWithFrame:fLabelFrame];
    fLabel.text = @"信誉指数反馈了您的订座信誉度，到店消费告知商家您通过狠便宜订座的，提前取消不影响信誉等级。";
    fLabel.numberOfLines = 0;
    fLabel.font = [UIFont systemFontOfSize:14.0f];
    fLabel.frame =  CGRectMake(2*PADDING+16, CGRectGetMaxY(downBtnFrame), SCREEN_WIDTH-3*PADDING-25,[MyUtils sizeWithString:fLabel.text font:12.0f maxSize:CGSizeMake(SCREEN_WIDTH-3*PADDING-25, MAXFLOAT)].height );//[self getHeight:fLabel.text]
    [self.contentView addSubview:fLabel];
    CGRect img1Frame = CGRectMake(PADDING, (fLabel.frame.size.height-16)/2+fLabel.frame.origin.y, 16, 16);
    UIImageView * img1 = [[UIImageView alloc]initWithFrame:img1Frame];
    img1.image = [UIImage imageNamed:@"myorder_function_ico_circle.png"];
    [self.contentView addSubview:img1];
    
    
    
    CGRect sLabelFrame = CGRectMake(2*PADDING+16, CGRectGetMaxY(fLabel.frame)+5, SCREEN_WIDTH-3*PADDING-25, 20);
    UILabel *sLabel = [[UILabel alloc]initWithFrame:sLabelFrame];
    sLabel.text = @"到店消费一次获得一个 “已到店” 订单，信誉等级增加1级；预订成功但未到店消费一次，等级则降1级。";
    sLabel.numberOfLines = 0;
    sLabel.font = [UIFont systemFontOfSize:14.0f];
    sLabel.frame =  CGRectMake(2*PADDING+16, CGRectGetMaxY(fLabel.frame), SCREEN_WIDTH-3*PADDING-25,[MyUtils sizeWithString:sLabel.text font:12.0f maxSize:CGSizeMake(SCREEN_WIDTH-3*PADDING-25, MAXFLOAT)].height);//[self getHeight:sLabel.text]
    [self.contentView addSubview:sLabel];
    CGRect img2Frame = CGRectMake(PADDING, (sLabel.frame.size.height-16)/2+sLabel.frame.origin.y, 16, 16);
    UIImageView * img2 = [[UIImageView alloc]initWithFrame:img2Frame];
    img2.image = [UIImage imageNamed:@"myorder_function_ico_circle.png"];
    [self.contentView addSubview:img2];
    
    
    CGRect tLabelFrame = CGRectMake(2*PADDING+16, CGRectGetMaxY(sLabel.frame)+5, SCREEN_WIDTH-3*PADDING-25, 20);
    UILabel *tLabel = [[UILabel alloc]initWithFrame:tLabelFrame];
    tLabel.text = @"信誉指数降为0时，订座手机号自动加入黑名单，订座功能将被冻结2个月。";
    tLabel.numberOfLines = 0;
    tLabel.font = [UIFont systemFontOfSize:14.0f];
    tLabel.frame =  CGRectMake(2*PADDING+16, CGRectGetMaxY(sLabel.frame)+5, SCREEN_WIDTH-3*PADDING-25, [MyUtils sizeWithString:tLabel.text font:12.0f maxSize:CGSizeMake(SCREEN_WIDTH-3*PADDING-25, MAXFLOAT)].height);//[self getHeight:tLabel.text]
    [self.contentView addSubview:tLabel];
    CGRect img3Frame = CGRectMake(PADDING, (tLabel.frame.size.height-16)/2+tLabel.frame.origin.y, 16, 16);
    UIImageView * img3 = [[UIImageView alloc]initWithFrame:img3Frame];
    img3.image = [UIImage imageNamed:@"myorder_function_ico_circle.png"];
    [self.contentView addSubview:img3];
    
    CGRect upBtnFrame = CGRectMake(6*PADDING, CGRectGetMaxY(tLabel.frame)+10, SCREEN_WIDTH-12*PADDING, 25);
    self.upBtn = [[UIButton alloc]initWithFrame:upBtnFrame];
    [self.upBtn setImage:[UIImage imageNamed:@"myorder_arrow_up.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.upBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upBtnFrame)+PADDING, SCREEN_WIDTH, 1)];
    imageView.backgroundColor = RGBACOLOR(237, 237, 237, 1);
    [self.contentView  addSubview:imageView];
}

@end
