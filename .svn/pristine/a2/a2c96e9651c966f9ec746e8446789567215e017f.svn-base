//
//  LYQOrderHeaderView.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQOrderHeaderView.h"

#import "JSBadgeView.h"
@interface LYQOrderHeaderView (){

    CGRect _rectFrame;
    JSBadgeView *_allView;
}

@end

@implementation LYQOrderHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@synthesize delegate;



- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"LYQOrderHeaderView" owner:self options:nil]lastObject];
      
        [self setFrame:frame];
        

    }
    return self;
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    for (int i = 0 ; i < self.typeBtnArray.count; i++) {
        UIButton *btn = self.typeBtnArray[i];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
        if (i > 0) {
            _allView = [[JSBadgeView alloc] initWithParentView:btn alignment:DHJSBadgeViewAlignmentUpRight];
            _allView.userInteractionEnabled = NO;
//            _allView.badgeText = [NSString stringWithFormat:@"%d",8000+i];
            _allView.tag = 8000+i;
        }
        btn.frame = CGRectMake(SCREENWIDTH/5*i, 0, SCREENWIDTH/5, 30);
        NSLog(@"but.frame = %@",NSStringFromCGRect(btn.frame));
    }
    self.underLineImage.frame = CGRectMake(0, 39, SCREENWIDTH, 1);
}

- (IBAction)selectTypeBtnCliked:(id)sender {
    
    UIButton * typeBtn = (UIButton*)sender;
    //更改点击的按钮的状态设置
    [self moveLineBeFromTypeBtn:typeBtn];
    //点击对应的按钮的方法
    [delegate selectBtnTypeTag:typeBtn.tag];

}

//点击对应的按钮 移动线的距离
- (void)moveLineBeFromTypeBtn:(UIButton*)selectBtn
{
    CGPoint  btnPoint =  selectBtn.center;
    [UIView animateWithDuration:0.3 animations:^{
        [self.redLineImageView setCenter:CGPointMake(btnPoint.x, 36)];
    }];
    
    
    for (UIButton * btn  in self.typeBtnArray){
        [btn setTitleColor:[UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1] forState:UIControlStateNormal];
        
    }
    
    [selectBtn setTitleColor:[UIColor colorWithRed:184/255.0 green:6/255.0 blue:6/255.0 alpha:1] forState:UIControlStateNormal];

}

@end
