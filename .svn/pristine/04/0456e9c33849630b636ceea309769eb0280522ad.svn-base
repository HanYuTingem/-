//
//  FoodInfomationCell.m
//  QQList
//
//  Created by sunsu on 15/6/24.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
/**
 *  商户详情大家都在说View
 */

#import "FoodInfomationCell.h"
@interface FoodInfomationCell()
{
    UIView           * _allsayView;
    UIImageView      * _headImgView;
    UILabel          * _phoneLabel;
    UILabel          * _timeLabel;
    UILabel          * _commentLabel;
}
@end
@implementation FoodInfomationCell
static NSString * identifier = @"FOODINFOMATIONCELL";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    FoodInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FoodInfomationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    _allsayView         = [[UIView alloc]init];
    [self.contentView addSubview:_allsayView];

    _headImgView        = [[UIImageView alloc]init];
    _phoneLabel         = [[UILabel alloc]init];
    _commentLabel       = [[UILabel alloc]init];
    _timeLabel          = [[UILabel alloc]init];
    
    [self addSubview:_headImgView];
    [self addSubview:_phoneLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_commentLabel];
    

    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImgView.layer.borderWidth = 1;
    
    
    _phoneLabel.font     = [UIFont systemFontOfSize:14.0f];
    _phoneLabel.textColor= RGBCOLOR(38, 38, 38);
    
    
    _timeLabel.textColor   = [UIColor lightGrayColor];
    _timeLabel.font        = [UIFont systemFontOfSize:12.0f];
   
    
    _commentLabel.font      = [UIFont systemFontOfSize:12.0f];
    _commentLabel.textColor = RGBCOLOR(95, 95, 96);
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHead:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [_headImgView addGestureRecognizer:tapGesture];
    
}


- (void)reshTabelViewCell:(MerchantModel*)model{
    CGFloat allsayViewH = 30;
    UILabel * allsaysLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, (allsayViewH-20)/2, 80, 20)];
    allsaysLabel.text = @"大家都在说";
    allsaysLabel.font = [UIFont systemFontOfSize:12.0f];
    allsaysLabel.textColor = RGBCOLOR(50, 50, 50);
    UIImageView * arrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-3*PADDING, (allsayViewH-15)/2, 10, 15)];
    arrowImgView.image = [UIImage imageNamed:@"personalhome_list_arrow_right.png"];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, allsayViewH-1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = RGBCOLOR(209, 209, 209);
    
    [_allsayView addSubview:allsaysLabel];
    [_allsayView addSubview:arrowImgView];
    [_allsayView addSubview:lineView];
    _allsayView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    
    CGFloat headImgViewW = 50;
    CGFloat headImgViewH = 50;
    CGFloat headImgViewX = PADDING;
    CGFloat headImgViewY = CGRectGetMaxY(_allsayView.frame)+5;
    
    _headImgView.layer.cornerRadius = headImgViewW/2;
    _headImgView.frame  = CGRectMake(headImgViewX, headImgViewY, headImgViewW, headImgViewH);
    
    CGFloat phoneLabelX       = CGRectGetMaxX(_headImgView.frame)+PADDING;
    CGFloat phoneLabelY       = headImgViewY;
    CGSize phoneLabelSize     = CGSizeMake(100, 20);
    _phoneLabel.frame    = CGRectMake(phoneLabelX, phoneLabelY, phoneLabelSize.width, phoneLabelSize.height);
    
    CGFloat timeLabelW = 100;
    CGFloat timeLabelH = phoneLabelSize.height;
    CGFloat timeLabelX = SCREEN_WIDTH  - PADDING - timeLabelW;
    CGFloat timeLabelY = phoneLabelY;
    _timeLabel.frame       = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat commentLabelY   = CGRectGetMaxY(_phoneLabel.frame)+5;
    CGFloat commentLabelX   = _phoneLabel.frame.origin.x;
    CGFloat width = SCREEN_WIDTH-90;
    CGFloat height = [MyUtils sizeWithString:model.commentContent font:14.0 maxSize:CGSizeMake(width, MAXFLOAT)].height;
    [_commentLabel sizeToFit];
    _commentLabel.numberOfLines = 0;
    _commentLabel.frame     = CGRectMake(commentLabelX,commentLabelY,width,height);
    
    [_headImgView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:DefaultPicture]];
    _phoneLabel.text =[NSString stringWithFormat:@"%@",model.customerName];
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.createTime];
    _commentLabel.text = model.commentContent;
}


