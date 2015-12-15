//
//  ZXYFillerSliderCalculate.m
//  MarketManage
//
//  Created by Rice on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYFillerSliderCalculate.h"

@implementation ZXYFillerSliderCalculate
// 现金刻度
// 0              100     200     500 1000-∞+
// |___|___|___|___|___|___|___|___|___|

+(float)calculateSliderForCashWithValue:(float)slideValue
{
    NSLog(@"%f",slideValue);
    float result = 0.00;
    if (slideValue * 100 <= 50) {
        result = 200 * slideValue;
    }else if (slideValue * 100 <= 70){
        result = (100 + 500 * (slideValue - 0.50));
    }else if (slideValue * 10 <= 9){
        result = (200 + 1500 * (slideValue - 0.70));
    }else{
        result = (500 + 5000 * (slideValue-0.90));
    }
    NSLog(@"%f",result);
    return result;
}


//积分刻度
// 0  100     1k      2k      10k     100k-∞+
// |___|___|___|___|___|___|___|___|___|

+(int)calculateSliderForCoinWithValue:(float)slideValue
{
    NSLog(@"%f",slideValue);
    int result = 0;
    if (slideValue * 10 <= 2) {
        result = 500 * slideValue;
    }else if (slideValue * 10 <= 4){
        result = (100 + 4500 * (slideValue - 0.2));
    }else if (slideValue * 10 <= 6){
        result = (1000 + 5000 * (slideValue - 0.4));
    }else if (slideValue * 10 <= 8){
        result = (2000 + 40000 * (slideValue - 0.6));
    }else{
        result = (10000 + 45000 * (slideValue * 10 - 8));
    }
    NSLog(@"%d",result);
    return result;
}

@end
