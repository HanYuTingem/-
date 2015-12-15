//
//  OnlineReservationsViewController.m
//  QQList
//
//  Created by sunsu on 15/6/30.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "OnlineReservationsViewController.h"
#import "TimerSelectedView.h"
#import "ContactsView.h"
#import "OnlineModel.h"

#import "MyBookSeatViewController.h"
#import "OrderStatusViewController.h"

#import "AFHTTPRequestOperation.h"

#import "ChangeBookSeatPhoneNumViewController.h"

@interface OnlineReservationsViewController ()<TimerSelectedViewDelegate,ContactsViewDelegate,UITextFieldDelegate>

@end

@implementation OnlineReservationsViewController{
    // 时间选择
    UIView *_selectedDateBgView;
    // 联系人
    UIView *_contactsBgView;
    // 备注
    UIView *_remarkBgView;
    // 备注输入
    UITextField *_remarkTextField;
    // 提交订单View
    UIView *_bottomBgView;
    // 提交订单按钮
    UIButton *_submitOrderBtn;
    // 提示框
    UIAlertView *_alertView;
    // 提示内容
    NSString *_alertStr;
    
    //  时间选择
    TimerSelectedView *_timerSelectedView;
    //  联系人信息
    ContactsView *_contactsView;
    OnlineModel *_onlineModel;
}

- (void)initData
{
    _onlineModel = [[OnlineModel alloc] init];    
    _onlineModel.ownerId = _ownerId;
    //_onlineModel.ownerId = [NSString stringWithFormat:@"%d",153];
    _onlineModel.ownerName = _ownerName;
    
    if ([self.isModification isEqualToString:@"0"]) {
        if (_oldNote && ![_oldNote isEqualToString:@""] && _oldNote != nil) {
            _onlineModel.phone = _oldPhone;
            _onlineModel.note = _oldNote;
            _onlineModel.sex = _oldSex;
        }else{
            _oldNote = @"请填写备注";
        }
    }else{
        _onlineModel.phone = PhoneNumber;
        _onlineModel.sex = @"1";
        _onlineModel.note = @"暂无备注";
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([_isModification isEqualToString:@"0"]) {
        titleButton.hidden = NO;
        [titleButton setTitle:@"修改订座订单" forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        titleButton.hidden = NO;
        [titleButton setTitle:@"在线订座" forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试数据
   
    UIImage *image = [UIImage imageNamed:@"dingzuo_0005_icon_me.png"];
    [self.rightNavItem setImage:image forState:UIControlStateNormal];
    self.view.backgroundColor = RGBCOLOR(238, 238, 238);
    
    [self initData];
    
    [self createTimerSelectedBgView];
    
    [self createContactsBgView];
    
    [self createRemarkBgView];
    
    [self createSubmitOrder];
    
    [self createAlterView];
    
    //[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)sendBtn:(id)sender{
    MyBookSeatViewController * myBookSeatViewController = [[MyBookSeatViewController alloc]init];
    /* 传如下参数
     'customerId':'438387', //用户Id
     'page':'',页数
     'rows':''行数
     “proIden” //产品登录标识
     */
    [self.navigationController pushViewController:myBookSeatViewController animated:YES];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [_contactsView.nameTextfield resignFirstResponder];
//    [_remarkTextField resignFirstResponder];
//    [self.view endEditing:YES];
//}

// 时间选择
- (void)createTimerSelectedBgView
{
    if (_selectedDateBgView == nil) {
        _selectedDateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 60)];
        _selectedDateBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_selectedDateBgView];
        
        _timerSelectedView = [[TimerSelectedView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
        
        _timerSelectedView.timerSelectedDelegate = self;
        _timerSelectedView.isModification = _isModification;
        if ([_isModification isEqualToString:@"0"]) {
            
            NSString *dateStr = [self judgeOfTheWeek:_oldDate];
            [_timerSelectedView setNumberDate:dateStr andOldTimer:_oldTimer andOldPersons:_oldPersons];
        }
        [_selectedDateBgView addSubview:_timerSelectedView];
    }
}

// 联系人信息
- (void)createContactsBgView
{
    if (_contactsBgView == nil) {
        _contactsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_selectedDateBgView.frame)+10, SCREEN_WIDTH, 110)];
        _contactsBgView.backgroundColor = [UIColor whiteColor];
        
        if ([_isModification isEqualToString:@"0"]) {
            _contactsBgView.userInteractionEnabled = NO;
        }else{
            _contactsBgView.userInteractionEnabled = YES;
        }
        [self.view addSubview:_contactsBgView];
        
        
        _contactsView = [[ContactsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        if ([_isModification isEqualToString:@"0"]) {
            [_contactsView setOldPhone:_oldPhone andOldName:_oldName andOldSex:_oldSex];
        }else{
            _contactsView.phone = _onlineModel.phone;
            _contactsView.sex = _onlineModel.sex;
        }
        _contactsView.contactsViewDelegate = self;
        [_contactsBgView addSubview:_contactsView];
    }
}

// 备注信息
- (void)createRemarkBgView
{
    if (_remarkBgView == nil) {
        _remarkBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contactsBgView.frame)+10, SCREEN_WIDTH, 50)];
        _remarkBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_remarkBgView];
    }
    if (_remarkTextField == nil) {
        _remarkTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 33)];
        _remarkTextField.backgroundColor = [UIColor whiteColor];
        _remarkTextField.borderStyle = UITextBorderStyleNone;
        _remarkTextField.placeholder = @"备注:其他信息";
        if ([_isModification isEqualToString:@"0"]) {
            _remarkTextField.text = [NSString stringWithFormat:@"%@",_onlineModel.note];
        }
        _remarkTextField.textColor = [UIColor grayColor];
        _remarkTextField.font = [UIFont systemFontOfSize:15];
        _remarkTextField.textAlignment = NSTextAlignmentLeft;
        _remarkTextField.delegate = self;
        //是否纠错
        _remarkTextField.autocorrectionType = UITextAutocorrectionTypeDefault;
        //再次编辑就清空
        _remarkTextField.clearsOnBeginEditing = YES;
        //设置键盘的样式
        _remarkTextField.keyboardType = UIKeyboardTypeDefault;
        //return键的样式
        _remarkTextField.returnKeyType = UIReturnKeyNext;
        //键盘外观
        _remarkTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
        [_remarkBgView addSubview:_remarkTextField];
        
    }
    
}



