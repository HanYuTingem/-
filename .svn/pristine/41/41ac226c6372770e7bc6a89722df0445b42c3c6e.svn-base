//
//  ZXYAdView.m
//  Chiliring
//
//  Created by Rice on 14-9-5.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYAdView.h"

@implementation ZXYAdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ZXYAdView" owner:self options:nil][0];
        [self setFrame:frame];
    }
    return self;
}

+(ZXYAdView *)shareView
{
    
    static ZXYAdView *shareInstanceView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstanceView = [[self alloc] init];
    });
    shareInstanceView.alpha = 1;
    return shareInstanceView;
}

- (IBAction)closeAd:(id)sender {
    self.alpha = 0;
}

@end
