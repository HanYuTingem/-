//
//  FunctionBtn.m
//  LaoYiLao
//
//  Created by sunsu on 15/10/31.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "FunctionBtn.h"

@interface FunctionBtn ()
{
    UILabel     * _countLabel;
    UIImageView * _imgView;
    UILabel     * _nameLabel;
}
@end

@implementation FunctionBtn

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _countLabel = [[UILabel alloc]init];
        _imgView = [[UIImageView alloc]init];
        _nameLabel = [[UILabel alloc]init];
        
        [self addSubview:_countLabel];
        [self addSubview:_imgView];
        [self addSubview:_nameLabel];
    }
    return self;
}


- (void) FunctionBtnWithCount:(NSString*)count Img:(NSString *)img title:(NSString * )title{

 
//        _countLabel = [[UILabel alloc]init];
//        _imgView = [[UIImageView alloc]init];
//        _nameLabel = [[UILabel alloc]init];
    
        _countLabel.textColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f]; //RGBACOLOR(40, 40, 40, 1);
        _countLabel.font = UIFont20;
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.frame = CGRectMake(0, 0, 40, 20);
    
        
        _imgView.frame = CGRectMake(0, CGRectGetMaxY(_countLabel.frame)+10, 31, 31);
        
        _nameLabel.textColor = [UIColor colorWithRed:0.75f green:0.06f blue:0.06f alpha:1.00f];//[UIColor colorWithRed:0.76f green:0.16f blue:0.16f alpha:1.00f];;
        _nameLabel.font = UIFont22;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.frame = CGRectMake(0, CGRectGetMaxY(_imgView.frame)+8, 35, 20);
        
        _countLabel.text = count;
        _imgView.image = [UIImage imageNamed:img];
        _nameLabel.text = title;
        


}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
