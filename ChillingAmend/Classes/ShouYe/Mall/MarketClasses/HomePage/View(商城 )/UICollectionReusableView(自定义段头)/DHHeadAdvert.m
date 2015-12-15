//
//  DHHeadAdvert.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHeadAdvert.h"
#import "UIButton+WebCache.h"

@interface  DHHeadAdvert()
{
    ModularListModel *modularListModel;
}

@end
@implementation DHHeadAdvert

-(instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        
        self.ImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ImgButton.frame = CGRectMake(0, 10, SCREENWIDTH, 80);
        [self addSubview:self.ImgButton];
        [self.ImgButton addTarget:self action:@selector(BtnDown) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)refreshSelectMark:(ModularListModel *)model{
        NSLog(@"%@",model);
    modularListModel  = model;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *host = [user objectForKey:@"host"];
    NSString *url = [NSString stringWithFormat:@"%@%@",host,model.img];
        [self.ImgButton setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultimg_4.png"]];
}

/**
 *  点击做通知  首页响应
 */
-(void)BtnDown{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":modularListModel}];
}
@end
