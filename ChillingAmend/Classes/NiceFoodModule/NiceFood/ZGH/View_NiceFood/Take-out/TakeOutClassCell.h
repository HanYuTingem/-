//
//  TakeOutClassCell.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/20.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "takeOutList.h"

@interface TakeOutClassCell : UITableViewCell

@property (nonatomic, strong) UILabel *lable;   //商品类别
@property (nonatomic, copy) NSString *index;  //选择数量
@property (nonatomic, strong) UIButton *number; //红色圆点
@property (nonatomic, strong) takeOutList *model; 

+ (TakeOutClassCell *)cellWithTableView:(UITableView *)tabelView;


@end
