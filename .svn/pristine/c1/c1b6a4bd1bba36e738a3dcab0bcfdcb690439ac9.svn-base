//
//  DHBrandTJCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHBrandTJCell.h"
#import "UIImageView+WebCache.h"
#define titleFont 14
#define infoFont 12

@interface DHBrandTJCell (){
    
    ModularListModel *leftModel;//左侧按钮模型
    ModularListModel *rightUpModel;// 右侧按钮模型
    ModularListModel *rightUnderOneModel;// 右侧下面第一个按钮的模型
    ModularListModel *rightUnderTwoModel ;// 右侧下面第二个按钮的模型
}

@end


@implementation DHBrandTJCell


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {

        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 127*SP_WIDTH, 180*SP_HEIGHT)];
        [self.contentView addSubview:self.leftView];
        //左侧View的标题
        self.leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*SP_WIDTH, 7*SP_HEIGHT, 120*SP_WIDTH, 18*SP_HEIGHT)];
        self.leftTitleLabel.font = [UIFont systemFontOfSize:titleFont];
        [self.leftView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.leftView addSubview:self.leftTitleLabel];
        
//        self.leftView.backgroundColor = [UIColor redColor];
        //详情
        self.leftInfoLabel = [[UILabel alloc]initWithFrame: CGRectMake(10*SP_WIDTH, 23*SP_HEIGHT, 120*SP_WIDTH,18*SP_HEIGHT)];
        self.leftInfoLabel.font = [UIFont systemFontOfSize:infoFont];
        self.leftInfoLabel.textColor = [UIColor lightGrayColor];
        [self.leftView addSubview:self.leftInfoLabel];
        //左侧图片
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*SP_WIDTH, CGRectGetMaxY(self.leftInfoLabel.frame)+15, 107*SP_WIDTH, 92*SP_HEIGHT)];
        [self.leftView addSubview:self.leftImageView];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = self.leftView.bounds;
        self.leftButton.tag = 2000;
        [self.leftView addSubview:self.leftButton];
        
        [self.leftButton addTarget:self action:@selector(leftButtonDown) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(127.5*SP_WIDTH, 0, 0.5, 153*SP_HEIGHT)];
        view.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:view];
        
        //上侧的view
        self.upView = [[UIView alloc] initWithFrame:CGRectMake(128*SP_WIDTH, 0, 192*SP_WIDTH, 61*SP_HEIGHT)];
        [self.contentView addSubview:self.upView];
        
        
//        self.upView.backgroundColor = [UIColor yellowColor];
        
        self.upTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(10*SP_WIDTH, 7, 100*SP_WIDTH, 18*SP_HEIGHT)];
        self.upTitleLable.font = [UIFont systemFontOfSize:14];
        self.upTitleLable.textAlignment = NSTextAlignmentLeft;
        [self.upView addSubview:self.upTitleLable];
    
        
        self.upInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10*SP_WIDTH, 23 *SP_HEIGHT, 100*SP_WIDTH, 18*SP_HEIGHT)];
        self.upInfoLable.textColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        self.upInfoLable.font = [UIFont systemFontOfSize:infoFont];
        [self.upView addSubview:self.upInfoLable];
        
        self.upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120 *SP_WIDTH,3, 55*SP_WIDTH, 55*SP_HEIGHT)];

        [self.upView addSubview:self.upImageView];
        
        
        self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.upButton.frame = self.upView.bounds;
        self.upButton.tag = 2001;
        [self.upView addSubview:self.upButton];
        [self.upButton addTarget:self action:@selector(upButtonDown) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *viewUp = [[UIView alloc] initWithFrame:CGRectMake(127.5*SP_WIDTH, CGRectGetMaxY(self.upView.frame), (SCREENWIDTH - 127.5)*SP_WIDTH ,.5 )];
        viewUp.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:viewUp];
        
        
        //右侧第一个view
        self.rightOneView = [[UIView alloc] initWithFrame:CGRectMake(128*SP_WIDTH, CGRectGetMaxY(viewUp.frame), 96*SP_WIDTH, 92*SP_HEIGHT)];
        [self.contentView addSubview:self.rightOneView];
//        self.rightOneView.backgroundColor = [UIColor greenColor];
        
        self.rightOneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12*SP_WIDTH, 7*SP_WIDTH, 60*SP_WIDTH, 18*SP_HEIGHT)];
        self.rightOneTitleLabel.font = [UIFont systemFontOfSize:titleFont];
        [self.rightOneView addSubview:self.rightOneTitleLabel];
        self.rightOneTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        
        self.rightOneInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12*SP_WIDTH, 23*SP_WIDTH, 60*SP_WIDTH, 15*SP_HEIGHT)] ;
        self.rightOneInfoLabel.font = [UIFont systemFontOfSize:infoFont];
        self.rightOneInfoLabel.textColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.rightOneView addSubview:self.rightOneInfoLabel];
     
        self.rightOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22*SP_WIDTH, CGRectGetMaxY(self.rightOneInfoLabel.frame), 55*SP_WIDTH, 55*SP_HEIGHT)];

        [self.rightOneView addSubview:self.rightOneImageView];
        
