//
//  ZXYFillerCell.m
//  test
//
//  Created by Rice on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYFillerCell.h"

@implementation ZXYFillerCell

- (void)awakeFromNib {
    // Initialization code
    self.saveModel = [ZXYFillerSaveModel shareInstance];
    self.slideControl = [[WLRangeSlider alloc] initWithFrame:CGRectMake(0, 25, 260 * SP_WIDTH, 22)];
    [self.slideControl addTarget:self action:@selector(slideValue:) forControlEvents:UIControlEventAllTouchEvents];
    self.slideControl.trackHighlightTintColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
    self.slideControl.trackColor = [UIColor clearColor];
    self.slideControl.thumbColor = [UIColor whiteColor];
    self.slideControl.cornorRadiusScale = 1;
    
    if ([self.saveModel.lastType integerValue] == 0) {
        self.slideControl.leftValue = [self.saveModel.leftValueAry[0] floatValue];
        self.slideControl.rightValue = [self.saveModel.rightValueAry[0] floatValue];
    }else if ([self.saveModel.lastType integerValue] == 1){
        self.slideControl.leftValue = [self.saveModel.leftValueAry[1] floatValue];
        self.slideControl.rightValue = [self.saveModel.rightValueAry[1] floatValue];
    }else{
        self.slideControl.leftValue = 0;
        self.slideControl.rightValue = 1;
    }
    
    UIImageView *slideBg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 34, 250 * SP_WIDTH, 1)];
    slideBg.image = [UIImage imageNamed:@"zxy_line"];
    [self.bgview addSubview:slideBg];
    [self.bgview addSubview:self.slideControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTyepCash) name:@"SelectCash" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTypeCoin) name:@"SelectCoin" object:nil];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 设置现金
 */
-(void)setTyepCash
{
    self.selectType = @"cash";
    self.slideControl.leftValue = [self.saveModel.leftValueAry[0] floatValue];
    self.slideControl.rightValue = [self.saveModel.rightValueAry[0] floatValue];
    [self.leftValue setText:[NSString stringWithFormat:@"¥%.0f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:self.slideControl.leftValue]]];
    if (self.slideControl.rightValue == 1.0) {
        [self.rightValue setText:@"不限"];
    }else{
        [self.rightValue setText:[NSString stringWithFormat:@"¥%.0f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:self.slideControl.rightValue]]];
    }
}
/**
 设置积分
 */
-(void)setTypeCoin
{
    self.selectType = @"coin";
    self.slideControl.leftValue = [self.saveModel.leftValueAry[1] floatValue];
    self.slideControl.rightValue = [self.saveModel.rightValueAry[1] floatValue];
    [self.leftValue setText:[NSString stringWithFormat:@"积分%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:self.slideControl.leftValue]]];
    if (self.slideControl.rightValue == 1.0) {
        [self.rightValue setText:@"不限"];
    }else{
        [self.rightValue setText:[NSString stringWithFormat:@"积分%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:self.slideControl.rightValue]]];
    }
}



-(void)slideValue:(id)target
{
    WLRangeSlider *slider = (WLRangeSlider *)target;
    NSLog(@"%f,%f",slider.leftValue,slider.rightValue);
    if ([self.selectType isEqual:@"cash"]) {
        [self.leftValue setText:[NSString stringWithFormat:@"¥%.0f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:slider.leftValue]]];
        if (slider.rightValue == 1.0) {
            [self.rightValue setText:@"不限"];
        }else{
            [self.rightValue setText:[NSString stringWithFormat:@"¥%.0f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:slider.rightValue]]];
        }
    }else{
        [self.leftValue setText:[NSString stringWithFormat:@"积分%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:slider.leftValue]]];
        if (slider.rightValue == 1.0) {
            [self.rightValue setText:@"不限"];
        }else{
            [self.rightValue setText:[NSString stringWithFormat:@"积分%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:slider.rightValue]]];
        }
    }

    if ([self.delegate respondsToSelector:@selector(updateValueForSliderWithLeftValue:andRightValue:)]) {
        [self.delegate updateValueForSliderWithLeftValue:slider.leftValue andRightValue:slider.rightValue];
    }
}


@end
