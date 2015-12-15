//
//  BuGeiLiView.m
//  dreamWorks
//
//  Created by dreamRen on 13-7-26.
//  Copyright (c) 2013年 dreamRen. All rights reserved.
//

#import "BuGeiLiView.h"

@implementation BuGeiLiView

-(void)finishThisView{
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.0];
                         logoImageView.alpha=0.0;
                         infoLabel.alpha=0.0;
                     } completion:^(BOOL finished) {
                         NSUserDefaults *tInfo=[NSUserDefaults standardUserDefaults];
                         [tInfo removeObjectForKey:@"bugeili"];
                         [tInfo synchronize];
                         [self removeFromSuperview];
                     }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.0];
        
        logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-67)/2, 90, 67, 67)];
        logoImageView.image=[UIImage imageNamed:@"bugeili.png"];
        logoImageView.alpha=0.0;
        [self addSubview:logoImageView];
        
        infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, logoImageView.frame.origin.y+logoImageView.frame.size.height+20, self.frame.size.width, 50)];
        infoLabel.backgroundColor=[UIColor clearColor];
        infoLabel.font=[UIFont systemFontOfSize:17];
        infoLabel.textColor=[UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1.0];
        infoLabel.textAlignment= NSTextAlignmentCenter;//UITextAlignmentCenter;
        infoLabel.text=@"亲~您的网络不给力啊~";
        infoLabel.alpha=0.0;
        [self addSubview:infoLabel];
        
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.5];
                             logoImageView.alpha=1.0;
                             infoLabel.alpha=1.0;
                         } completion:^(BOOL finished) {
                             
                         }];
        [self performSelector:@selector(finishThisView) withObject:nil afterDelay:1.2];
    }
    return self;
}



@end
