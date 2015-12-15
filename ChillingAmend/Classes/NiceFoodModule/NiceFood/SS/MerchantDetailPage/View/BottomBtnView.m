//
//  BottomBtnView.m
//  NiceFoodModular
//
//  Created by sunsu on 15/6/17.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "BottomBtnView.h"
@interface BottomBtnView()


@end

@implementation BottomBtnView

- (id)initWithFrame:(CGRect)frame andCollectStatus:(NSString*)status{
    NSLog(@"status=%@",status);
    self = [super initWithFrame:frame];
    if (self) {
        //        NSArray * titleArray = @[@"收藏",@"分享",@"点评"];
        //        NSArray * imageArray = @[@"msxq_0002_tab_icon1.png",@"msxq_0001_tab_icon2.png",@"msxq_0000_tab_icon3.png"];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"msxq_0003_content_tab_bg.png"];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
       
        NSInteger btnCount = 2;
        CGFloat btnW = 24;
        CGFloat startX = (SCREEN_WIDTH - btnCount*btnW - (btnCount-1)*RECTFIX_WIDTH(30))/2;
        
        //收藏
        CGRect btnFrame = CGRectMake(0*(RECTFIX_WIDTH(30)+btnW)+startX,10, btnW, 50);
        self.collectBtn = [[BottomBtn alloc]initWithFrame:btnFrame];
        [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置图片
        [self.collectBtn setImage:[UIImage imageNamed:@"msxq_0002_tab_icon1_selected.png"] forState:UIControlStateSelected];
        [self.collectBtn setImage:[UIImage imageNamed:@"msxq_0002_tab_icon1.png"] forState:UIControlStateNormal];
        
        //staus:收藏状态 1已收藏 0 未收藏
        if ([status intValue]==1) {
            self.collectBtn.selected = YES;
        }else{
            //未收藏
            self.collectBtn.selected = NO;
        }
        

        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        self.collectBtn.tag = 3000;
        [self.collectBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.collectBtn];
        
        CGRect btnFrame1 = CGRectMake(1*(RECTFIX_WIDTH(30)+btnW)+startX,10, btnW, 50);
        self.shareBtn = [[BottomBtn alloc]initWithFrame:btnFrame1];
        [self.shareBtn setImage:[UIImage imageNamed:@"msxq_0001_tab_icon2.png"] forState:UIControlStateNormal];
        [self.shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        self.shareBtn.tag = 3001;
        [self.shareBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shareBtn];
        
//        CGRect btnFrame2 = CGRectMake(2*(RECTFIX_WIDTH(30)+btnW)+startX,10, btnW, 50);
//        self.reviewsBtn = [[BottomBtn alloc]initWithFrame:btnFrame2];
//        [self.reviewsBtn setImage:[UIImage imageNamed:@"msxq_0000_tab_icon3.png"] forState:UIControlStateNormal];
//        [self.reviewsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.reviewsBtn setTitle:@"点评" forState:UIControlStateNormal];
//        self.reviewsBtn.tag = 3002;
//        [self.reviewsBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.reviewsBtn];
        
        
        
//        for (int i=0; i<titleArray.count; i++) {
//            CGRect btnFrame = CGRectMake(i*(RECTFIX_WIDTH(30)+btnW)+startX,10, btnW, 50);
//            self.btn = [[BottomBtn alloc]initWithFrame:btnFrame];
//            
//            [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            if (i == 0) {
//                if ([status intValue]==1) {
//                    [self.btn setImage:[UIImage imageNamed:@"msxq_0002_tab_icon1_selected.png"] forState:UIControlStateNormal];
//                }else{
//                    [self.btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
//                }
//            }else{
//                [self.btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
//            }
//            [self.btn setTitle:titleArray[i] forState:UIControlStateNormal];
//            self.btn.tag = i+3000;
//            [self.btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:self.btn];
//        }
        
        
        
        
        
        
    }
    return self;
}

-(void)clickBtn:(BottomBtn*)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(clickByButtonTag:)]) {
        [_delegate clickByButtonTag:sender.tag-3000];
    }
}

@end
