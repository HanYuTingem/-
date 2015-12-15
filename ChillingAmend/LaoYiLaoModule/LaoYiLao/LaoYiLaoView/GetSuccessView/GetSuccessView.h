//
//  GetSuccessView.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/6.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  GetSuccessViewDelegate <NSObject>

- (void) shareRightNow:(UIButton *)btn;
- (void) jixuLao;
- (void) lookMyWallet;

@end

@interface GetSuccessView : UIView
@property (nonatomic, weak) id<GetSuccessViewDelegate>delegate;
@end
