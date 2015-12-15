//
//  CJParameterTableView.m
//  图文详情页
//
//  Created by 赵春景 on 15/8/2.
//  Copyright (c) 2015年 赵春景. All rights reserved.
//

#import "CJParameterTableView.h"
#import "CJParameterTableViewCell.h"
#import "CJParameterModel.h"

/** cell的标识符 */
static NSString *ID = @"parameterCell";

@interface CJParameterTableView ()<UITableViewDataSource,UITableViewDelegate>

{
    /** 接收外界传入的数组数据 */
    NSMutableArray *_arrayM;
}

@end

@implementation CJParameterTableView

- (instancetype)initWithFrame:(CGRect)frame andDataDict:(NSDictionary *)dataDict{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1];
        
        NSLog(@"dataDict   ------======init --- %@",dataDict);
        _arrayM = [NSMutableArray array];
        //解析数据
        [self setDataWithDataDict:dataDict];
        
        //添加TableView
        [self makeTableViewWithFrame:frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1];
        _arrayM = [NSMutableArray array];
        
        //添加TableView
        [self makeTableViewWithFrame:frame];
    }
    return self;
}


/**
 * 解析数据
 */
- (void)setDataWithDataDict:(NSDictionary *)dataDict
{
    for (NSDictionary *dic in dataDict[@"format"]) {
        CJParameterModel *model = [CJParameterModel modelWithDict:dic];
        [_arrayM addObject:model];
    }
    [_tableView reloadData];
    
}

/**
 * 添加TableView
 */
- (void)makeTableViewWithFrame:(CGRect)frame
{
    CGFloat Y = 0 * SP_HEIGHT;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y, frame.size.width, frame.size.height - Y)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerNib:[UINib nibWithNibName:@"CJParameterTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self addSubview:_tableView];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return 7;
    return _arrayM.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CJParameterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CJParameterModel *model = _arrayM[indexPath.row];
    cell.titleLabel.text = model.attr_name;
    cell.titleName.text = model.value_name;
    tableView.tableHeaderView = [self makeTableHeaderView];
    cell.lineH.constant = 0.5;
    return cell;
}

- (UIView *)makeTableHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1];
    return view;
}


- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
}

@end
