//
//  BookSeatDetailViewController.m
//  QQList
//
//  Created by sunsu on 15/7/6.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BookSeatDetailViewController.h"

#import "ListTableViewController.h"
#import "OnlineReservationsViewController.h"

#import "BookSeatModel.h"
@interface BookSeatDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSString *_ownerId;
    BookSeatModel   * _bookSeatModel;
}
@end


static NSString *cellID = @"cellID";
@implementation BookSeatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    titleButton.hidden = NO;
    [titleButton setTitle:@"订座详情" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBtnStatusAndNum];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startDownLoad];
}

-(void)viewDidLayoutSubviews
{
    if (Version >= 7.0 && Version < 8.0)
    {
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        
    }else{
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]){
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
}

#pragma mark按钮状态
- (void)setBtnStatusAndNum
{
    CGFloat buttonY = 260;
    CGFloat buttonW = (SCREEN_WIDTH-4*PADDING)/2;
    CGFloat buttonH = 40;
    CGRect changeOrderFrame = CGRectMake(PADDING, buttonY, buttonW, buttonH);
    self.changeOrder = [[UIButton alloc]initWithFrame:changeOrderFrame];
    [self.changeOrder setTitle:@"修改订单" forState:UIControlStateNormal];
    self.changeOrder.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.changeOrder setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_main_bg_normal"] forState:UIControlStateNormal];
    [self.changeOrder addTarget:self action:@selector(changeOrderClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.changeOrder];
    
    CGRect cancelOrderFrame = CGRectMake(CGRectGetMaxX(changeOrderFrame)+2*PADDING, buttonY, buttonW, buttonH);
    self.cancelOrder = [[UIButton alloc]initWithFrame:cancelOrderFrame];
    [self.cancelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
    self.cancelOrder.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.cancelOrder setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_verification_bg_selected"] forState:UIControlStateNormal];
    [self.cancelOrder addTarget:self action:@selector(cancelOrderClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelOrder];
    
    CGRect deleteOrderFrame = CGRectMake(PADDING, buttonY, SCREEN_WIDTH-2*PADDING, buttonH);
    self.deleteOrder = [[UIButton alloc]initWithFrame:deleteOrderFrame];
    [self.deleteOrder setTitle:@"删除订单" forState:UIControlStateNormal];
    self.deleteOrder.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.deleteOrder setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_main_bg_normal"] forState:UIControlStateNormal];
    [self.deleteOrder addTarget:self action:@selector(startDeleteMyBookSeatDownLoad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteOrder];
    
    self.deleteOrder.hidden = YES;
    self.changeOrder.hidden = YES;
    self.cancelOrder.hidden = YES;
    
}

//列表
- (void)createTableView
{
    if (_tableView == nil)
    {
        _tableView              = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44*4) style:UITableViewStylePlain];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
        _tableView.scrollEnabled = NO;
        [self.view addSubview:_tableView];
    }else
    {
        [_tableView reloadData];
    }
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    
    if (indexPath.row == 0)
    {
        cell.contentView.backgroundColor = RGBACOLOR(239, 239, 239, 1);
        NSString *image;
        NSString *title;
        if ([self.operationState isEqualToString:@"0"])
        {
            image = @"myorder_title_ico_ok";
            title = @"等待中";
            
        }else if ([self.operationState isEqualToString:@"1"])
        {
            image = @"myorder_title_ico_ok";
            title = @"预订成功";
            
        }else if ([self.operationState isEqualToString:@"2"])
        {
            image = @"myorder_title_ico_ok";
            title = @"已到店";
            
        }else if([self.operationState isEqualToString:@"3"])
        {
            image = @"myorder_title_ico_delete";
            title = @"商家关闭";
        }else if([self.operationState isEqualToString:@"4"])
        {
            image = @"myorder_title_ico_delete";
            title = @"已拒绝";
        }else if([self.operationState isEqualToString:@"5"])
        {
            image = @"myorder_title_ico_delete";
            title = @"已取消";
        }else
        {
            image = @"myorder_title_ico_delete";
            title = @"已过期";
        }
        
        for (UIView *view in cell.contentView.subviews)
        {
            if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]])
            {
                [view removeFromSuperview];
            }
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
        imageView.image = [UIImage imageNamed:image];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 100, 40)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = title;
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:label];
        
    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = _bookSeatModel.ownerName;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-2*PADDING, 10, 10, 20)];
        imageView.image        = [UIImage imageNamed:@"settingmessagelogin_list_arrow_right"];
        [cell.contentView addSubview:imageView];
        
    }else if (indexPath.row == 2)
    {
        cell.textLabel.text = [MyUtils timeToMyTime:_bookSeatModel.seatTime];
        UILabel *peopleNum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-2*PADDING-100, 5, 100, 30)];
        peopleNum.font     = [UIFont systemFontOfSize:15];
        peopleNum.textAlignment = NSTextAlignmentRight;
        NSString * string  = [NSString stringWithFormat:@"%@人",_bookSeatModel.seatPeople];
        peopleNum.text     = string;
        [cell.contentView addSubview:peopleNum];
        
    }else if (indexPath.row == 3)
    {
        
        if ([_bookSeatModel.sex intValue ]==0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ 先生",_bookSeatModel.userName];
        }else if([_bookSeatModel.sex intValue ]==1){
            cell.textLabel.text = [NSString stringWithFormat:@"%@ 女士",_bookSeatModel.userName];
        }
        UILabel *phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-2*PADDING-100, 5, 100, 30)];
        phoneNumLabel.adjustsFontSizeToFitWidth = YES;
        phoneNumLabel.textAlignment = NSTextAlignmentRight;
        phoneNumLabel.text = _bookSeatModel.phone;
        [cell.contentView addSubview:phoneNumLabel];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1)
    {
        
//        if (self.ownerDeleteFlag == 1)
//        {
//            [self showMsg:@"该商家已被删除"];
//            return;
//        }
        ListTableViewController *list = [[ListTableViewController alloc] init];
        
        list.oId  = [NSString stringWithFormat:@"%@",UserId];
        list.ownerId = self.ownerId;
        [self.navigationController pushViewController:list animated:YES];
    }
}

