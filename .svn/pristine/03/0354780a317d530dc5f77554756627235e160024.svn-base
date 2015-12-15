//
//  DHHeadWonderfulTJ.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHeadWonderfulTJ.h"

@implementation DHHeadWonderfulTJ
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        view.backgroundColor = CrazyColor(240, 242, 245);
        [self addSubview:view];
        
        self.upLineIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 0.5)];
        self.upLineIamgeView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.upLineIamgeView];
        self.downLineImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 44.5, SCREENWIDTH, 0.5)];
        self.downLineImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.downLineImageView];
        self.titleName = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(Left, up, HomeTitleWidth*SP_WIDTH, homeTitleHeight*SP_HEIGHT) Label_text:@"" Label_Font:homeTitleFont];
        [self addSubview:self.titleName];
    }
    return self;
}
-(void)refreshWonderfulTJ:(NSString *)name{
    self.titleName.text = name;
}
@end
