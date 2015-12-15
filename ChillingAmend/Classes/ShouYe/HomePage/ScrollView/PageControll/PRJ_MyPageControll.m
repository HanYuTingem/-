//
//  PRJ_MyPageControll.m
//  ChillingAmend
//
//  Created by svendson on 15-1-19.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "PRJ_MyPageControll.h"

@implementation PRJ_MyPageControll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
- (void)drawRect:(CGRect)rect {
     Drawing code
}
 */

- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 8;
        size.width = 8;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}

@end
