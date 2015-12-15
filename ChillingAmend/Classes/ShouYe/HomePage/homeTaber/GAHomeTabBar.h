//
//  GAHomeTabBar.h
//  GrapeAgency
//
//  Created by pipixia on 13-12-24.
//  Copyright (c) 2013年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTXibView.h"

@protocol GAHomeTabBarDelegate;

@interface GAHomeTabBar : ITTXibView

@property (retain, nonatomic) IBOutlet UIButton *homePageButton; // 首页
@property (retain, nonatomic) IBOutlet UIButton *myGrapeAgencyButton; // 幸运乐园
@property (retain, nonatomic) IBOutlet UIButton *recommandButton; // 辣椒商城
@property (retain, nonatomic) IBOutlet UIButton *knowledgeButton; // 椒点活动
@property (retain, nonatomic) IBOutlet UIButton *setButton; // 我的

@property (retain, nonatomic) IBOutlet UIImageView *lineImageView;
@property (assign, nonatomic) id<GAHomeTabBarDelegate>delegate;

- (IBAction)onHomePageButtonClicked:(id)sender;
- (IBAction)onMyGrapeAgencyButtonClicked:(id)sender;
- (IBAction)onRecommandButtonClicked:(id)sender;
- (IBAction)onKnowledgeButtonClicked:(id)sender;
- (IBAction)onSetButtonClicked:(id)sender;

- (void)selectTabBarAtIndex:(int)index;

@end

@protocol GAHomeTabBarDelegate <NSObject>

- (void)homeTabBar:(GAHomeTabBar*)homeTabBar didSelectTabAtIndex:(int)index;

@end



