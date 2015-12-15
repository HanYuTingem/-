//
//  CrazyBasisAlertView.m
//  MarketManage
//
//  Created by fielx on 15/4/27.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisAlertView.h"

#define MY_DOSTANCE_X  50

#define TITLE_FONT_SIZE 14
#define CONTENT_FONT_SIZE 12

#import <objc/runtime.h>

static const void *CrazyBasisAlertViewConfirmBlockKey = &CrazyBasisAlertViewConfirmBlockKey;
static const void *CrazyBasisAlertViewCancelBlockKey = &CrazyBasisAlertViewCancelBlockKey;


@implementation CrazyBasisAlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    
    }
    return self;
}



+(CrazyBasisAlertView *)CrazyBasisAlertViewShowTitle:(NSString *)title content:(NSString *)content  buttonTextArray:(NSArray *)textArray  leftSelectBlock:(ConfirmBlock)confirmBlock  rigthSelectBlock:(CancelBlock)cancelBlock
{
  

    
    CrazyBasisAlertView *alertView = [[CrazyBasisAlertView alloc]init];

    
    objc_setAssociatedObject(alertView, CrazyBasisAlertViewCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(alertView, CrazyBasisAlertViewConfirmBlockKey, confirmBlock, OBJC_ASSOCIATION_COPY);

    
    
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:alertView];
    
    int showWidth = SCREENWIDTH - 2*MY_DOSTANCE_X;
    CrazyBasisView *showView = [[CrazyBasisView alloc]init];
    showView.backgroundColor = [UIColor whiteColor];
    [showView cornerRadius:7 lineColor:[UIColor whiteColor] borderWidth:0.01];
    
    NSDictionary * mSizeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:TITLE_FONT_SIZE]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(showWidth - 2*DISTANCEX, MAXFLOAT) options:0 attributes:mSizeDic context:nil].size;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(DISTANCEX, DISTANCEX, showWidth - 2*DISTANCEX, size.height)];
    titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [showView addSubview:titleLabel];
    
    
    
    NSDictionary * mSizeDicContent = @{NSFontAttributeName: [UIFont systemFontOfSize:CONTENT_FONT_SIZE]};
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(showWidth - 2*DISTANCEX, MAXFLOAT) options:0 attributes:mSizeDicContent context:nil].size;

    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(DISTANCEX, CGRectGetMaxY(titleLabel.frame) + 15, showWidth - 2*DISTANCEX, contentSize.height)];
    contentLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = content;
    [showView addSubview:contentLabel];
    
    float intervar = 30;
    float buttonWidth = (showWidth -intervar)/2 - DISTANCEX;
    if (textArray.count == 2) {
        [textArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CrazyBasisButton *button = [CrazyBasisButton buttonAddInView:showView andButtonTitleText:obj andTextColor:C1 andBackGroundColor:nil andCorner:YES andFrame:CGRectMake(DISTANCEX + idx*(buttonWidth + intervar), CGRectGetMaxY(contentLabel.frame) + 35, buttonWidth, 30) andNormalImage:nil andTextFont:TITLE_FONT_SIZE andCorneNumberr:7 andTarget:alertView andSelector:@selector(tapButton:)];
            [button cornerRadius:7 lineColor:C1 borderWidth:1];
            [button setTitleColor:C8 forState:UIControlStateHighlighted];
            button.tag = idx;
            
            showView.frame = CGRectMake(0, 0, showWidth, CGRectGetMaxY(button.frame) + 20);
        }];
    }else{
            showView.frame = CGRectMake(0, 0, showWidth, CGRectGetMaxY(contentLabel.frame) + 20);
    }
    
    alertView.mShowView = showView;
    showView.alpha = 1;
    
    return alertView;
}




-(void)tapButton:(CrazyBasisButton *)button
{
    
  
    if (button.tag == 0) {
        ConfirmBlock block =  objc_getAssociatedObject(self, CrazyBasisAlertViewConfirmBlockKey);
        if (block) {
            block(button);
        }
    }
    else {
        CancelBlock block =  objc_getAssociatedObject(self, CrazyBasisAlertViewCancelBlockKey);
        if (block) {
            block(button);
        }
    }
    
    
    
    NSLog(@"%@",self.mShowView.superview);
    
    [self removeFromSuperview];

}









@end
