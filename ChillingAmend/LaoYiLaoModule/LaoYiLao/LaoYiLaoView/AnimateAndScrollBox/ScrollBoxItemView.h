//
//  ScrollBoxItemView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DumplingInforListResultModel.h"
@interface ScrollBoxItemView : UIView
@property (strong, nonatomic) IBOutlet UILabel *titleContentlab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *numberLab;

@property (nonatomic, strong) DumplingInforListResultModel *model;
@end
