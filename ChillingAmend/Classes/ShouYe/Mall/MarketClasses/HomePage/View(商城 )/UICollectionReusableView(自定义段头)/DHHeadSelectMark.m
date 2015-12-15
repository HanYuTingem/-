//
//  DHHeadSelectMark.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHeadSelectMark.h"
#import "UIButton+WebCache.h"
@implementation DHHeadSelectMark
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, SCREENWIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:line];
//        self.backgroundColor = [UIColor whiteColor];
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
//        view.backgroundColor = CrazyColor(240, 242, 245);
//        [self addSubview:view];
//        
//        self.upLineIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 0.5)];
//        self.upLineIamgeView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:self.upLineIamgeView];
//
//        
//        self.titleName = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(Left, up, HomeTitleWidth*SP_WIDTH, homeTitleHeight*SP_HEIGHT) Label_text:@"" Label_Font:homeTitleFont];
//        [self addSubview:self.titleName];
//        
//        self.downLineImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 44.5, SCREENWIDTH, 0.5)];
//        self.downLineImageView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:self.downLineImageView];
//        
        
//        self.imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.imgBtn.frame = CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height);
//        [self addSubview:self.imgBtn];
//        
    }
    return self;
}
//-(void)refreshSelectMark:(ModularListModel *)model{
//    
//    
//    NSLog(@"%@",model);
//    [self.imgBtn setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"list_placeholder.png"]];
//}
@end