//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    CGFloat allsayViewH = 30;
//    UILabel * allsaysLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, (allsayViewH-20)/2, 80, 20)];
//    allsaysLabel.text = @"大家都在说";
//    allsaysLabel.font = [UIFont systemFontOfSize:12.0f];
//    allsaysLabel.textColor = RGBCOLOR(50, 50, 50);
//    UIImageView * arrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-3*PADDING, (allsayViewH-15)/2, 10, 15)];
//    arrowImgView.image = [UIImage imageNamed:@"personalhome_list_arrow_right.png"];
//    
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, allsayViewH-1, SCREEN_WIDTH, 1)];
//    lineView.backgroundColor = RGBCOLOR(209, 209, 209);
//    
//    [_allsayView addSubview:allsaysLabel];
//    [_allsayView addSubview:arrowImgView];
//    [_allsayView addSubview:lineView];
//    _allsayView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
//    
//    CGFloat headImgViewW = 50;
//    CGFloat headImgViewH = 50;
//    CGFloat headImgViewX = PADDING;
//    CGFloat headImgViewY = CGRectGetMaxY(_allsayView.frame)+5;
//    
//    _headImgView.layer.cornerRadius = headImgViewW/2;
//    _headImgView.frame  = CGRectMake(headImgViewX, headImgViewY, headImgViewW, headImgViewH);
//    
//    CGFloat phoneLabelX       = CGRectGetMaxX(_headImgView.frame)+PADDING;
//    CGFloat phoneLabelY       = headImgViewY;
//    CGSize phoneLabelSize     = CGSizeMake(100, 20);
//    _phoneLabel.frame    = CGRectMake(phoneLabelX, phoneLabelY, phoneLabelSize.width, phoneLabelSize.height);
//    
//    CGFloat timeLabelW = 100;
//    CGFloat timeLabelH = phoneLabelSize.height;
//    CGFloat timeLabelX = SCREEN_WIDTH  - PADDING - timeLabelW;
//    CGFloat timeLabelY = phoneLabelY;
//    _timeLabel.frame       = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
//    
//    CGFloat commentLabelY   = CGRectGetMaxY(_phoneLabel.frame)+5;
//    CGFloat commentLabelX   = _phoneLabel.frame.origin.x;
//    CGFloat width = SCREEN_WIDTH-90;
//    CGFloat height = [GCUtil sizeWithString:_commentLabel.text font:12.0 maxSize:CGSizeMake(width, MAXFLOAT)].height;
//    [_commentLabel sizeToFit];
//    _commentLabel.numberOfLines = 0;
//    _commentLabel.frame     = CGRectMake(commentLabelX,commentLabelY,width,height);
//}

//-(void)setMerchantComModel:(MerchantModel *)merchantComModel{
//    _merchantComModel = merchantComModel;
//    [_headImgView setImageWithURL:[NSURL URLWithString:_merchantComModel.icon] placeholderImage:[UIImage imageNamed:@"DefaultPicture"]];
//    _phoneLabel.text = _merchantComModel.customerName;
//    _timeLabel.text = _merchantComModel.createTime;
//    _commentLabel.text = _merchantComModel.commentContent;
//}


//跳转到个人信息的界面
-(void)clickHead:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(clickPerson)]) {
        [self.delegate clickPerson];
    }
}



////画cell线
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    //上分割线，
//    CGContextSetStrokeColorWithColor(context, RGBCOLOR(229, 229, 229).CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, 0, rect.size.width, 0.5));
//    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, RGBCOLOR(229, 229, 229).CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width, 0.5));
//}


@end
