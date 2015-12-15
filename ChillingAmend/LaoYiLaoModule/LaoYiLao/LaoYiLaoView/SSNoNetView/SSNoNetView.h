//
//  SSNoNetView.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/5.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSNoNetViewDelegate <NSObject>
-(void)refreshNoNetView;
@end


@interface SSNoNetView : UIView

@property (nonatomic, weak) id<SSNoNetViewDelegate>delegate;

@end
