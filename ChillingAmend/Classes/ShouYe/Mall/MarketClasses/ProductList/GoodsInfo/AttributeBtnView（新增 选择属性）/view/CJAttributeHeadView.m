//
//  CJAttributeHeadView.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-23.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAttributeHeadView.h"
#import "CJAttributeHeaderFile.h"
#import "UIImageView+WebCache.h"


@interface CJAttributeHeadView ()

{
    /** 全局的frame */
    CGRect _frame;
}




@end

@implementation CJAttributeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    _frame = frame;
    if (self = [super initWithFrame:frame]) {
       self = [[[NSBundle mainBundle] loadNibNamed:@"CJAttributeHeadView" owner:self options:nil] firstObject];
    }
    return self;
}

- (void)awakeFromNib
{
//    self.frame = CGRectMake(0,0, _frame.size.width, _frame.size.height );
//     NSLog(@"self.frame111 == %@",NSStringFromCGRect(self.frame));
//    CGRect frameS = self.frame;
//    NSLog(@"frameS111 == %@",NSStringFromCGRect(frameS));
//    
//    
//    frameS.size.height =  self.frame.size.height;
//    NSLog(@"frameS222 == %@",NSStringFromCGRect(frameS));
////    self.frame = frameS;
//    
//     NSLog(@"self.frame222 == %@",NSStringFromCGRect(self.frame));


}

//- (BOOL)needsUpdateConstraints
//{
//    return YES;
//}
//
//- (BOOL)requiresConstraintBasedLayout{
//    
//    return YES;
//}

//- (void)layoutSubviews{
//
//    [super layoutSubviews];
//    
//    CGRect frameS = self.frame;
//    frameS.size.height =  110;
//    self.frame = frameS;
////    NSLog(@"_frame ===== %@",NSStringFromCGRect(_frame));
////  NSLog(@"self.frame4444 == %@",NSStringFromCGRect(self.frame));
//}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect frameS = self.frame;
    frameS.size.height =  110;
    frameS.size.width = SCREENWIDTH;
    self.frame = frameS;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",self.goods.host,self.goods._img_url];
//    [self.iconImage setImageURLStr:url placeholder:[UIImage imageNamed:@"list_placeholder.png"]];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] placeholderImage:[UIImage imageNamed:@"list_placeholder.png"]];
    
    self.iconImage.layer.borderWidth = 1.0;
    self.iconImage.layer.borderColor = [UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1].CGColor;
    
    self.titleLabel.text = self.goods.name;
//    self.priceLabel.text = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",self.goods.cash] andIntegral:[NSString stringWithFormat:@"%.0f",self.goods.price] withfreight:@"0" withWrap:NO];
    
}
@end
