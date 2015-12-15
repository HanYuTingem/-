//
//  STScratchView.h
//  STScratchView
//
//  Created by Sebastien Thiebaud on 12/17/12.
//  Copyright (c) 2012 Sebastien Thiebaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol STScratchViewDelegate <NSObject>
@optional;
-(void)EndScratch;
-(void)StartScratch;
@end
@interface STScratchView : UIView
{
    CGPoint previousTouchLocation;
    CGPoint currentTouchLocation;
    
    CGImageRef hideImage;
    CGImageRef scratchImage;

	CGContextRef contextMask;
}

@property (nonatomic, assign) float percentAccomplishment;
@property (nonatomic, retain)id<STScratchViewDelegate>delegate;
@property (nonatomic, assign) float sizeBrush;
@property (nonatomic, assign)CGRect rect;
@property (nonatomic, assign)int scrapeInt;
@property (nonatomic, assign)BOOL scrapeBool, StartBool;
@property (nonatomic, strong) UIView *hideView;

- (void)setHideView:(UIView *)hideView;

@end