- (void)startDownLoad
{
    [self showStartHud];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString * str  = [NSString stringWithFormat:@"%@",NFM_URL];
    NSDictionary *parameter = @{@"oId":UserId,@"proIden":PROIDEN,@"seatId":self.seatId};
    NSDictionary *dic = @{@"method":MY_BOOK_SEAT_DETAIL,@"json":[parameter JSONRepresentation]};
    
    [manager GET:str parameters:dic success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
        [self stopHud:nil];
        ZNLog(@"detail=%@",responseObject);
        if ([responseObject[@"rescode"] isEqualToString:@"0000"])
        {
            if (self.status == 0){
                self.deleteOrder.hidden = NO;
            }else if (self.status == 1){
                self.cancelOrder.hidden = NO;
                self.changeOrder.hidden = NO;
            }
            _bookSeatModel = [BookSeatModel objectWithKeyValues:responseObject];
            [self createTableView];
        }
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [self stopHud:nil];
        [self showMsg:@"请求失败"];
        ZNLog(@"失败:%@",error);
    }];
    
    if (self.status == 0)
    {
        self.deleteOrder.hidden = NO;        
    }else if (self.status == 1)
    {
        self.cancelOrder.hidden = NO;
        self.changeOrder.hidden = NO;
    }   
}

#pragma mark - 删除订座
- (void)startDeleteMyBookSeatDownLoad
{
    [self showStartHud];
    AFHTTPRequestOperationManager *shoplist=[AFHTTPRequestOperationManager manager];
    shoplist.requestSerializer = [AFHTTPRequestSerializer serializer];
    shoplist.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString * str  = [NSString stringWithFormat:@"%@",NFM_URL];
    NSDictionary *parameter = @{@"oId":UserId,@"proIden":PROIDEN,@"seatId":self.seatId};
    NSDictionary *dic = @{@"method":@"updateSeatOrderByCustomer",@"json":[parameter JSONRepresentation]};
    
    [shoplist GET:str parameters:dic success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
        [self stopHud:nil];
        
        ZNLog(@"responseObject=%@",operation);
        if ([responseObject[@"rescode"] isEqualToString:@"0000"])
        {
            [self showMsg:@"删除订座成功"];
            ZNLog(@"删除订座成功");
            if ([self.delegate respondsToSelector:@selector(bookSeatStatusChange)]){
                [self.delegate bookSeatStatusChange];
            }else{
                ZNLog(@"订座详情界面的代理没有实现代理方法");
            }
            [self performSelector:@selector(pop) withObject:nil afterDelay:0.3];
        }
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [self stopHud:nil];
        [self showMsg:@"请求失败"];
        ZNLog(@"失败:%@",error);
    }];    
}

