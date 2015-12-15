//
//  LSYVirtualGoodsTableViewCell.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYVirtualGoodsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MarketAPI.h"
@interface LSYVirtualGoodsTableViewCell ()


/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsIMG;
/** 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *goods_Name;
/** 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_Price;
/** 购买的商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *goodsNumData;



@end

@implementation LSYVirtualGoodsTableViewCell

//减法
- (IBAction)subtraction:(id)sender
{
    if (self.count>1) {
        self.count--;
        [self updateLabel];
    }

}
//加法
- (IBAction)add:(id)sender
{
    if (self.count<99) {
        if(self.goods.restriction > 0 && self.goods.available >0 &&self.count>=self.goods.available){
            [self.delegate goodsNumChange:10000 + self.goods.restriction];
            
        }else if(self.goods.nums <= self.count){
            
            [self.delegate goodsNumChange:1000];

        }else{
            self.count++;
            [self updateLabel];
        }
       
    }
   
}
-(void)updateLabel
{

    if ([self.isSeckilling integerValue] > 0) {//秒杀 购买数量固定为1
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsNumChange:)]) {
            [self.delegate goodsNumChange:1];
        }
        self.numLabel.text=[NSString stringWithFormat:@"%d",1];
        self.goodsNumData.text = [NSString stringWithFormat:@"x%d",1];
    }else if([self.isHaveAdd integerValue]
             != 1 ){//无地址
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsNumChange:)]) {
            [self.delegate goodsNumChange:0];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsNumChange:)]) {
            [self.delegate goodsNumChange:self.count];
        }   
        self.numLabel.text=[NSString stringWithFormat:@"%d",self.count];
        self.goodsNumData.text = [NSString stringWithFormat:@"x%d",self.count];
    }
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setGoods:(LSYGoodsInfo *)goods
{
    [self addGestureRecognizer];

    
    _goods=goods;
    self.goods_Name.text=_goods.name;
    if ([self.isSeckilling integerValue] == 0) {//不秒杀的价格
        self.goods_Price.text=[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%.2f",_goods.goods_cashNew] andIntegral:[NSString stringWithFormat:@"%.0f",_goods.price]  withfreight:@"0"  withWrap:NO];
    }else{//秒杀价格
        self.goods_Price.text = [NSString stringWithFormat:@"￥%@元",_goods.ms_price];
    }
    [self.goodsIMG setImageWithURL:
    [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_goods.host,_goods._img_url]] placeholderImage:[UIImage imageNamed:@"defaultimg_9.png"]];
}
- (void)addGestureRecognizer
{
    UITapGestureRecognizer * tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImageScrollView:)];
    tapSingle.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapSingle];
    
}

- (void)TapImageScrollView:(UITapGestureRecognizer*)tap
{
    [self.delegate didSecectGoodsContentView];

}
-(void)setCount:(int)count
{
    if ([self.isSeckilling integerValue] > 0) {//秒杀
        _count=1;
        self.numLabel.text=[NSString stringWithFormat:@"%d",1];
        self.goodsNumData.text = [NSString stringWithFormat:@"x%d",1];
    }else if (self.goods.type == 2) {//虚拟
        _count=count;
        self.numLabel.text=[NSString stringWithFormat:@"%d",self.count];
        self.goodsNumData.text = [NSString stringWithFormat:@"x%d",self.count];
        return;
    }else if([self.isHaveAdd integerValue] == 0)                                                                                                            {//没地址且不包邮
        return;
    }else{
    _count=count;
        self.numLabel.text=[NSString stringWithFormat:@"%d",self.count];
        self.goodsNumData.text = [NSString stringWithFormat:@"x%d",self.count];
    }
}
@end
