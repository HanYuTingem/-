//
//  LYQGoodsEvalutionViewCell.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
#import "UIImageView+WebCache.h"


#import "ZXYOrderDetailModel.h"


@interface LYQGoodsEvalutionViewCell : UITableViewCell
<UITextViewDelegate>
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
//商品名称
@property (weak, nonatomic) IBOutlet MyUILabel *goodsNameLabel;
//商品评价
@property (weak, nonatomic) IBOutlet UITextView *evalutionTextView;
//输入最大的数字
@property (weak, nonatomic) IBOutlet UILabel *maxNumberLabel;

@property (nonatomic,assign) NSInteger   Index;
//提示的文字
@property (weak, nonatomic) IBOutlet UILabel *placeHoderLabel;

//获取数据
- (void)getOrderModel:(ZXYOrderDetailModel*)mdeol content:(NSString*)content num:(NSString*)numstr;





@end
