//
//  LYQOrderHeaderView.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议代理

@protocol OrderHeaderViewDelegate <NSObject>

//点击对应的类型的回调
- (void)selectBtnTypeTag:(NSInteger)typeTag;

@end
@interface LYQOrderHeaderView : UIView

//所有类型的按钮
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeBtnArray;
//点击对应类型的点击事件方法
- (IBAction)selectTypeBtnCliked:(id)sender;
//红色的线
@property (weak, nonatomic) IBOutlet UIImageView *redLineImageView;

@property (nonatomic,assign) id<OrderHeaderViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *underLineImage;


@end
