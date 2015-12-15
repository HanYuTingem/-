//
//  ZXYFillerCell.h
//  test
//
//  Created by Rice on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLRangeSlider.h"
#import "ZXYFillerSliderCalculate.h"
#import "ZXYFillerSaveModel.h"

@protocol UpdateValueDelegate <NSObject>

-(void)updateValueForSliderWithLeftValue:(CGFloat)leftValue andRightValue:(CGFloat)rightValue;

@end
@interface ZXYFillerCell : UITableViewCell
@property (assign, nonatomic) id <UpdateValueDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *leftValue;
@property (weak, nonatomic) IBOutlet UILabel *rightValue;
@property (strong, nonatomic) WLRangeSlider *slideControl;
/** cash 现金 coin 积分 */
@property (copy, nonatomic) NSString *selectType;

@property (strong, nonatomic) ZXYFillerSaveModel *saveModel;

-(void)setTypeCoin;

@end
