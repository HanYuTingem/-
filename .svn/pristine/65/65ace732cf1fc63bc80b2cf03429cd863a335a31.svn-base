//
//  CommentTableViewController.m
//  MyNiceFood
//
//  Created by sunsu on 15/7/16.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "CommentTableViewController.h"
#import "StoreCommentListCell.h"
@interface CommentTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  * _commentTableView;
}
@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self createCommentTableView];
}
-(void)createCommentTableView{
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    [self.view addSubview:_commentTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * identifier = @"StoreCommentListCell";
    [_commentTableView registerClass:[StoreCommentListCell class] forCellReuseIdentifier:identifier];
    
    StoreCommentListCell * cell = [StoreCommentListCell cellWithTableView:_commentTableView];
    //cell.commentModel = ;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
