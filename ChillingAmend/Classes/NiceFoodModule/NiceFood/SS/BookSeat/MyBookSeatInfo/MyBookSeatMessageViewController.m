//
//  MyBookSeatMessageViewController.m
//  QQList
//
//  Created by sunsu on 15/7/1.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MyBookSeatMessageViewController.h"
#import "MessageFirstCell.h"
#import "MessageSecondCell.h"

#import "ChangePhoneNumViewController.h"

@interface MyBookSeatMessageViewController ()<UITableViewDataSource,UITableViewDelegate,MessageSecondCellDelegate>
{
    UITableView *_tableView;//订座列表
    BOOL         _isUp;//判断按钮上下隐藏
}

@end

@implementation MyBookSeatMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleButton.hidden = NO;
    [titleButton setTitle:@"我的订座信息" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self createTableView];
}


- (void)createTableView
{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate         = self;
        _tableView.dataSource       = self;
        _tableView.scrollEnabled    = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *cellS = @"cellS";
        [_tableView registerClass:[MessageSecondCell class] forCellReuseIdentifier:cellS];
        [self.view addSubview:_tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0)
        {
            static NSString *cellF = @"cellF";
            [_tableView registerClass:[MessageFirstCell class] forCellReuseIdentifier:cellF];
            MessageFirstCell *cell = [MessageFirstCell cellWithTableView:_tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            cell.LVLevel.text = [NSString stringWithFormat:@"LV%@",self.level];
            //==============控制星星的数量==========
            int level = [self.level intValue];
            if (level >= 5)
            {
                level = 5;
            }else if (level <= 0)
            {
                level = 1;
            }
            float bili = level / 5.0;
            UIImageView *backStar = [[UIImageView alloc] initWithFrame:CGRectMake(108, 18, 94, 14)];
            UIImageView *fontStar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 94, 14)];
            backStar.image        = [UIImage imageNamed:@"lb_0001_Star_h"];
            fontStar.image        = [UIImage imageNamed:@"lb_0000_Star_y"];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(116, 33, 94, 14)];
            view.frame = CGRectMake(0, 0, 94*bili, 15);
            view.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:backStar];
            [backStar addSubview:view];
            [view addSubview:fontStar];
            view.clipsToBounds = YES;
    
            [cell.downBtn addTarget:self
                             action:@selector(downBtnClick)
                   forControlEvents:UIControlEventTouchUpInside];
            cell.clipsToBounds = YES;
            if (_isUp){
                cell.downBtn.hidden = YES;
            }else {
                cell.downBtn.hidden = NO;
            }
    
            [cell.upBtn addTarget:self
                           action:@selector(upBtnClick)
                 forControlEvents:UIControlEventTouchUpInside];
            return cell;
    
        }
    if (indexPath.row == 1) {
        MessageSecondCell *cell = [MessageSecondCell cellWithTableView:_tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell reshCellWithPhone:self.phoneNum];
    return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0)
        {
//            if (_isUp){
//                return 290;
//            }else {
//                return 110;
//            }
            return 0;
        }
    
        if (indexPath.row == 1)  {
            return 90;
        }
    return 0;
}

#pragma  mark - 编辑电话号码
- (void)editPhoneNumClick
{
//    ChangePhoneNumViewController *changeVC =  [[ChangePhoneNumViewController alloc]init];
//    changeVC.phonenum  =  USER_NAME;
//    [self.navigationController pushViewController:changeVC animated:YES];
}
#pragma mark - 上下箭头的点击事件
- (void)downBtnClick
{
    _isUp = YES;
    _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 390);
    [_tableView reloadData];
}

- (void)upBtnClick
{
    _isUp = NO;
    _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 210);
    [_tableView reloadData];
}



@end
