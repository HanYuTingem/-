//
//  DHHeadBrandsTJ.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHeadBrandsTJ.h"

@implementation DHHeadBrandsTJ
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        view.backgroundColor = CrazyColor(240, 242, 245);
        [self addSubview:view];
        
        self.upLineIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 0.5)];
        self.upLineIamgeView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:self.upLineIamgeView];

//        self.titleName = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(Left, up, HomeTitleWidth*SP_WIDTH, homeTitleHeight*SP_HEIGHT) Label_text:@"" Label_Font:homeTitleFont];
//
        self.titleName = [[UILabel alloc] initWithFrame:CGRectMake(Left, up, (SCREENWIDTH - 30)*SP_WIDTH, homeTitleHeight*SP_HEIGHT)];
        self.titleName.textColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
        self.titleName.font = [UIFont systemFontOfSize:homeTitleFont];

        [self addSubview:self.titleName];
        
        self.downLineImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 44.5, SCREENWIDTH, 0.5)];
        self.downLineImageView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:self.downLineImageView];
    }
    return self;
}
-(void)refreshBrandsTJ:(NSString *)bransTJ{
    self.titleName.text = bransTJ;
}
@end
