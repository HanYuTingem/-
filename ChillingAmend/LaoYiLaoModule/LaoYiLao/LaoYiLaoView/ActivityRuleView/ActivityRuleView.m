//
//  ActivityRuleView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/2.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "ActivityRuleView.h"

@interface ActivityRuleView ()
@property (nonatomic,strong) UITextView * activityRuleTextView;
@end

@implementation ActivityRuleView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor whiteColor];
//        [self initUI];
        [self showUI];
    }
    return self;
}


-(void)showUI{
    CGFloat text_Y = NavgationBarHeight;
    CGRect textViewFrame = CGRectMake(0, text_Y, kkViewWidth, kkViewHeight-text_Y);
    
    _activityRuleTextView = [[UITextView alloc]initWithFrame:textViewFrame];
    _activityRuleTextView.showsVerticalScrollIndicator = NO;
    [self addSubview:_activityRuleTextView];
}
- (void) initUI{
    CGFloat labelWidth = kkViewWidth - KPercenX *20;
    CGFloat labelX = KPercenX * 10;
    CGFloat padding = 15.0/2;
    
    CGRect titleLabelFrame = CGRectMake(labelX, 20, labelWidth, 30);
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:titleLabelFrame];
    titleLabel.text = @"活动规则";
    titleLabel.font = [UIFont fontWithName:@"STHeiti SC" size:30];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIColor * color = RGBACOLOR(14, 14, 14, 1);
    CGRect firstLabelFrame = CGRectMake(labelX, CGRectGetMaxY(titleLabel.frame)+padding, labelWidth, 30);
    UILabel * firstLabel = [[UILabel alloc]initWithFrame:firstLabelFrame];
    firstLabel.text = @"一、捞一捞活动玩法";
    firstLabel.font = UIFont30;
    firstLabel.textColor = color;
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.numberOfLines = 0;
    [firstLabel sizeToFit];
    [self addSubview:firstLabel];
    
    CGRect secondLabelFrame = CGRectMake(labelX, CGRectGetMaxY(firstLabel.frame)+padding, labelWidth, 30);
    UILabel * secondLabel = [[UILabel alloc]initWithFrame:secondLabelFrame];
    secondLabel.text = @"1、活动期间将设置用户互动环节，观众可通过“扫一扫”参与手机互动，全天24小时开阿芳“捞一捞”、“包饺子”(敬请期待)等活动；\n2、每日开奖数量有限，先到先得，赠完为止；\n3、";//明星为用户“包饺子，送祝福”；用户可以参与“捞一捞”,品尝明星送出的饺子
    secondLabel.font = UIFont28;
    secondLabel.textColor = color;
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.numberOfLines = 0;
    [secondLabel sizeToFit];
    [self addSubview:secondLabel];
    
    CGRect thirdLabelFrame = CGRectMake(labelX, CGRectGetMaxY(secondLabel.frame)+padding, labelWidth, 30);
    UILabel * thirdLabel = [[UILabel alloc]initWithFrame:thirdLabelFrame];
    thirdLabel.text = @"3.每位用户每天可参与依次“捞一捞”，下载手机客户端更有两次抽奖机会等着你";
    thirdLabel.font = UIFont28;
    thirdLabel.textColor = color;
    thirdLabel.textAlignment = NSTextAlignmentLeft;
    thirdLabel.numberOfLines = 0;
    [thirdLabel sizeToFit];
    [self addSubview:thirdLabel];
}


-(void)printFont{
    
//    NSArray*familyNames = [UIFont familyNames];
//    for(NSString*familyName in familyNames ){
//        printf("Family: %s \n",[familyName UTF8String] );
//    }
}

@end
