//
//  GAHomeTabBar.m
//  GrapeAgency
//
//  Created by pipixia on 13-12-24.
//  Copyright (c) 2013年 pipixia. All rights reserved.
//

#import "GAHomeTabBar.h"
#import "UIView+ITTAdditions.h"

@implementation GAHomeTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //kkUserCenterId
        
    }
    return self;
}

- (void)selectTabBarAtIndex:(int)index
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineImageView.centerX = 32+64*index;
    }];
    switch (index) {
        case 0:
        {
            self.homePageButton.enabled = NO;
            self.myGrapeAgencyButton.enabled = YES;
            self.recommandButton.enabled = YES;
            self.knowledgeButton.enabled = YES;
            self.setButton.enabled = YES;
        }
            break;
        case 1:
        {
            self.homePageButton.enabled = YES;
            self.myGrapeAgencyButton.enabled = NO;
            self.recommandButton.enabled = YES;
            self.knowledgeButton.enabled = YES;
            self.setButton.enabled = YES;
        }
            break;
        case 2:
        {
            self.homePageButton.enabled = YES;
            self.myGrapeAgencyButton.enabled = YES;
            self.recommandButton.enabled = NO;
            self.knowledgeButton.enabled = YES;
            self.setButton.enabled = YES;
        }
            break;
        case 3:
        {
            self.homePageButton.enabled = YES;
            self.myGrapeAgencyButton.enabled = YES;
            self.recommandButton.enabled = YES;
            self.knowledgeButton.enabled = NO;
            self.setButton.enabled = YES;
        }
            break;
        case 4:
        {
            self.homePageButton.enabled = YES;
            self.myGrapeAgencyButton.enabled = YES;
            self.recommandButton.enabled = YES;
            self.knowledgeButton.enabled = YES;
            self.setButton.enabled = NO;
        }
            break;
        default:
            break;
    }
}


- (void)notifyDelegateWithIndex:(int)index
{
    if(_delegate && [_delegate respondsToSelector:@selector(homeTabBar:didSelectTabAtIndex:)]){
        [_delegate homeTabBar:self didSelectTabAtIndex:index];
    }
}

- (IBAction)onHomePageButtonClicked:(id)sender
{
    [self selectTabBarAtIndex:0];
    [self notifyDelegateWithIndex:0];
}

- (IBAction)onMyGrapeAgencyButtonClicked:(id)sender
{
    [self selectTabBarAtIndex:1];
    [self notifyDelegateWithIndex:1];
}

- (IBAction)onRecommandButtonClicked:(id)sender
{
    [self selectTabBarAtIndex:2];
    [self notifyDelegateWithIndex:2];
}

- (IBAction)onKnowledgeButtonClicked:(id)sender
{
    [self selectTabBarAtIndex:3];
    [self notifyDelegateWithIndex:3];
}

- (IBAction)onSetButtonClicked:(id)sender
{
    [self selectTabBarAtIndex:4];
    [self notifyDelegateWithIndex:4];
}

@end



