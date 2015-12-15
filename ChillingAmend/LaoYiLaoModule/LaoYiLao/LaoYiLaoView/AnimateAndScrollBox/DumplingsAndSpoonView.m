//
//  DumplingsAndSpoonView.m
//  animation
//
//  Created by wzh on 15/10/30.
//  Copyright (c) 2015年 王兆华. All rights reserved.
//

#import "DumplingsAndSpoonView.h"
//饺子的起始坐标
#define DumplingsBtnX 8 * KPercenX
#define DumplingsBtnY 75 * KPercenY
#define DumplingsBtnW 50 * KPercenX
#define DumplingsBtnH 34 * KPercenY

#define SpoonTopBtnX 0
#define SpoonTopBtnY 88 * KPercenY
#define SpoonTopBtnW 67 * KPercenX
#define SpoonTopBtnH 26 * KPercenY

#define SpoonW 160 * KPercenX
#define SpoonH 113 * KPercenY
@implementation DumplingsAndSpoonView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];

        
        _spoonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_spoonBtn setFrame:CGRectMake(0, 0, SpoonW, SpoonH)];
        [_spoonBtn addTarget:self action:@selector(spoonBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_spoonBtn setBackgroundImage: [UIImage imageNamed:@"shaozi_lao"] forState:UIControlStateNormal];
        [_spoonBtn setBackgroundImage: [UIImage imageNamed:@"shaozi_lao"] forState:UIControlStateHighlighted];
        [self addSubview:_spoonBtn];
        
        _dumplingsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dumplingsBtn setBackgroundImage: [UIImage imageNamed:@"lao_dumplings"] forState:UIControlStateNormal];
        _dumplingsBtn.frame = CGRectMake(DumplingsBtnX, DumplingsBtnY, DumplingsBtnW, DumplingsBtnH);
        [_dumplingsBtn addTarget:self action:@selector(dumpilngsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_dumplingsBtn];
        
        _spoonTopBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_spoonTopBtn setBackgroundImage: [UIImage imageNamed:@"shaozi_lao_mian"] forState:UIControlStateNormal];
        _spoonTopBtn.frame = CGRectMake(SpoonTopBtnX, SpoonTopBtnY, SpoonTopBtnW, SpoonTopBtnH);
        [_spoonTopBtn addTarget:self action:@selector(spoonBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_spoonTopBtn];
    }
    return self;
}

- (void)dumpilngsBtnClicked:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(dumpilngsBtnClicked:)]){
        [self.delegate performSelector:@selector(dumpilngsBtnClicked:) withObject:self ];
    }
}
- (void)spoonBtnClicked:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(spoonBtnClicked:)]){
        [self.delegate performSelector:@selector(spoonBtnClicked:) withObject:self ];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
