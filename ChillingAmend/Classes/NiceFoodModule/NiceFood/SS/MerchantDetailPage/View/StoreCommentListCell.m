//
//  StoreCommentListCell.m
//  MyNiceFood
//
//  Created by sunsu on 15/7/16.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "StoreCommentListCell.h"




@interface StoreCommentListCell(){
    //UIImageView * _headerImage;
    UIButton    * _headButton;
    UILabel     * _nameLabel;
    UILabel     * _timeLabel;
    UILabel     * _commentLabel;
    UIButton    * _picButton;
    UIView      * _markView;
    UILabel     * _markLabel;
}


@end

@implementation StoreCommentListCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    StoreCommentListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCommentListCell"];
    if (cell == nil) {
        cell = [[StoreCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCommentListCell"];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews{
    CGRect headerFrame = CGRectMake(PADDING, PADDING, 40, 40);
    _headButton = [[UIButton alloc]initWithFrame:headerFrame];
    _headButton.layer.cornerRadius = 20;
    _headButton.layer.masksToBounds = YES;
    _headButton.imageView.layer.cornerRadius = 20;
    
    
    CGFloat nameLabelY = PADDING + (headerFrame.size.height-20)/2;
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerFrame)+PADDING,nameLabelY, SCREEN_WIDTH-4*PADDING-100, 20)];
    _nameLabel.textColor = RGBACOLOR(67, 67, 67, 1);
    _nameLabel.font = [UIFont systemFontOfSize:12.0f];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-PADDING-100, nameLabelY, 100, 20)];
    _timeLabel.textColor = RGBACOLOR(154, 154, 154, 1);
    _timeLabel.font = [UIFont systemFontOfSize:12.0f];
    
    CGFloat height = [MyUtils sizeWithString:_commentModel.commentContent font:12.0f maxSize:CGSizeMake(SCREEN_WIDTH-2*PADDING, MAXFLOAT)].height;
    _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(headerFrame)+PADDING, SCREEN_WIDTH-2*PADDING, height)];
    _commentLabel.textColor = RGBACOLOR(169, 169, 169, 1);
    _commentLabel.font = [UIFont systemFontOfSize:12.0f];
    
    CGFloat Width  = (SCREEN_WIDTH-5*PADDING)/4;
    CGFloat Height = Width;
    
    for (int i=0; i<4; i++) {
        CGFloat x = PADDING+i*(PADDING+Width);
        CGFloat y = CGRectGetMaxY(_commentLabel.frame)+PADDING;
        
        CGRect picButtonFrame = CGRectMake(x,y, Width, Height);
        _picButton = [[UIButton alloc]initWithFrame:picButtonFrame];
        _picButton.tag = i+TAG_COMMENTLISTPIC;
        [_picButton addTarget:self action:@selector(lookBigPic:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_picButton];
    }
    
    
    
    

    _markLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING+3*(PADDING+Width), (Height-20)/2, Width, 20)];
    _markLabel.backgroundColor = [UIColor clearColor];
    _markLabel.text = [NSString stringWithFormat:@"共%2d张",6];
    _markLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_markLabel addGestureRecognizer:tap];
    
    [self.contentView addSubview:_headButton];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_commentLabel];
    
}

#pragma mark - ButtonAction
- (void)buttonAction:(id)sender {
    [self.delegate select:self withButton:(UIButton *)sender withArray:self.imageArray];
}

-(void)tapAction{
    UIButton *button = (UIButton *)[self viewWithTag:24];
    [self.delegate select:self withButton:button withArray:self.imageArray];
}

-(void)lookBigPic:(UIButton*)sender{
    
}

-(void)setCommentModel:(CommentModel *)commentModel{
    _commentModel = commentModel;
    [_headButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_commentModel.icon]]] forState:UIControlStateNormal];
    _nameLabel.text = _commentModel.customerName;
    _timeLabel.text = _commentModel.commentTime;
    _commentLabel.text = _commentModel.commentContent;
}


@end
