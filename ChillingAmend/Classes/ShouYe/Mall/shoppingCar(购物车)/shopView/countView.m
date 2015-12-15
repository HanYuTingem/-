//
//  countView.m
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "countView.h"

@implementation countView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        /** 全选按钮 */
        self.selectAllBtn = [ZHButton buttonWithType:UIButtonTypeCustom];
        self.selectAllBtn.frame = CGRectMake(3, 5, 60, 40);
//        self.selectAllBtn.backgroundColor = [UIColor redColor];
        self.selectAllBtn.tag = 222;
        [self addSubview:self.selectAllBtn];
        [self.selectAllBtn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
        [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.selectAllBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        
/** 合计 */
        
        self.CountOrDel = [[UIView alloc] initWithFrame:CGRectMake(80, 0, SCREENWIDTH-80, 49)];
        [self addSubview:self.CountOrDel];
        self.CountOrDel.tag=1110;
     
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 100*SP_WIDTH, 20 )];
        self.moneyLabel.textColor = CrazyColor(165, 0, 0);
        self.moneyLabel.tag = 2323;
//        self.moneyLabel.backgroundColor = [UIColor yellowColor];
        self.moneyLabel.numberOfLines = 0;
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
//        self.moneyLabel.backgroundColor = [UIColor yellowColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:12];
        [self.CountOrDel addSubview:self.moneyLabel];
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"合计:￥0.00"];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
        self.moneyLabel.attributedText = str;
        
        
        self.fareLabel  = [[UILabel alloc] initWithFrame:CGRectMake(40, 25, 90*SP_WIDTH, 20)];
        self.fareLabel.text = @"不含运费";
//        self.fareLabel.backgroundColor = [UIColor redColor];
        self.fareLabel.textAlignment = NSTextAlignmentRight;
        self.fareLabel.font = [UIFont systemFontOfSize:12];
        self.fareLabel.textColor = [UIColor blackColor];

        [self.CountOrDel addSubview:self.fareLabel];

        /** 结算按钮 */
        self.countMoney = [UIButton buttonWithType:UIButtonTypeCustom];
        self.countMoney.frame = CGRectMake(SCREENWIDTH-100, 0, 100, 49);
        self.countMoney.backgroundColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
        [self.countMoney setTitle:@"去结算(0)" forState:UIControlStateNormal];
        self.countMoney.tag = 4444;
        self.countMoney.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.countMoney];
        
        
        
        self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.delButton.frame = CGRectMake(SCREENWIDTH-100, 0, 100, 49);
        [self addSubview:self.delButton];
        self.delButton.backgroundColor =  [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
        self.delButton.hidden = YES;
        [self.delButton setTitle:@"删除" forState:UIControlStateNormal];
        self.delButton.titleLabel.font = [UIFont systemFontOfSize:14];

        [self.delButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.delButton.tag = 1140;
        
    }
    return self;
}
-(CGSize)widthOfString:(NSString *)string withFont:(int)font {
    //    CGSize labsize = [string sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(3750, 9999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                           context:nil];
    
    CGSize size = textRect.size;
    
    return size;
}

-(void)refreshFrame:(NSString *)allMoney{
    
    
    NSLog(@"%@",allMoney);

    CGFloat buttonWidth =self.countMoney.frame.size.width;
    CGFloat moneyWidth =[self widthOfString:allMoney withFont:12].width;

    
//    self.moneyLabel.frame  = CGRectMake(SCREENWIDTH - self.countMoney.frame.size.width -  2 *[self widthOfString:allMoney withFont:12].width, self.moneyLabel.origin.y, [self widthOfString:allMoney withFont:12].width, self.moneyLabel.frame.size.height);
    
    self.moneyLabel.frame = CGRectMake(self.CountOrDel.frame.size.width - buttonWidth - moneyWidth-50, self.moneyLabel.origin.y, [self widthOfString:allMoney withFont:12].width +40, self.moneyLabel.frame.size.height);

    self.fareLabel.frame = CGRectMake(self.CountOrDel.frame.size.width - buttonWidth - moneyWidth-50, self.fareLabel.origin.y, [self widthOfString:allMoney withFont:12].width +40, self.moneyLabel.frame.size.height);

//    NSLog(@"%@  allMoney ",allMoney);
//    if ([allMoney isEqualToString:@"￥0.00"]) {
//        self.moneyLabel.frame = CGRectMake(80, 5, 90*SP_WIDTH, 20 );
//        
//        
////        self.TotalLabel.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame)-self.moneyLabel.frame.size.width-20, 5, 40*SP_WIDTH, 20);
//    }else{
//        if ([self widthOfString:allMoney withFont:12].width < 80) {
//            self.moneyLabel.frame = CGRectMake(80, 5, 50*SP_WIDTH, 20 );
//            self.TotalLabel.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame)-self.moneyLabel.frame.size.width-25, 5, 40*SP_WIDTH, 20);
//        }else{
//            self.moneyLabel.frame  = CGRectMake(SCREENWIDTH - self.countMoney.frame.size.width -  2 *[self widthOfString:allMoney withFont:12].width, self.moneyLabel.origin.y, [self widthOfString:allMoney withFont:12].width, self.moneyLabel.frame.size.height);
////            self.TotalLabel.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame)-self.moneyLabel.frame.size.width-30, 5, 40*SP_WIDTH, 20);
//
//         }
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