#pragma mark - 取消订座
- (void)cancelOrderClick{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"餐厅已为您预留好座位，现在取消订单店小二将会白忙一场哦" delegate:self cancelButtonTitle:@"不取消了" otherButtonTitles:@"我要取消", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self showStartHud];
        [self startCancelBookSeatDownLoad];
    }
}

- (void)startCancelBookSeatDownLoad
{
    [self showStartHud];
    NSString * str  = [NSString stringWithFormat:@"%@",NFM_URL];
    NSDictionary *parameter = @{@"oId":UserId,@"seatId":[NSString stringWithFormat:@"%@",self.seatId],@"proIden":PROIDEN};//@"ownerId":@""
    NSDictionary *dic = @{@"method":CANCELRESERVATION,@"json":[parameter JSONRepresentation]};
    [AFRequest GetRequestWithUrl:str parameters:dic andBlock:^(id Datas, NSError *error) {
        if (error == nil) {
            [self stopHud:nil];
            [self showMsg:@"取消订座成功"];
            ZNLog(@"取消订座成功");
            
            if ([self.delegate respondsToSelector:@selector(bookSeatStatusChange)]){
                [self.delegate bookSeatStatusChange];
                
            }else{
                ZNLog(@"订座详情界面的代理没有实现代理方法");
            }
            [self performSelector:@selector(pop) withObject:nil afterDelay:0.3];
        }else{
            [self stopHud:@""];
            [self showMsg:@"请求失败"];
        }
    }];
}

#pragma mark - 修改订单
-(void)changeOrderClick{
    OnlineReservationsViewController *online = [[OnlineReservationsViewController alloc] init];
    online.ownerName = _bookSeatModel.ownerName;
    online.seatOrderId = _bookSeatModel.seatId;
    online.oldTimer = [self timeToMyTime2:_bookSeatModel.seatTime];
    online.oldPersons = _bookSeatModel.seatPeople;
    online.oldPhone = _bookSeatModel.phone;
    online.oldName = _bookSeatModel.userName;
    online.oldDate = [self timeToMyTime1:_bookSeatModel.seatTime];
    NSLog(@"note=%@",_bookSeatModel.note);
//    if (_bookSeatModel.note || ![_bookSeatModel.note isEqualToString:@""] || _bookSeatModel.note != nil ||![_bookSeatModel.note isEqual:[NSNull null]]){
//        online.oldNote = _bookSeatModel.note;
//    }else{
//        online.oldNote = @"请填写备注";
//    }
    
    if (!_bookSeatModel.note || [_bookSeatModel.note isEqualToString:@""] || _bookSeatModel.note == nil ||[_bookSeatModel.note isEqual:[NSNull null]]){
        online.oldNote = @"请填写备注";
        
    }else{
        online.oldNote = _bookSeatModel.note;
    }
    
    online.oldSex = [NSString stringWithFormat:@"%@",_bookSeatModel.sex];
    online.ownerId = _bookSeatModel.ownerId;//_ownerId
    online.ownerId = self.ownerId;
    online.isModification = [NSString stringWithFormat:@"%d",0];
    ZNLog(@"isModification=%@",online.isModification);
    ZNLog(@"ownerId:%@--%@",online.ownerId ,_bookSeatModel.ownerId);
    [self.navigationController pushViewController:online animated:YES];
}


//拼接时间
- (NSString *)timeToMyTime1:(NSString *)time
{
    //2014-12-18 13:36:37
    if ([time isEqualToString:@""])
    {
        return @"";
    }
    if (time == nil) {
        return @"";
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    NSString *str1 = array[0];
    
    NSArray *arr1 = [str1 componentsSeparatedByString:@"-"];
    
    NSString *year  = arr1[0];
    NSString *month = arr1[1];
    NSString *day   = arr1[2];
    NSString *myTime = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
    return myTime;
}
//时间拼接
- (NSString *)timeToMyTime2:(NSString *)time
{
    //2014-12-18 13:36:37
    if ([time isEqualToString:@""])
    {
        return @"";
    }
    if (time == nil) {
        return @"";
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    NSString *str1 = array[0];
    NSString *str2 = array[1];
    
    NSArray *arr1 = [str1 componentsSeparatedByString:@"-"];
    NSArray *arr2 = [str2 componentsSeparatedByString:@":"];
    NSString *hour = arr2[0];
    NSString *minute = arr2[1];
    
    NSString *myTime = [NSString stringWithFormat:@"%@:%@",hour,minute];
    return myTime;
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
