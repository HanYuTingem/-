//
//  ZXYOrderGoodsCell.m
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderGoodsCell.h"


#define ZXYOrderGoodsCellLeft 10
#define ZXYOrderGoodsCellWidth 100
#define ZXYOrderGoodsCellHeight 20
#define ZXYOrderGoodsCellFont 14
#define ZXYOrderGoodsCellMoneyInfoX ZXYOrderGoodsCellWidth+10
#define ZXYOrderGoodsCellMoneyInfoWidth SCREENWIDTH - ZXYOrderGoodsCellWidth -30
@implementation ZXYOrderGoodsCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 *
 *
 *  @param style           style
 *  @param reuseIdentifier reuseIdentifier
 *  @param iden            iden  是否是待收货
 *  @param spending_total  spending_total   积分总价
 *  @param goodsCashAmout  goodsCashAmout   现金总价
 *
 *  @return
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIden:(NSString *)iden andSpending_total:(NSString *)spending_total goodsCashAmout:(NSString *)goodsCashAmout
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView;
        
        NSLog(@"%@",spending_total);
        if ([self.detailModel.orderFreight floatValue]==0.00) {

            if ([spending_total isEqualToString:@"0"] || [goodsCashAmout isEqualToString:@"0.00"]) {
                backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 165)];
                
                NSLog(@"包邮， 现金 或者积分其中一件为0 ");

            }else{
                backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 185)];
            }
        }else{
            if ([spending_total isEqualToString:@"0"] || [goodsCashAmout isEqualToString:@"0.00"]) {
                
                NSLog(@"不包邮， 现金 或者积分其中一件为0 ");

                backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 168)];
                
            }else{

            
                backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 185)];
            }
        }
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        /** 支付总额 标头 */
        self.PayTitleAllMoney = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellLeft, 10, 80, 20) Label_text:@"支付总额" Label_Font:ZXYOrderGoodsCellFont];
        [backView addSubview:self.PayTitleAllMoney];
        
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(ZXYOrderGoodsCellLeft-5, CGRectGetMaxY(self.PayTitleAllMoney.frame)+5, SCREENWIDTH - 2*(ZXYOrderGoodsCellLeft-5), 0.5)];
        self.line.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [backView addSubview:self.line];
        
        
        /*------------------------------------------------------------------------------------------------*/
        /** 现金为0 的时候 */
        if ([goodsCashAmout isEqualToString:@"0.00"]) {
            
            /** 积分为0 的时候 */
            if ([spending_total isEqualToString:@"0"]) {
                
            }else{
                /** 商品总额 积分标头 */
                self.shopIntegralTitleMoney = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellLeft, CGRectGetMaxY(self.line.frame)+10, ZXYOrderGoodsCellWidth, ZXYOrderGoodsCellHeight) Label_text:@"商品总额(积分)" Label_Font:ZXYOrderGoodsCellFont];
                [backView addSubview:self.shopIntegralTitleMoney];
                
                
                /** 商品总额 积分 */
                self.shopIntegralMoneyLabel = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellMoneyInfoX,self.shopIntegralTitleMoney.frame.origin.y,ZXYOrderGoodsCellMoneyInfoWidth , ZXYOrderGoodsCellHeight) Label_text:@"" Label_Font:ZXYOrderGoodsCellFont];
                [backView addSubview:self.shopIntegralMoneyLabel];
                self.shopIntegralMoneyLabel.textColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
                self.shopIntegralMoneyLabel.textAlignment = NSTextAlignmentRight;
            }
            

            
        }else{
            /** 商品总额 标头 */
            self.shopAllTitleMoney = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellLeft, CGRectGetMaxY(self.line.frame)+10, ZXYOrderGoodsCellWidth, ZXYOrderGoodsCellHeight) Label_text:@"商品总额(现金)" Label_Font:ZXYOrderGoodsCellFont];
            [backView addSubview:self.shopAllTitleMoney];
            
            /** 商品总额 */
            self.shopAllMoneyLabel = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellMoneyInfoX, self.shopAllTitleMoney.frame.origin.y, ZXYOrderGoodsCellMoneyInfoWidth, ZXYOrderGoodsCellHeight) Label_text:@"" Label_Font:ZXYOrderGoodsCellFont];
            [backView addSubview:self.shopAllMoneyLabel];
            self.shopAllMoneyLabel.textColor =[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
            self.shopAllMoneyLabel.textAlignment = NSTextAlignmentRight;
            
            
       
            /** 积分为0 的时候 */
            if ([spending_total isEqualToString:@"0.00"]) {
                
            }else{
                /** 商品总额 积分标头 */
                self.shopIntegralTitleMoney = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellLeft, CGRectGetMaxY(self.line.frame)+10+self.shopAllTitleMoney.frame.size.height+8, ZXYOrderGoodsCellWidth, ZXYOrderGoodsCellHeight) Label_text:@"商品总额(积分)" Label_Font:ZXYOrderGoodsCellFont];
                [backView addSubview:self.shopIntegralTitleMoney];
                
                
                /** 商品总额 积分 */
                self.shopIntegralMoneyLabel = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellMoneyInfoX,self.shopIntegralTitleMoney.frame.origin.y,ZXYOrderGoodsCellMoneyInfoWidth , ZXYOrderGoodsCellHeight) Label_text:@"" Label_Font:ZXYOrderGoodsCellFont];
                [backView addSubview:self.shopIntegralMoneyLabel];
                self.shopIntegralMoneyLabel.textColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
                self.shopIntegralMoneyLabel.textAlignment = NSTextAlignmentRight;
            }
            

        }
        
        
        CGFloat centerFloat = CGRectGetMaxY(self.line.frame)+10+self.shopAllTitleMoney.frame.size.height+self.shopIntegralTitleMoney.frame.size.height ;
        NSLog(@"%f",centerFloat);
          /** 运费 标头 */
        self.FreightTitleLabel = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellLeft, centerFloat+10, ZXYOrderGoodsCellWidth, ZXYOrderGoodsCellHeight) Label_text:@"运费" Label_Font:ZXYOrderGoodsCellFont];
        [backView addSubview:self.FreightTitleLabel];

        /** 运费 */
        self.FreightLabel = [self set_Labelframe:CGRectMake(ZXYOrderGoodsCellMoneyInfoX, self.FreightTitleLabel.frame.origin.y, ZXYOrderGoodsCellMoneyInfoWidth, ZXYOrderGoodsCellHeight) Label_text:@"" Label_Font:ZXYOrderGoodsCellFont];
        self.FreightLabel.textColor = [UIColor colorWithRed:167/255.0 green:0 blue:9/255.0 alpha:1];
        self.FreightLabel.textAlignment = NSTextAlignmentRight;
        [backView addSubview:self.FreightLabel];
