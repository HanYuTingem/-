//  编辑详细资料（邮箱，昵称等）
//  EditDetailMessageViewController.h
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "GCViewController.h"

@protocol EditDelegate <NSObject>
@required
- (void)messageChanged:(NSInteger)tag;
- (void)messageChangedContent:(NSString*)content andTag:(NSInteger)tag;
@end

@interface EditDetailMessageViewController : GCViewController

@property (nonatomic, strong) id <EditDelegate> editDelegate; // 代理
@property (assign, nonatomic) NSInteger btnTag; // button标记
@end
