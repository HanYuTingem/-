//
//  SSDumplingView.h
//  LaoYiLao
//
//  Created by sunsu on 15/10/30.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMyDumplingModel.h"
#import "SSBaoJiaoZiBtnView.h"
#import "SSInfoDumpView.h"


@interface SSDumplingView : UIView

@property (nonatomic, strong) SSInfoDumpView * infoDumplingView;//饺子信息页面
@property (nonatomic, strong) SSBaoJiaoZiBtnView  * baoJzView;//底部我包的饺子button
@property (nonatomic, strong) SSMyDumplingModel * myDumModel;
//-(void)initUI;
@end
