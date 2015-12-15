//
//  CrazyPurchaseQuantityView.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyPurchaseQuantityView.h"

@implementation CrazyPurchaseQuantityView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
      
        self.userInteractionEnabled = YES;
        
        self.mMaxNumber = MAXFLOAT;
        self.mMinNumber = 1;
        self.mAvailable = 0;
        self.mCurrentNumber = 1;
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(self.image.size.width, self.image.size.height);
//    self.backgroundColor = [UIColor magentaColor];
    
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lButton.frame = CGRectMake(0, 0, frame.size.width/3, frame.size.height);
    [lButton addTarget:self action:@selector(tapLButton) forControlEvents:UIControlEventTouchUpInside];
    [lButton setTitle:@"-" forState:UIControlStateNormal];
    [lButton setTitleColor:C8 forState:UIControlStateNormal];
    self.mReduceButton = lButton;
    [self addSubview:lButton];
    
    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.frame = CGRectMake(frame.size.width/3*2, 0, frame.size.width/3, frame.size.height);
    [rButton addTarget:self action:@selector(tapRButton) forControlEvents:UIControlEventTouchUpInside];
    [rButton setTitle:@"+" forState:UIControlStateNormal];
    [rButton setTitleColor:C8 forState:UIControlStateNormal];
    self.mAddButton = rButton;
    [self addSubview:rButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3, frame.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",self.mCurrentNumber];
    self.mShowLabel = label;
    label.textColor = C8;
    label.font = H6;
    [self addSubview:label];
    
    
    [super setFrame:frame];
}


-(void)setMCurrentNumber:(int)mCurrentNumber
{
    _mCurrentNumber = mCurrentNumber;
    if (self.mShowLabel) {
        self.mShowLabel.text = [NSString stringWithFormat:@"%d",mCurrentNumber];
    }
    
}

-(void)tapLButton
{
    if (self.mCurrentNumber == 1 || self.mCurrentNumber == 0) {
        return;
    }
    self.mType = CrazyPurchaseQuantityViewTypeRemove;
    
    if ([self.delegate respondsToSelector:@selector(crazyPurchaseQuantityView:currentNumber:)]) {
        [self.delegate crazyPurchaseQuantityView:self currentNumber:_mCurrentNumber];
    }

}

-(void)tapRButton
{
    NSLog(@"已经购买%d",self.mAvailable);
    //超出库存
    if (self.mCurrentNumber == self.mMaxNumber) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PurchaseQuantityViewNotification object:@{@"BIG":[NSNumber numberWithBool:YES],@"restrictionm":[NSNumber numberWithInt:0]}];
        return;
    }
    else if (self.mCurrentNumber  >= self.mAvailable){
        [[NSNotificationCenter defaultCenter] postNotificationName:PurchaseQuantityViewNotification object:@{@"restrictionm":[NSNumber numberWithInt:self.mMaxRestrictionmNumber],@"avaulable":[NSNumber numberWithInteger:self.mAvailable]}];
        return;
    }
   
    self.mType = CrazyPurchaseQuantityViewTypeAdd;
    
    if ([self.delegate respondsToSelector:@selector(crazyPurchaseQuantityView:currentNumber:)]) {
        [self.delegate crazyPurchaseQuantityView:self currentNumber:_mCurrentNumber];
    }

}
-(void)setMMaxRestrictionmNumber:(int)mMaxRestrictionmNumber
{
    if (mMaxRestrictionmNumber == 0) {
        mMaxRestrictionmNumber = MAXFLOAT;
    }
    _mMaxRestrictionmNumber = mMaxRestrictionmNumber;
}

-(void)CrazyPurchaseQuantityViewReload
{
    self.mCurrentNumber += self.mType;
}

@end