// 提交订单
- (void)createSubmitOrder{
    if (_bottomBgView == nil) {
        _bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80)];
        _bottomBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomBgView];
    }
    if (_submitOrderBtn == nil) {
        _submitOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitOrderBtn.frame = CGRectMake(10, 20, SCREEN_WIDTH-20, 40);
        if ([_isModification isEqualToString:@"0"]) {
            [_submitOrderBtn setTitle:@"确定修改"forState:UIControlStateNormal];
        }else{
            [_submitOrderBtn setTitle:@"提交订单"forState:UIControlStateNormal];
        }
        
        [_submitOrderBtn setBackgroundImage:[UIImage imageNamed:@"dingzuo_0001_tijiao_btn.png"] forState:UIControlStateNormal];
        [_submitOrderBtn addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBgView addSubview:_submitOrderBtn];
    }
}

#pragma mark -- 提交订单
- (void)submitOrder
{
    
    [self ReplacementString];
//    NSString * timeStr = [NSString stringWithFormat:@"%@",_onlineModel.seatTime];
//    NSLog(@"timeStr=%@",timeStr);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    NSDate *date = [formatter dateFromString:timeStr];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    // 判断用户名是否为空
    if ([_onlineModel.userName isEqualToString:@""] && _onlineModel.userName.length == 0) {
        [self showMsg:@"联系人不能为空"];
    }else{
        NSLog(@"_isModification————————————》%@",_isModification);
        if ([_isModification isEqualToString:@"0"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改后，原先的订座将不会保留哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"还是不改了",@"确定修改",nil];
            [alertView show];
        }else{
            //  提交订单
            NSDictionary * dictionary =  @{@"seatTime":_onlineModel.seatTime,@"seatPeople":_onlineModel.seatPeople,@"ownerId":self.ownerId,@"oId":HUserId,@"userName":_onlineModel.userName,@"sex":_onlineModel.sex,@"phone":_onlineModel.phone,@"note":_onlineModel.note,@"proIden":PROIDEN};
            NSLog(@"dingzuotijiao=%@",dictionary);
            
            [self showStartHud];
            NSString * str = [NSString  stringWithFormat:@"%@",NFM_URL];
            
            NSString * dicStr = [dictionary JSONRepresentation];
            NSDictionary * parameter = @{@"method":SUBMITRESERVATION,@"json":dicStr};
            [AFRequest PostRequestWithUrl:str parameters:parameter andBlock:^(id Datas, NSError *error) {
                if (error == nil) {
                    [self stopHud:@""];
                    NSLog(@"rescode=%@", [Datas objectForKey:@"rescode"]);
                    if ([[Datas objectForKey:@"rescode"] isEqualToString:@"0000"]) {
                        OrderStatusViewController * reservationsView = [[OrderStatusViewController alloc]init];
                        //可以传模型过去
                        reservationsView.personName = _onlineModel.userName;
                        reservationsView.numberTell = _onlineModel.phone;
                        reservationsView.numberDate = [NSString stringWithFormat:@"%@ %@",[_timerSelectedView.selectedDate substringFromIndex:5],_timerSelectedView.selectedTimer];
                        reservationsView.ownerName = _onlineModel.ownerName;
                        reservationsView.sex = _onlineModel.sex;
                        reservationsView.numberPerson = _onlineModel.seatPeople;
                        reservationsView.isModification = _isModification;
                        reservationsView.seatId = [Datas objectForKey:@"seatOrderId"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaoguojietu" object:nil userInfo:nil];
                        
                        [self.navigationController pushViewController:reservationsView animated:YES];
                        [self stopHud:@""];
                    }else if ([[Datas objectForKey:@"rescode"] isEqualToString:@"0100"]){
                        [self stopHud:@""];
                        _alertView.message = @"今天您提交了太多的订单啦~\n明天再来预订吧~";
                        [_alertView show];
                    }else{
                        NSLog(@"result————————>%@——————>%@",Datas,[Datas objectForKey:@"resdesc"]);
                        [self stopHud:@""];
                        _alertView.message = [Datas objectForKey:@"resdesc"];
                        [_alertView show];
                    }

                }else{
                    [self stopHud:@""];
                    [self showMsg:@"网络不佳"];
                    
                    ZNLog(@"fail");
                }
                
            }];
        }
    }
}

//  替换字符串
- (void)ReplacementString
{
    //  将年月日替换掉
    NSString *str1 = @"年";
    NSString *str2 = @"月";
    NSString *str3 = @"日";
    NSLog(@"_timerSelectedView.selectedDate——————————>%@",_timerSelectedView.selectedDate);
    _onlineModel.seatTime = _timerSelectedView.selectedDate;
    NSLog(@"selectedDate=%@",_timerSelectedView.selectedDate);
    
    _onlineModel.seatTime = [_onlineModel.seatTime stringByReplacingOccurrencesOfString:str1 withString:@"-"];
    _onlineModel.seatTime = [_onlineModel.seatTime stringByReplacingOccurrencesOfString:str2 withString:@"-"];
    _onlineModel.seatTime = [_onlineModel.seatTime stringByReplacingOccurrencesOfString:str3 withString:@"-"];
    
    // 去掉星期
    long a = _onlineModel.seatTime.length - 4;
    _onlineModel.seatTime = [_onlineModel.seatTime substringToIndex:a];
    
    // 拼接上时间
    _onlineModel.seatTime = [NSString stringWithFormat:@"%@ %@:00",_onlineModel.seatTime,_timerSelectedView.selectedTimer];
    
    NSLog(@"finalTime = %@",_onlineModel.seatTime);
    
    // 人数处理
    _onlineModel.seatPeople = _timerSelectedView.selectedPersons;
    long b = _timerSelectedView.selectedPersons.length - 1;
    _onlineModel.seatPeople = [_onlineModel.seatPeople substringToIndex:b];
    
    // 性别
    _onlineModel.sex = _contactsView.sex;
    
    // 用户名
    _onlineModel.userName = _contactsView.name;
    
    // 备注信息
    if ([_onlineModel.note isEqualToString:@""]) {
        _onlineModel.note = @"暂无备注";
    }
    _onlineModel.note = _remarkTextField.text;
}

//  修改订单——————根据日期判断星期几
- (NSString *)judgeOfTheWeek:(NSString *)oldDate
{
    NSLog(@"字符串————————>%@",oldDate);
    //  字符串截取
    NSString *dayStr = [oldDate substringWithRange:NSMakeRange(8, 2)];
    NSString *monthStr = [oldDate substringWithRange:NSMakeRange(5,2)];
    NSString *yearStr = [oldDate substringWithRange:NSMakeRange(0, 4)];
    
    //  提供日期，进行星期的判断
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[dayStr integerValue]];
    [_comps setMonth:[monthStr integerValue]];
    [_comps setYear:[yearStr integerValue]];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    long _weekday = [weekdayComponents weekday];
    //  周天是1
    switch (_weekday) {
        case 1:
            return [NSString stringWithFormat:@"%@星期日",oldDate];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@星期一",oldDate];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@星期二",oldDate];
            break;
        case 4:
            return [NSString stringWithFormat:@"%@星期三",oldDate];
            break;
        case 5:
            return [NSString stringWithFormat:@"%@星期四",oldDate];
            break;
        case 6:
            return [NSString stringWithFormat:@"%@星期五",oldDate];
            break;
        case 7:
            return [NSString stringWithFormat:@"%@星期六",oldDate];
            break;
        default:
            return nil;
            break;
    }
}

