//
//  DHConfirmOrderCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHConfirmOrderCell.h"
#import "UIImageView+WebCache.h"
#import "ListModel.h"
@implementation DHConfirmOrderCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 75, 75)];
        [self.contentView addSubview:self.shopImageView];
        
        self.shopAllNum = [[UILabel alloc]init];
        self.view = [[UIView alloc] initWithFrame:CGRectMake(100, 10, 300, 100)];
        [self.contentView addSubview:self.view];
        
        self.shopName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        self.shopName.font = [UIFont systemFontOfSize:12];
        self.shopName.numberOfLines = 0;
        self.shopName.textColor = [UIColor blackColor];
        [self.view addSubview:self.shopName];
        
        self.colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 150, 20)];
        [self.view addSubview:self.colorLabel];
        self.colorLabel.textColor= [UIColor lightGrayColor];
        self.colorLabel.font = [UIFont systemFontOfSize:12];
        
        
        self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
        self.nowLabel.textColor = [UIColor redColor];
        self.nowLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:self.nowLabel];
        
        self.agoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 80, 20)];
        self.agoLabel.textColor = [UIColor lightGrayColor];
        [self.view addSubview:self.agoLabel];
        self.agoLabel.font = [UIFont systemFontOfSize:12];
    
        self.shopNum = [[UILabel alloc] initWithFrame:CGRectMake(190*SP_WIDTH, 60, 30, 20)];
        [self.view addSubview:self.shopNum];
//        self.shopNum.backgroundColor = [UIColor redColor];
        self.shopNum.font = [UIFont systemFontOfSize:12];
        
        
        
        UIView*line = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        
        self.wayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 80, 20)];
        [self.contentView addSubview:self.wayLabel];
        self.wayLabel.text = @"配送方式";
        self.wayLabel.font = [UIFont systemFontOfSize:15];
        
        
        
        self.expressBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 90, 110, 80, 20)];
        self.expressBtnLabel.textAlignment = NSTextAlignmentRight;
        self.expressBtnLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.expressBtnLabel];
        self.ExpressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ExpressBtn.frame = self.expressBtnLabel.bounds;
        [self.expressBtnLabel addSubview:self.ExpressBtn];
        
        UIView*twoLine = [[UIView alloc] initWithFrame:CGRectMake(20, 140, SCREENWIDTH, .5)];
        twoLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:twoLine];
        
        self.InvoiceInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 80, 20)];
        [self.contentView addSubview:self.InvoiceInfoLabel];
        self.InvoiceInfoLabel.text = @"发票信息";
        self.InvoiceInfoLabel.font = [UIFont systemFontOfSize:14];
        
        
        self.invoicingLableText = [[UILabel alloc] initWithFrame:CGRectMake( 80, 150, SCREENWIDTH - 90, 20)];
        self.invoicingLableText.userInteractionEnabled = YES;
        self.invoicingLableText.textAlignment = NSTextAlignmentRight;
//        self.invoicingLableText.backgroundColor = [UIColor redColor];
        self.invoicingLableText.font = [UIFont systemFontOfSize:12];

        [self.contentView addSubview:self.invoicingLableText];
        
        self.InvoicingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.InvoicingBtn.frame = self.invoicingLableText.bounds;
        [self.invoicingLableText addSubview:self.InvoicingBtn];
        
        UIView*threeLine = [[UIView alloc] initWithFrame:CGRectMake(20, 180, SCREENWIDTH, .5)];
        threeLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:threeLine];
        
        self.Message = [[UITextView alloc] initWithFrame:CGRectMake(10, 185, SCREENWIDTH, 40)];
//        self.Message.placeholder = @"留言：限50字以内";
        self.Message.font = [UIFont systemFontOfSize:14];
        self.Message.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.Message];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 120, 20)];
        self.messageLabel.textColor = [UIColor lightGrayColor];
        self.messageLabel.text = @"留言：限50字以内";
        
        self.messageLabel.font = [UIFont systemFontOfSize:13];
        [self.Message addSubview:self.messageLabel];
        
        
        
    }
    return self;
}
-(void)refreshUI:(NSArray *)arr{
    NSLog(@"%@",arr);

    if (arr.count>1) {
        for (int i = 0; i < arr.count; i++) {
            ListModel *model = arr[i];
            NSLog(@"%@",model.goods_name);
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10+85*i, 10, 75, 75)];
         
            [self.contentView addSubview:img];

            [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageViewUrl,model.goods_imgurl]] placeholderImage:[UIImage imageNamed:@""]];
            self.shopAllNum.frame = CGRectMake(SCREENWIDTH-80, 50, 80, 20);
            self.shopAllNum.font = [UIFont systemFontOfSize:13];
            self.shopAllNum.text = [NSString stringWithFormat:@"商品共%ld件",arr.count];
            [self.contentView addSubview:self.shopAllNum];
        }
    }else{
        ListModel *model = arr[0];
        
        [self.shopImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageViewUrl,model.goods_imgurl]] placeholderImage:[UIImage imageNamed:@""]];
        self.shopName.text = model.goods_name;
        self.colorLabel.text = @"颜色：黄色";
        self.nowLabel.text = model.cash;
        self.shopNum.text = [NSString stringWithFormat:@"x%d",model.goods_nums];
    }
}
-(void)refreshUIExpress:(NSDictionary *)dic{
    
    if ([dic[@"freight"] integerValue] <= 0 ) {
        self.expressBtnLabel.text = [NSString stringWithFormat:@"包邮"];
    }else
    {
        self.expressBtnLabel.text = [NSString stringWithFormat:@"快递%ld元 >",[dic[@"freight"] integerValue]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
