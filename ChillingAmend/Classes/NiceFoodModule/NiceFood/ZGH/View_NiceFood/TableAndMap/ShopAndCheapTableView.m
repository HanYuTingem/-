//
//  ShopAndCheapTableView.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/23.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ShopAndCheapTableView.h"
#import "ShopListCell.h"

@interface ShopAndCheapTableView()

@end

@implementation ShopAndCheapTableView


//初始化tableView的封装
- (ShopAndCheapTableView *)SetTableViewWithFrame:(CGRect)frame{

    ShopAndCheapTableView * view = [[ShopAndCheapTableView alloc] initWithFrame:frame];
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopMenuH , SCREEN_WIDTH, frame.size.height - TopMenuH)];
    
    [view addSubview:_listTableView];
    view.clipsToBounds = YES;

    
    return view;
}




- (void)setFrame:(CGRect)frame
{
//    frame = CGRectMake(0, TopMenuH, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationH - TopMenuH -49);
    [super setFrame:frame];
}

@end
