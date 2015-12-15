//
//  GetSuccessView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/6.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "GetSuccessView.h"
#define GSViewW self.frame.size.width
@interface GetSuccessView ()
{
    UIImageView * _gsJzImgView;
    UILabel     * _gsLingquLabel;
    UILabel     * _gsCunfangLabel;
    UIButton    * _nowShareBtn;
    UIButton    * _jixuLaoBtn;
    UIButton    * _lookMyWalletBtn;
    UILabel     * _chanceLabel;
    
}
@end

@implementation GetSuccessView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)initUI{
    _gsJzImgView = [[UIImageView alloc]init];
    _gsLingquLabel = [[UILabel alloc]init];
    _gsCunfangLabel = [[UILabel alloc]init];
    _nowShareBtn = [[UIButton alloc]init];
    _jixuLaoBtn = [[UIButton alloc]init];
    _lookMyWalletBtn = [[UIButton alloc]init];
    _chanceLabel = [[UILabel alloc]init];
    
    
    [self addSubview:_gsJzImgView];
    [self addSubview: _gsLingquLabel];
    [self addSubview: _gsCunfangLabel];
    [self addSubview: _nowShareBtn];
    [self addSubview: _jixuLaoBtn ];
    [self addSubview: _lookMyWalletBtn];
    [self addSubview: _chanceLabel];
    
    //frame
//    CGFloat GSView_W = self.frame.size.width;
    CGFloat start_Y = 90/2;
    CGFloat imgView_W = 188/2;
    CGFloat imgView_H = 116/2;
    CGFloat imgView_X = (self.frame.size.width-imgView_W)/2;
    _gsJzImgView.frame = CGRectMake(imgView_X, start_Y, imgView_W, imgView_H);
    
    CGFloat gsLq_Y = CGRectGetMaxY(_gsJzImgView.frame)+30/2;
    _gsLingquLabel.frame = CGRectMake(0,gsLq_Y, GSViewW, 20);
    
    CGFloat gsCf_Y = CGRectGetMaxY(_gsLingquLabel.frame)+20/2;
    _gsCunfangLabel.frame = CGRectMake(0, gsCf_Y, GSViewW, 10);

    
    CGFloat btn_W = 150/2;
    CGFloat btn_H = 58/2;
    CGFloat btn_Y = CGRectGetMaxY(_gsCunfangLabel.frame)+60/2;
    CGFloat btn_pad = 30/2;
    CGFloat share_X = (GSViewW - 2*btn_W - btn_pad)/2;
    _nowShareBtn.frame = CGRectMake(share_X, btn_Y, btn_W, btn_H);
    
    CGFloat jixu_X = CGRectGetMaxX(_nowShareBtn.frame)+15;
    _jixuLaoBtn .frame = CGRectMake(jixu_X, btn_Y, btn_W, btn_H);
    
    CGFloat look_Y = CGRectGetMaxY(_nowShareBtn.frame)+40/2;
    CGFloat look_W = 2*btn_W +btn_pad;
    CGFloat look_X = (GSViewW - look_W)/2;
    CGFloat look_H = btn_H;//45/2; //
    _lookMyWalletBtn.frame = CGRectMake(look_X, look_Y, look_W, look_H);
    
    _chanceLabel.frame = CGRectMake(0, CGRectGetMaxY(_lookMyWalletBtn.frame)+50/2, GSViewW, 10);
    
    //图片和文字
    _gsJzImgView.image = [UIImage imageNamed:@"5_expression"];
    [_nowShareBtn setBackgroundImage:[UIImage imageNamed:@"9_button_a"] forState: UIControlStateNormal];
    [_jixuLaoBtn setBackgroundImage:[UIImage imageNamed:@"9_button_b"] forState: UIControlStateNormal];
    
    _gsLingquLabel.text = @"领取成功！";
    _gsCunfangLabel.text = @"已存放我的钱包";
    [_nowShareBtn setTitle:@"马上分享" forState:UIControlStateNormal];
    [_jixuLaoBtn setTitle:@"继续捞" forState:UIControlStateNormal];
    [_lookMyWalletBtn setTitle:@"查看我的钱包" forState:UIControlStateNormal];
    _chanceLabel.text = @"马上分享,再得一次机会";
    
    _gsLingquLabel.textAlignment = NSTextAlignmentCenter;
    _gsCunfangLabel.textAlignment = NSTextAlignmentCenter;
    _chanceLabel.textAlignment = NSTextAlignmentCenter;
    
    _gsLingquLabel.textColor = [UIColor blackColor];
    _gsCunfangLabel.textColor = [UIColor colorWithRed:0.49f green:0.49f blue:0.49f alpha:1.00f];
    _chanceLabel.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
    
    _gsLingquLabel.font = UIFont30;
    _gsCunfangLabel.font = UIFont20;
    _chanceLabel.font = UIFont20;
    _nowShareBtn.titleLabel.font = UIFont26;
    _jixuLaoBtn.titleLabel.font = UIFont26;
    _lookMyWalletBtn.titleLabel.font = UIFont26;
    
    _lookMyWalletBtn.backgroundColor = [UIColor lightGrayColor];
    _lookMyWalletBtn.layer.cornerRadius = 8;
    

    [_nowShareBtn addTarget:self action:@selector(nowShareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_jixuLaoBtn addTarget:self action:@selector(jixuLaoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_lookMyWalletBtn addTarget:self action:@selector(lookMyWalletBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)nowShareBtnClicked:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareRightNow:)]) {
        [self.delegate shareRightNow:btn];
    }
}

-(void)jixuLaoBtnClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jixuLao)]) {
        [self.delegate jixuLao];
    }
}

- (void)lookMyWalletBtnClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lookMyWallet)]) {
        [self.delegate lookMyWallet];
    }
}

/*
 _gsLingquLabel.frame = CGRectMake(0, 0, 0, 0);
 _gsCunfangLabel
 _nowShareBtn =
 _jixuLaoBtn =
 _lookMyWalletBtn
 _chanceLabel
 
 */

@end
