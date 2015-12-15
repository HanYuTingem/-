//
//  CrazyBasisTableNoDataView.m
//  MarketManage
//
//  Created by fielx on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisTableNoDataView.h"

@implementation CrazyBasisTableNoDataView

- (instancetype)initWithFrame:(CGRect)frame imageString:(NSString *)imageString
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:imageString];
        
        CrazyBasisImageView *imageView = [[CrazyBasisImageView alloc]initWithImage:image];
        self.mImageView = imageView;
        imageView.frame = CGRectMake(0, 120, image.size.width, image.size.height);
        [self addSubview:imageView];
        [CrazyBasisFrameTool CrazyBasisFrameToolSubCenter:CrazyBasisFrameToolRelativePositionHorizontalCenter superView:self suberView:imageView];
        
        
        CrazyBasisLabel *titleLabel = [[CrazyBasisLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 14, SCREENWIDTH, 30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.mTitleLabel = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:19];
        titleLabel.textColor = C8;
        [self addSubview:titleLabel];
        
        
        CrazyBasisLabel *contentLabel = [[CrazyBasisLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), SCREENWIDTH, 30)];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        self.mContentLabel = contentLabel;
        contentLabel.font = H6;
        contentLabel.textColor = C6;
        [self addSubview:contentLabel];
        

        
        
        CrazyBasisButton *button = [CrazyBasisButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        self.mButton = button;
        
        
        
    }
    return self;
}



-(void)tapButton:(CrazyBasisButton *)button
{
    
}

@end