//        self.rightOneView.backgroundColor = [UIColor greenColor];
        
        
        //右侧第一个按钮
        self.rightOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightOneButton.frame = self.rightOneView.bounds;
        self.rightOneButton.tag = 2002;
        [self.rightOneView addSubview:self.rightOneButton];
        [self.rightOneButton addTarget:self action:@selector(rightOneButtonDown) forControlEvents:UIControlEventTouchUpInside];
        
        
       
        
        
        //右侧第二个。
        self.rightTwoView = [[UIView alloc] initWithFrame:CGRectMake(224*SP_WIDTH, CGRectGetMaxY(viewUp.frame), 96*SP_WIDTH, 92*SP_HEIGHT)];
        [self.contentView addSubview: self.rightTwoView];
//        self.rightTwoView.backgroundColor = [UIColor cyanColor];
        
        self.rightTwoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12*SP_WIDTH, 7*SP_HEIGHT, 60*SP_WIDTH, 18*SP_HEIGHT)];
        self.rightTwoTitleLabel.font = [UIFont systemFontOfSize:titleFont];
        self.rightTwoTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.rightTwoView addSubview:self.rightTwoTitleLabel];
    
        self.rightTwoInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12*SP_WIDTH, 23*SP_HEIGHT, 60*SP_WIDTH, 15*SP_HEIGHT)];
        self.rightTwoInfoLabel.font = [UIFont systemFontOfSize:infoFont];
        [self.rightTwoView addSubview: self.rightTwoInfoLabel];
        self.rightTwoInfoLabel.textColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];

        self.rightTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22*SP_WIDTH, CGRectGetMaxY(self.rightTwoInfoLabel.frame), 55*SP_WIDTH, 55*SP_HEIGHT)];
        [self.rightTwoView addSubview:self.rightTwoImageView];
        
        self.rightTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightTwoButton.frame = self.rightTwoView.bounds;
        self.rightTwoButton.tag = 2003;
        [self.rightTwoView addSubview:self.rightTwoButton];
        [self.rightTwoButton addTarget:self action:@selector(rightTwoButtonDown) forControlEvents:UIControlEventTouchUpInside];

        UIView *rightOneView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.rightOneView.frame), CGRectGetMaxY(self.upView.frame), .5 ,self.rightOneView.bounds.size.height)];
        rightOneView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:rightOneView];
        
        
        UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.rightTwoView.frame)+1, SCREENWIDTH,.5)];
        underLineView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:underLineView];
        
    }
    return self;
}
/**
 *
 *  @param modularModel 3-1  的模块视图
 */
-(void)refreshDHBrandTJUI:(NSArray *)modularModelArray withUrl:(NSString *)url{
    NSLog(@"%@",modularModelArray);
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *url = [user objectForKey:@"host"];
    
    ModularListModel *modularListLeftModel = modularModelArray[0];
    self.leftTitleLabel.text = modularListLeftModel.title;
    self.leftInfoLabel.text = modularListLeftModel.sub_title;
    [self.leftImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,modularListLeftModel.img]] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
    leftModel = modularListLeftModel;
    
    ModularListModel *modularListUpModel = modularModelArray[1];

    rightUpModel = modularListUpModel;
    self.upTitleLable.text = modularListUpModel.title;
    self.upInfoLable.text = modularListUpModel.sub_title;
    [self.upImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,modularListUpModel.img]] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
    
    
    ModularListModel *modularListrightOneModel = modularModelArray[2];
    rightUnderOneModel = modularListrightOneModel;
    
    self.rightOneTitleLabel.text  =  modularListrightOneModel.title;
    self.rightOneInfoLabel.text = modularListrightOneModel.sub_title;
    [self.rightOneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,modularListrightOneModel.img]] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
    
    
    ModularListModel *modularListRightTwoModel = modularModelArray[3];
    self.rightTwoTitleLabel.text = modularListRightTwoModel.title;
    self.rightTwoInfoLabel.text = modularListRightTwoModel.sub_title;
    [self.rightTwoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,modularListRightTwoModel.img]] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
    rightUnderTwoModel = modularListRightTwoModel;
    
}
/**
 *  左侧图片的按钮点击
 */
-(void)leftButtonDown{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":leftModel}];
    
}

/**
 *  右侧图片上面按钮的点击
 */
-(void)upButtonDown{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":rightUpModel}];
}

/**
 *  右侧下面第一个
 */
-(void)rightOneButtonDown{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":rightUnderOneModel}];
}
/**
 *  右侧下面第二个按钮点击
 */
-(void)rightTwoButtonDown{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":rightUnderTwoModel}];
}
@end
