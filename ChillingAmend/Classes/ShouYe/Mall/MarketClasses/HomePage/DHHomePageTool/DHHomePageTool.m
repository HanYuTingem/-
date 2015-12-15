//
//  DHHomePageTool.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHomePageTool.h"

@implementation DHHomePageTool

-(UILabel *)set_Labelframe:(CGRect )frame  Label_text:(NSString *)Text Label_Font:(CGFloat)m_Font //mLabelSize:(CGSize)mWorkSize
{
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=Text;
    label.textColor = [UIColor colorWithRed:167/255.0 green:0 blue:9/255.0 alpha:1];
    label.textAlignment=NSTextAlignmentCenter;
    label.lineBreakMode=NSLineBreakByCharWrapping;
//    label.font=[UIFont fontWithName:@"Helvetica Neue" size:m_Font];
    label.font = [UIFont boldSystemFontOfSize:m_Font];
    label.numberOfLines=0;
    return label;
}
-(UIImageView *)set_imgframe:(CGRect)frame imgBack:(NSString *)img
{
    UIImageView *imgback = [[UIImageView alloc] initWithFrame:frame ];
    imgback.image = [UIImage imageNamed:img];
    return imgback;
}

-(UIButton *)set_ButtonFrame:(CGRect)frame andImg:(NSString *)img ButtonTag:(int)tag{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    
    btn.frame=frame;
    btn.tag=tag;
    
    return btn;
}

@end
