//
//  SSInfoDumpView.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/30.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSMyDumplingModel.h"
#import "FunctionBtn.h"

@protocol SSInfoDumpViewDelegate  <NSObject>

- (void) ClickXianjin;
- (void) ClickYouhuiquan;
- (void) ClickHeka;
- (void) ClickXuanyaoyixia:(UIButton *)btn;

@end


@interface SSInfoDumpView : UIView

@property (nonatomic, strong) SSMyDumplingModel * myDumModel;
@property (nonatomic, weak)id<SSInfoDumpViewDelegate>delegate;
@end
