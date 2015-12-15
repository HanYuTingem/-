//
//  CustomActionSheet.m
//  HCheap
//
//  Created by dairuiquan on 14-12-8.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "CustomActionSheet.h"
#define TAG_CLEAR       101
#define TAG_CANCEL      102
#define TAG_BACK        103
@implementation CustomActionSheet

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        [self showUI];

    }
    return self;
}

- (void)showUI
{
    self.backgroundColor      = [UIColor clearColor];
    
  
    CGRect blackViewFrame     = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIButton *blackView       = [[UIButton alloc]initWithFrame:blackViewFrame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha           = 0.3;
    blackView.tag             = TAG_BACK;
    [blackView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:blackView];
    
    
    UIView *backView          = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, 170)];
    
    backView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:backView];
    
    CGRect clearBtnFrame      = CGRectMake(20, 30, SCREEN_WIDTH-2*20, 45);
    self.clearBtn        = [[UIButton alloc]initWithFrame:clearBtnFrame];
    self.clearBtn.tag              = TAG_CLEAR;
    [self.clearBtn setBackgroundImage:
     [UIImage imageNamed:@"settingmessagelogin_message_btn_main_bg_normal"] forState:UIControlStateNormal];
//    [self.clearBtn setTitle:@"清除过期和取消的订单" forState:UIControlStateNormal];
    [self.clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.clearBtn];
    
    
    CGRect cancelBtnFrame      = CGRectMake(20, (CGRectGetMaxY(self.clearBtn.frame)+20), SCREEN_WIDTH-2*20, 45);
    UIButton *cancelBtn        = [[UIButton alloc]initWithFrame:cancelBtnFrame];
    cancelBtn.tag              = TAG_CANCEL;
    cancelBtn.backgroundColor  = [UIColor lightGrayColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 4.0f;
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, SCREEN_HEIGHT-170, SCREEN_WIDTH, 170);
    }];
}

- (void)btnClick:(UIButton *)button
{
    ZNLog(@"a");
    if ([self.delegate respondsToSelector:@selector(customActionSheetButtonIndex:)])
    {
        [self.delegate customActionSheetButtonIndex:button.tag];
        [self removeFromSuperview];
    }else {
        ZNLog(@"CustomActionSheet的代理没有实现代理方法");
    }
}

- (void)dismiss
{
    [self.delegate customActionSheetButtonIndex:2];
    [self removeFromSuperview];
}


@end
