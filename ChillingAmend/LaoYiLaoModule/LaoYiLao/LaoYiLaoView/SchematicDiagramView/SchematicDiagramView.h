//
//  SchematicDiagramView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/4.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SchematicDiagramView : UIView


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, copy) void(^FirstBtnClickedBlock)(void);

@end
