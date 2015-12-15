//
//  ZXYCategoryView.m
//  Chiliring
//
//  Created by Rice on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYCategoryView.h"

#define TableLineColor [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:223 / 255.0 alpha:1]

@implementation ZXYCategoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        catogeryModel = [ZXYCatogeryModel shareInstance];
        _categoryListTableview = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _categoryListTableview.delegate = self;
        _categoryListTableview.dataSource = self;
        _categoryListTableview.tableFooterView = [[UIView alloc] init];
        _categoryListTableview.bounces = NO;
        //        _categoryListTableview.separatorStyle = UITableViewCellSelectionStyleNone;
        if ([self.categoryListTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.categoryListTableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.categoryListTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.categoryListTableview setLayoutMargins:UIEdgeInsetsZero];
        }
        
        [self addSubview:_categoryListTableview];
    }
    return self;
}

-(void)setListFrame:(CGRect)frame
{
    NSInteger bgHeight = frame.size.height == 0?0:SCREENHEIGHT - 64 - 44;
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, bgHeight)];
    if (!_categoryListTableview) {
        _categoryListTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
    }
    [_categoryListTableview setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_categoryListTableview reloadData];
}

+(ZXYCategoryView *)shareInstance
{
    static ZXYCategoryView *categoryView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        categoryView = [[ZXYCategoryView alloc] init];
    });
    return categoryView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return catogeryModel.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - (13 + 8), 17 , 13, 8)];
        iv.image = [UIImage imageNamed:@"mall_list_ico_ok"];
        [cell.selectedBackgroundView addSubview:iv];
        
        UIView *viewUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
        viewUp.backgroundColor = TableLineColor;
        [cell.selectedBackgroundView addSubview:viewUp];
        UIView *viewDown = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height, SCREENWIDTH, 0.5)];
        viewDown.backgroundColor = TableLineColor;
        [cell.selectedBackgroundView addSubview:viewDown];
        
    }
    if (catogeryModel.dataAry.count!=0) {
        cell.textLabel.text = IfNullToString(catogeryModel.dataAry[indexPath.row][@"name"]);
        cell.textLabel.textColor = [UIColor colorWithRed:104/255. green:104/255. blue:104/255. alpha:1];
        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.costomDelegate didSelectedCategoryWithIndexRow:indexPath.row];
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
