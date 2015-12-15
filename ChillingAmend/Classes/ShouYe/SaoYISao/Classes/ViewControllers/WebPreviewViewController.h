//
//  WebPreviewViewController.h
//  Saoyisao
//
//  Created by 宋鑫鑫 on 14-8-28.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryObject.h"
#import "JPCommonMacros.h"


@interface WebPreviewViewController : GCViewController

//扫描内容储存对象
@property (nonatomic, strong) HistoryObject *historyObject;

@end
