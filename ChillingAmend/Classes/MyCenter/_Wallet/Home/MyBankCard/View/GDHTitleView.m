//
//  GDHTitleView.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHTitleView.h"

@implementation GDHTitleView
static UILabel *title;

-(instancetype)initWithFrame:(CGRect)frame andMessage:(NSString *)message andleftButtonTitle:(NSString *)leftButtonTitle andRightButtonTitle:(NSString *)rightButtonTitle{
    if (self = [super initWithFrame:frame ]) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        self.backgroundColor = [UIColor whiteColor];
        UILabel *name  = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 30)];
        
        name.text = @"提示";
        name.textAlignment = NSTextAlignmentCenter;
        name.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:name];
        
        //NSLog(@"%f",[GCUtil widthOfString:message withFont:14].width);
        if ([GCUtil widthOfString:message withFont:14] > 162) {
             title = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(name.frame)+8,  self.frame.size.width - 40, 40)];
        }else
        {
            title = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(name.frame)+5,  self.frame.size.width - 40, 20)];
        }
        title.text =  message;
        title.textAlignment = NSTextAlignmentCenter;
        title.numberOfLines = 0;
        title.font = [UIFont systemFontOfSize:14];
        [self addSubview:title];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame)+15, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        
        UIButton *CancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CancelButton.frame = CGRectMake(0, CGRectGetMaxY(line.frame), self.frame.size.width / 2, 44);
        [CancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [CancelButton setTitle: leftButtonTitle forState:UIControlStateNormal];
        CancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [CancelButton setBackgroundImage:[UIImage imageNamed:@"nav-btn-search-selected"] forState:UIControlStateHighlighted];
        [CancelButton addTarget:self action:@selector(CancelButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:CancelButton];
        
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(CancelButton.frame)-0.5, CancelButton.frame.origin.y, 0.5, CancelButton.frame.size.height)];
        line2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line2];
        UIButton *ReleaseBound = [UIButton buttonWithType:UIButtonTypeCustom];
        ReleaseBound.frame = CGRectMake(self.frame.size.width / 2, CGRectGetMaxY(line.frame), self.frame.size.width / 2, 44);
        ReleaseBound.titleLabel.font = [UIFont systemFontOfSize:15];
        [ReleaseBound setTitle: rightButtonTitle forState:UIControlStateNormal];
//        ReleaseBound.backgroundColor = [UIColor colorWithRed:0.87f green:0.34f blue:0.30f alpha:1.00f];
        [ReleaseBound setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ReleaseBound setBackgroundImage:[UIImage imageNamed:@"nav-btn-search-selected"] forState:UIControlStateHighlighted];

        [ReleaseBound addTarget:self action:@selector(ReleaseBoundDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ReleaseBound];
    }
    return self;
}

-(void)CancelButtonDown:(UIButton *)sender{


    self.CancelButtonBlock(sender);
}
-(void)ReleaseBoundDown:(UIButton *)sender{


    self.ReleaseBoundBlock(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
