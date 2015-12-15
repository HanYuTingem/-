//
//  LoadEffectView.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/2.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadEffectViewDelegate <NSObject>

-(void)startupview;

@end

@interface LoadEffectView : UIView
@property (nonatomic, weak) id<LoadEffectViewDelegate>delegate;
- (void) initUI;
@end