//        self.FreightLabel.backgroundColor = [UIColor redColor];

        
        self.lineTwo = [[UIView alloc] initWithFrame:CGRectMake(ZXYOrderGoodsCellLeft - 5, CGRectGetMaxY(self.FreightLabel.frame)+10, SCREENWIDTH - 2*(ZXYOrderGoodsCellLeft-5) , .5)];
        self.lineTwo.backgroundColor =[UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [backView addSubview:self.lineTwo];
 
        
        self.getMoneyLabel = [self set_Labelframe:CGRectMake(0, CGRectGetMaxY(self.lineTwo.frame)+10, SCREENWIDTH -20, 20) Label_text:@"" Label_Font:ZXYOrderGoodsCellFont];
        self.getMoneyLabel.textAlignment = NSTextAlignmentRight;
//        self.getMoneyLabel.backgroundColor = [UIColor yellowColor];
        self.getMoneyLabel.textColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];

        [backView addSubview:self.getMoneyLabel];
        
        
        
        self.timeLable = [self set_Labelframe:CGRectMake(0, CGRectGetMaxY(self.getMoneyLabel.frame)-2, SCREENWIDTH -20, 20) Label_text:@"" Label_Font:11];
        [self.contentView addSubview:self.timeLable];

        self.timeLable.textAlignment = NSTextAlignmentRight;
        
   
        if ([iden isEqualToString:@"3"]) {
            NSLog(@"待发货");
            self.AutomaticTime = [self set_Labelframe:CGRectMake(0, CGRectGetMaxY(self.timeLable.frame)+20, SCREENWIDTH-20, ZXYOrderGoodsCellHeight) Label_text:@"" Label_Font:ZXYOrderGoodsCellFont];
            self.AutomaticTime.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:self.AutomaticTime];
            
        }
        UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeLable.frame)+11, SCREENWIDTH, 0.5)];
        underView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
//        underView.backgroundColor = [UIColor redColor];
        [self addSubview:underView];
   
        
        CGFloat underFloat = CGRectGetMaxY(self.timeLable.frame)+self.AutomaticTime.frame.size.height;
        NSLog(@"%f",underFloat);
    }
    
    return self;
}

-(void)setCellData{
    self.shopAllMoneyLabel.text = [NSString stringWithFormat:@"￥%@",self.detailModel.goodsCashAmout];
    if([self.detailModel.orderFreight floatValue]==0.00){
        self.FreightLabel.text = @"包邮";
    }else{
        self.FreightLabel.text = [NSString stringWithFormat:@"￥ %@",self.detailModel.orderFreight];
    }
    
    NSString *strMoney = [NSString stringWithFormat:@"实付款 %@",[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%@",self.orderModel.goodsCashAmout] andIntegral:[NSString stringWithFormat:@"%.0f",[self.orderModel.goodsSpendingAmount floatValue]] withfreight:self.detailModel.orderFreight withWrap:NO]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strMoney];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    self.getMoneyLabel.attributedText = str;
    
    self.timeLable.text = [NSString stringWithFormat:@"下单时间：%@",[self getTimestamp:self.detailModel.orderCreatTime]];
    self.AutomaticTime.text = [NSString stringWithFormat:@"自动确认收货时间：%@",self.detailModel.end_receipt];
    self.shopIntegralMoneyLabel.text = [NSString stringWithFormat:@"积分 :%@",self.detailModel.goodsSpendingAmount];

  
   
}
-(NSString*)getTimestamp:(NSString*)timeDate
{
    double create =[timeDate doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:create];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showtimeNew = [formatter1 stringFromDate:confromTimesp];
    return showtimeNew;
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
-(UILabel *)set_Labelframe:(CGRect )frame  Label_text:(NSString *)Text Label_Font:(CGFloat)m_Font //mLabelSize:(CGSize)mWorkSize
{
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=Text;

    label.textColor = CrazyColor(37, 37, 37);

    label.textAlignment=NSTextAlignmentLeft;
//    label.lineBreakMode=NSLineBreakByCharWrapping;
    //    label.font=[UIFont fontWithName:@"Helvetica Neue" size:m_Font];
    label.font = [UIFont systemFontOfSize:m_Font];
    label.numberOfLines=0;
    return label;
}
-(void)setCellLayout{
    
}
@end
