//
//  ShoppingCartView.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/22.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ShoppingCartView.h"
#import "ShoppingCartCell.h"

#define TableViewScale 0.6

@interface ShoppingCartView() <UITableViewDataSource, UITableViewDelegate>




@end

@implementation ShoppingCartView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:RGBACOLOR(190, 190, 190, 0.5)];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * (1-TableViewScale))];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height * (1-TableViewScale), frame.size.width, frame.size.height * TableViewScale)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        
    }
    return self;
}

- (void)clickButton{
    [self removeFromSuperview];
}

- (void)setFrame:(CGRect)frame{
    
    frame.size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH - 49);
    
    [super setFrame:frame];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCartCell * cell = [ShoppingCartCell cellWithTableView:tableView];

    dishesList *model = _Data[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _Data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
