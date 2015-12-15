//
//  ShoppingCarCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ShoppingCarCell.h"

#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"



@implementation ShoppingCarCell

- (void)awakeFromNib {
    // Initialization code
    

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

//        self.clipsToBounds = YES;
//        self.backgroundColor = [UIColor redColor];
        self.invaildLabel = [[UILabel alloc] initWithFrame:CGRectMake(3*SP_WIDTH, 40*SP_HEIGHT, 30*SP_WIDTH, 20*SP_HEIGHT)];
        self.invaildLabel.text = @"失效";
        self.invaildLabel.textAlignment = NSTextAlignmentCenter;
        self.invaildLabel.clipsToBounds = YES;
        self.invaildLabel.layer.cornerRadius = 3;
        self.invaildLabel.textColor = [UIColor whiteColor];
        self.invaildLabel.backgroundColor = [UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f];
        self.invaildLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.invaildLabel];
        self.invaildLabel.hidden = YES;
        
        //选择按钮
        self.selectBtn = [ZHButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.frame = CGRectMake(0, 40*SP_HEIGHT, 36*SP_WIDTH, 36*SP_HEIGHT);
//        self.selectBtn.backgroundColor = [UIColor redColor];

        [self.contentView addSubview:self.selectBtn];
        [self.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
        //  商品图片
        self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectBtn.frame), 15*SP_HEIGHT, 79*SP_WIDTH, 79*SP_HEIGHT)];

        self.shopImageView.layer.borderWidth = 0.5f;
        self.shopImageView.layer.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
//        self.shopImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.shopImageView];
        //商品标题
        self.shopTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shopImageView.frame)+12,16*SP_HEIGHT, SCREENWIDTH - CGRectGetMaxX(self.shopImageView.frame) - 30, 30*SP_HEIGHT)];
        [self.contentView addSubview:self.shopTitle];
        self.shopTitle.numberOfLines = 0;
//        self.shopTitle.backgroundColor = [UIColor yellowColor];
        self.shopTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.shopTitle];
        
        //可以显示的view
        self.showView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shopImageView.frame)+12, CGRectGetMaxY(self.shopTitle.frame), SCREENWIDTH - CGRectGetMaxX(self.shopImageView.frame) , 60*SP_HEIGHT)];
//        self.showView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.showView];
        //显示的商品颜色
        self.colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.showView.frame.size.width - 20, 35*SP_HEIGHT)];
        self.colorLabel.textColor = [UIColor lightGrayColor];
        
        self.colorLabel.numberOfLines = 0;
//        self.colorLabel.backgroundColor = [UIColor redColor];
        self.colorLabel.textAlignment  = NSTextAlignmentLeft;
        self.colorLabel.font = [UIFont systemFontOfSize:12];
        [self.showView addSubview:self.colorLabel];
        
        //商品现价
        self.nowMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(-2, CGRectGetMaxY(self.colorLabel.frame)-5, 172*SP_WIDTH, 20*SP_HEIGHT)];
        self.nowMoneyLabel.textColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
        self.nowMoneyLabel.font = [UIFont systemFontOfSize:13];
//        self.nowMoneyLabel.backgroundColor = [UIColor cyanColor];
        [self.showView addSubview:self.nowMoneyLabel];
        
        /** 判断失效的字段 */
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shopImageView.frame)+12, 70*SP_WIDTH, 190 *SP_WIDTH, 30*SP_HEIGHT)];
        self.captionLabel.font = [UIFont systemFontOfSize:13];
        self.captionLabel.hidden = YES;
        self.captionLabel.numberOfLines = 0;
        self.captionLabel.textColor = [UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
        [self.contentView addSubview:self.captionLabel];
        

        self.shopCount = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.bounds.size.width - 65, CGRectGetMaxY(self.colorLabel.frame)-5, 30*SP_WIDTH, 20*SP_HEIGHT)];
//        self.shopCount.backgroundColor = [UIColor redColor];
        self.shopCount.textAlignment = NSTextAlignmentRight;
        self.shopCount.font = [UIFont systemFontOfSize:12];
        [self.showView addSubview:self.shopCount];
        
        
        self.editView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shopImageView.frame)+12, CGRectGetMaxY(self.shopTitle.frame), SCREENWIDTH - CGRectGetMaxX(self.shopImageView.frame), 60*SP_HEIGHT)];
        self.editView.hidden = YES;
//        self.editView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.editView];
        
        
       //显示商品的价钱
        self.editViewMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 192*SP_WIDTH, 20*SP_HEIGHT)];
        self.editViewMoneyLabel.font = [UIFont systemFontOfSize:13];
        [self.editView addSubview:self.editViewMoneyLabel];
        
        //加减计数
        CrazyPurchaseQuantityView *qView = [[CrazyPurchaseQuantityView alloc]initWithImage:[UIImage imageNamed:@"crazy_mall_order_number_btn"]];
        qView.frame = CGRectMake(0, 23*SP_HEIGHT, 0, 0);
        self.mQuantityView = qView;
        qView.delegate = self;
        [self.editView addSubview:qView];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 判断是否是刷新。
 
 */
