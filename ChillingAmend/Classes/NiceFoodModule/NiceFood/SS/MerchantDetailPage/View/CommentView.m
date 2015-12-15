//
//  CommentView.m
//  QQList
//
//  Created by sunsu on 15/6/30.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView
+(instancetype)commentViewWithFrame:(CGRect)frame{
    return [[[self class]alloc]initWithCommentViewWithFrame:frame];
}

-(instancetype)initWithCommentViewWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    _headImgView        = [[UIImageView alloc]init];
    _phoneLabel         = [[UILabel alloc]init];
    _commentLabel       = [[UILabel alloc]init];
    _timeLabel          = [[UILabel alloc]init];
    
    [self addSubview:_headImgView];
    [self addSubview:_phoneLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_commentLabel];
    
    CGFloat headImgViewW = 50;
    CGFloat headImgViewH = 50;
    CGFloat headImgViewX = PADDING;
    CGFloat headImgViewY = 10;
    _headImgView.layer.cornerRadius = headImgViewW/2;
    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImgView.layer.borderWidth = 1;
    _headImgView.frame  = CGRectMake(headImgViewX, headImgViewY, headImgViewW, headImgViewH);
    
    CGFloat phoneLabelX       = CGRectGetMaxX(_headImgView.frame)+PADDING;
    CGFloat phoneLabelY       = headImgViewY;
    CGSize phoneLabelSize     = CGSizeMake(100, 20);
    _phoneLabel.font     = [UIFont systemFontOfSize:14.0f];
    _phoneLabel.frame    = CGRectMake(phoneLabelX, phoneLabelY, phoneLabelSize.width, phoneLabelSize.height);
    _phoneLabel.textColor= RGBCOLOR(38, 38, 38);
    
    
    CGFloat timeLabelW = 100;
    CGFloat timeLabelH = phoneLabelSize.height;
    CGFloat timeLabelX = SCREEN_WIDTH  - PADDING - timeLabelW;
    CGFloat timeLabelY = phoneLabelY;
    
    _timeLabel.textColor   = [UIColor lightGrayColor];
    _timeLabel.font        = [UIFont systemFontOfSize:12.0f];
    _timeLabel.frame       = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    
    _commentLabel.font      = [UIFont systemFontOfSize:12.0f];
    _commentLabel.textColor = RGBCOLOR(95, 95, 96);
    
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHead:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [self.headImgView addGestureRecognizer:tapGesture];
}

-(void)layoutSubviews{
    

    CGFloat commentLabelY   = CGRectGetMaxY(_phoneLabel.frame)+5;
    CGFloat commentLabelX   = _phoneLabel.frame.origin.x;
    CGFloat width = SCREEN_WIDTH-90;
    CGFloat height = [MyUtils sizeWithString:_commentLabel.text font:12.0 maxSize:CGSizeMake(width, MAXFLOAT)].height;
    [_commentLabel sizeToFit];
    _commentLabel.numberOfLines = 0;
    _commentLabel.frame     = CGRectMake(commentLabelX,commentLabelY,width,height);
}

-(void)setMerchantComModel:(MerchantModel *)merchantComModel{
    _merchantComModel = merchantComModel;
    [self.headImgView setImageWithURL:[NSURL URLWithString:_merchantComModel.icon] placeholderImage:[UIImage imageNamed:DefaultPicture]];
    self.phoneLabel.text = _merchantComModel.customerName;
    self.timeLabel.text = _merchantComModel.createTime;
    self.commentLabel.text = _merchantComModel.commentContent;
}

//跳转到个人信息的界面
-(void)clickHead:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(clickPerson)]) {
        [self.delegate clickPerson];
    }
}


//-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
//    NSDictionary *dict = @{NSFontAttributeName : font};
//    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
//    return size;
//}

@end
