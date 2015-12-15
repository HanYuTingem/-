//
//  ZXYSearchHistroyView.m
//  MarketManage
//
//  Created by Rice on 15/1/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYSearchHistroyView.h"

@implementation ZXYSearchHistroyView
/*
 各种初始化
 */
+(ZXYSearchHistroyView *)shanreInstance
{
    static ZXYSearchHistroyView *histroyView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        histroyView = [[ZXYSearchHistroyView alloc] init];
        histroyView.searchResultTableview = [[UITableView alloc] init];
        histroyView.searchResultTableview.delegate = histroyView;
        histroyView.searchResultTableview.dataSource = histroyView;
        histroyView.searchResultTableview.scrollEnabled = NO;
        [histroyView addSubview:histroyView.searchResultTableview];
        histroyView.histroyAry = [[NSMutableArray alloc] init];
        histroyView.searchResultTableview.backgroundColor = [UIColor clearColor];
        histroyView.searchResultTableview.tableFooterView = [[UIView alloc] init];
    });
    return histroyView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.histroyAry.count != 0) {
        return self.histroyAry.count + 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"histroy"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"histroy"];
    }
    if (indexPath.row == self.histroyAry.count) {
        cell.textLabel.text = @"清空历史记录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        cell.textLabel.text = self.histroyAry[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.histroyAry.count) {
        [MarketAPI clearSearchHistroy];
        [self.histroyAry removeAllObjects];
        [self.histroydelegate selectHistroyContent:@""];
    }else {
        [self.histroydelegate selectHistroyContent:self.histroyAry[indexPath.row]];
    }
}

-(void)setLayout
{
    if ([self.searchResultTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.searchResultTableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.searchResultTableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.searchResultTableview setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.searchResultTableview setFrame:CGRectMake(0, 0, self.frame.size.width, self.histroyAry.count * 44 + 44)];
    [self.searchResultTableview reloadData];
}

-(void)reloadData
{
    if ([self.searchResultTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.searchResultTableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.searchResultTableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.searchResultTableview setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.searchResultTableview setFrame:CGRectMake(0, 0, self.frame.size.width, self.histroyAry.count * 44 + 44)];
    [self.searchResultTableview reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