//  提示框
- (void)createAlterView
{
    _alertView = [[UIAlertView alloc] initWithTitle:@"" message:@""  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self isContainsEmoji:textField.text]) {
        [textField resignFirstResponder];
        [self showMsg:@"输入内容不得包含非法字符、表情等"];
    }else{
        _onlineModel.note = textField.text;
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - timerSelectedViewDelegate  添加pickerView视图
- (void)addPickerBgView
{
    _onlineModel.userName = _contactsView.name;
    [_contactsView.nameTextfield resignFirstResponder];
    [_remarkTextField resignFirstResponder];
    [self.view addSubview:_timerSelectedView.pickerBgView];
}

#pragma mark - contactsViewDelegate - 修改电话号码
- (void)modifyNumberTell
{
    ChangeBookSeatPhoneNumViewController  * vc = [[ChangeBookSeatPhoneNumViewController alloc]init];
//    __block OnlineReservationsViewController *onLine = self;
    vc.myBlock = ^(NSString *str){
       _onlineModel.phone = str;
        _contactsView.phone = str;
        [_contactsView layoutSubviews];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)changePhoneNum:(NSString *)phoneNum
//{
//    NSLog(@"电话号码——————————》%@",phoneNum);
//    _onlineModel.phone = [NSString stringWithFormat:@"%@",phoneNum];
//    _contactsView.phone = [NSString stringWithFormat:@"%@",phoneNum];
//    [_contactsView layoutSubviews];
//}

#pragma mark - 修改订座
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"还是不改了");
    }else if (buttonIndex == 1){
        [self showStartHud];
        
//        NSLog(@"seatTime=%@",_onlineModel.seatTime);
//        NSString * timeStr = [NSString stringWithFormat:@"%@",_onlineModel.seatTime];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateStyle:NSDateFormatterMediumStyle];
//        [formatter setTimeStyle:NSDateFormatterShortStyle];
//        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//        [formatter setTimeZone:timeZone];
//        NSDate *date = [formatter dateFromString:timeStr];
//        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];

        NSLog(@"seatTime=%@",_onlineModel.seatTime);
        NSDictionary *dictionary = @{@"ownerId":self.ownerId,@"oId":HUserId,@"seatId":_seatOrderId,@"seatTime":_onlineModel.seatTime,@"seatPeople":_onlineModel.seatPeople,@"userName":_onlineModel.userName,@"sex":_onlineModel.sex,@"phone":_onlineModel.phone,@"note":_onlineModel.note,@"proIden":PROIDEN};
        
        
        AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"text/javascript",@"application/json",@"text/plain", nil];

        NSString * str = [NSString  stringWithFormat:@"%@",NFM_URL];
        NSDictionary *dic = @{@"method":MODIFYRESERVATION,@"json":[dictionary JSONRepresentation]};

        [manager POST:str parameters:dic success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
            NSLog(@"operation=%@",responseObject);
            [self stopHud:@""];
            if ([[responseObject objectForKey:@"rescode"] integerValue] == 0000) {
                OrderStatusViewController *reservationsView = [[OrderStatusViewController alloc] init];
                reservationsView.personName = _onlineModel.userName;
                reservationsView.numberTell = _onlineModel.phone;
                reservationsView.numberDate = [NSString stringWithFormat:@"%@ %@",[_timerSelectedView.selectedDate substringFromIndex:5],_timerSelectedView.selectedTimer];
                reservationsView.ownerName = _ownerName;
                reservationsView.numberPerson = _onlineModel.seatPeople;
                reservationsView.isModification = _isModification;
                reservationsView.seatId = self.seatOrderId;
                NSLog(@"reservationsView.seatId=%@",reservationsView.seatId);
                //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaoguojietu" object:nil userInfo:nil];
                [self.navigationController pushViewController:reservationsView animated:YES];
                
            }else if ([[responseObject objectForKey:@"result"] integerValue] == 1001){
                _alertView.message = @"今天您修改了太多的订单啦~\n明天再来预订吧~";
                [_alertView show];
            }else{
                _alertView.message = @"修改订单失败!";
                [_alertView show];
            }

            
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            [self stopHud:@""];
            [self showMsg:@"网络不佳"];
            
            NSLog ( @"operation: %@" , operation.responseString );
        }];
        