-(void)refreshShoppingCarUI:(BOOL)isSelect{

    if (isSelect) {
        [self.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_selected"] forState:UIControlStateNormal];
    }else
    {
        [self.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
    }
}
/**  编辑的时候展示什么样的页面 */
-(void)refreshCellShowViewOrEditView:(BOOL)isEdit{
    
    if (isEdit) {
        self.showView.hidden = NO;
        self.editView.hidden = YES;
    }else{
        self.showView.hidden = YES;
        self.editView.hidden = NO;
    }
}
/** 赋值 刷新 UI */
-(void)refreshUI:(ListModel *)model{
    if ([model.caption isEqualToString:@""]) {
    }else
    {
        self.invaildLabel.hidden = NO;
        self.selectBtn.hidden = YES;
        self.captionLabel.hidden = NO;
        self.colorLabel.hidden = YES;
        self.agoMoneylabel.hidden = YES;
        self.nowMoneyLabel.hidden = YES;
        self.shopCount.hidden = YES;
        self.editView.hidden = YES;
        self.captionLabel.text = model.caption;
        self.shopTitle.textColor = [UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *hostUrl = [user objectForKey:@"host"];
    
    self.shopTitle.text = model.goods_name;
    [self.shopImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,model.goods_imgurl]] placeholderImage:[UIImage imageNamed:@"defaultimg_11.png"]];
    
    
    self.nowMoneyLabel.text =    [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%@",model.goods_cash] andIntegral:[NSString stringWithFormat:@"%.0f",[model.goods_price floatValue]] withfreight:@"0" withWrap:NO];
    self.editViewMoneyLabel.text = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%@",model.goods_cash] andIntegral:[NSString stringWithFormat:@"%.0f",[model.goods_price floatValue]] withfreight:@"0" withWrap:NO];

    self.mQuantityView.mMaxNumber = model.nums;
    self.mQuantityView.mCurrentNumber = model.goods_nums ;
    
    self.shopCount.text = [NSString stringWithFormat:@"%@%d",@"x",model.goods_nums];
    NSMutableString *attributeKey = [NSMutableString stringWithCapacity:0];
    
    for ( int i = 0; i < model.goods_specarr.count; i++) {
        NSString *goodskey = ((goodsAttributeModel *)model.goods_specarr[i]).key;
        NSString *goodsValue = ((goodsAttributeModel *)model.goods_specarr[i]).value;
        
        if (i == model.goods_specarr.count-1) {
            [attributeKey appendFormat:@"%@:%@",goodskey,goodsValue];
        }else{
            [attributeKey appendFormat:@"%@:%@,",goodskey,goodsValue];
        }
    }
    self.colorLabel.text = attributeKey;
    NSLog(@"%@",model.available);
    NSLog(@"%@",model.goods_id);
    
    if ([model.available intValue]== -1) {
        self.mQuantityView.mAvailable = model.nums;
    }else
    {
        self.mQuantityView.mAvailable = [model.available intValue] ;
    }
    self.mQuantityView.mMaxRestrictionmNumber = model.restriction ;
    
    
//    
//    NSLog(@"cash   %@  price%@",model.cash,model.price);
//    if ([model.cash isEqualToString:@"0.00"]) {
//        self.nowMoneyLabel.text = [NSString stringWithFormat:@"%@ 积分",model.price];
//        self.editViewMoneyLabel.text = [NSString stringWithFormat:@"%@ 积分",model.price];
//
//    }else if ([model.price isEqualToString:@"0"] ){
//        self.nowMoneyLabel.text = [NSString stringWithFormat:@"￥%@",model.cash];
//        self.editViewMoneyLabel.text =  [NSString stringWithFormat:@"￥%@",model.cash];
//
//    }
//    else{
//        self.nowMoneyLabel.text = [NSString stringWithFormat:@"￥%@+%@积分",model.cash,model.price];
//        self.editViewMoneyLabel.text = [NSString stringWithFormat:@"￥%@+%@积分",model.cash,model.price];
//
//    }
    
//    self.agoMoneylabel.text = [NSString stringWithFormat:@"￥%@",model.market_cash];

    
//   self.agoMoneylabel.frame  = CGRectMake([self widthOfString:self.nowMoneyLabel.text withFont:12].width+10, self.agoMoneylabel.frame.origin.y, self.agoMoneylabel.bounds.size.width, self.agoMoneylabel.bounds.size.height);
    
//    self.colorLabel.frame = CGRectMake(self.colorLabel.frame.origin.x, [self widthOfString:self.shopTitle.text withFont:13].height - 30, self.colorLabel.bounds.size.width, self.colorLabel.bounds.size.height);
    
   
//    self.editViewMoneyLabel.text= [NSString stringWithFormat:@"￥ %@",model.cash];

}

-(CGSize)widthOfString:(NSString *)string withFont:(int)font {
  
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(3750, 9999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                           context:nil];
    
    CGSize size = textRect.size;
    
    return size;
}

/** 改变数量的代理方法 */
-(void)crazyPurchaseQuantityView:(CrazyPurchaseQuantityView *)qView currentNumber:(int)currentNumber
{
    //发送通知 访问服务器改变数量
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CrazyShoppingCartListCellViewChangeGoodsNumber" object:self];
}

-(void)CrazyShoppingCartListCellViewReload
{
    [self.mQuantityView CrazyPurchaseQuantityViewReload];
    self.listModel.goods_nums = self.mQuantityView.mCurrentNumber;
    
    //代理 刷新小计
//    if ([self.delegate respondsToSelector:@selector(crazyShoppingCartListCellViewchangeNumber:)]) {
//        [self.delegate crazyShoppingCartListCellViewchangeNumber:self];
//    }
}

@end
