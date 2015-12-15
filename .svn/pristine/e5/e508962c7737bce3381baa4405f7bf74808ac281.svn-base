//
//  ListCell.h
//  animationView
//
//  Created by Rice on 14/12/3.
//  Copyright (c) 2014年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketAPI.h"
#import "UIImageView+WebCache.h"

@interface ListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView      *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel     *leftTitle;
/** 左边的钱数 */
@property (weak, nonatomic) IBOutlet UILabel     *leftCost;
@property (weak, nonatomic) IBOutlet UILabel     *leftConverCount;
@property (weak, nonatomic) IBOutlet UIButton    *leftSelectBtn;

@property (weak, nonatomic) IBOutlet UIView      *rightView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel     *rightTitle;
/** 右边的钱数 */
@property (weak, nonatomic) IBOutlet UILabel     *rightCost;
@property (weak, nonatomic) IBOutlet UILabel     *rightConverCount;
@property (weak, nonatomic) IBOutlet UIButton    *rightSelectBtn;
/** 左侧图片的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBigImageH;
/** 右侧图片的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBigImageH;
/** 左边已买文字的Y */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBuyTitleH;
/** 右边已买文字的Y */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBuyTitleH;
/** 右边虚线的Y */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelY;
/** 左边虚线的Y */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLabelY;
/** 左边虚线 */
@property (weak, nonatomic) IBOutlet UILabel *leftLineLabel;
/** 左边虚线 */
@property (weak, nonatomic) IBOutlet UILabel *rightLineLabel;



@property (copy, nonatomic) NSString *imageHostUrl;
-(void)setCellLeftValue:(NSDictionary *)dataDic;
-(void)setCellRightValue:(NSDictionary *)dataDic;

@end