//        [AFRequest PostRequestWithUrl:str parameters:dic andBlock:^(id Datas, NSError *error){
//            
//            if (error == nil) {
//                [self stopHud:@""];
//                if ([[Datas objectForKey:@"rescode"] integerValue] == 0000) {
//                    OrderStatusViewController *reservationsView = [[OrderStatusViewController alloc] init];
//                    reservationsView.personName = _onlineModel.userName;
//                    reservationsView.numberTell = _onlineModel.phone;
//                    reservationsView.numberDate = [NSString stringWithFormat:@"%@ %@",[_timerSelectedView.selectedDate substringFromIndex:5],_timerSelectedView.selectedTimer];
//                    reservationsView.ownerName = _ownerName;
//                    reservationsView.numberPerson = _onlineModel.seatPeople;
//                    reservationsView.isModification = _isModification;
//                    reservationsView.seatId = [Datas objectForKey:@"seatOrderId"];
////                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaoguojietu" object:nil userInfo:nil];
//                    [self.navigationController pushViewController:reservationsView animated:YES];
//                    
//                }else if ([[Datas objectForKey:@"result"] integerValue] == 1001){
//                    _alertView.message = @"今天您修改了太多的订单啦~\n明天再来预订吧~";
//                    [_alertView show];
//                }else{
//                    _alertView.message = @"修改订单失败!";
//                    [_alertView show];
//                }
//
//            }else{
//                [self stopHud:@""];
//                [self showMsg:@"请求失败"];
//            }
//        }];
    }
}


//  emoji表情判断
- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}


@end
