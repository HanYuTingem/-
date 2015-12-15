//
//  TimerSelectedView.m
//  HCheap
//
//  Created by JianDan on 14/12/17.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "TimerSelectedView.h"

@implementation TimerSelectedView
{
    //  记录选择位置
    int _component0Row;
    int _component1Row;
    int _component2Row;
    NSMutableArray *_toDayTimerArr;
    
    NSMutableArray *_timerArrData;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        
        [self initData];
        
        [self createUI];
    }
    return self;
}

- (void)initData
{
    
    _component0Row = 0;
    _component1Row = 0;
    _component2Row = 0;
    
    _selectedDate = @"";
    _selectedTimer = @"";
    _selectedPersons = @"";
    
    _dateArrs = [NSMutableArray arrayWithCapacity:0];
    _timerArrs = [NSMutableArray arrayWithCapacity:0];
    _personArrs = [NSMutableArray arrayWithCapacity:0];
    _toDayTimerArr = [NSMutableArray arrayWithCapacity:0];
    _timerArrData = [NSMutableArray arrayWithCapacity:0];
    
    [self createCurrentDate];
    
    [self createCurrentTimer];
    
    [self createDates];
    
    [self createPersons];
}

// 显示时间界面
- (void)createUI
{
    if (_selectedBtn == nil) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedBtn.frame = CGRectMake(0, 0, 300, 40);
        [_selectedBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectedBtn];
        
        if (_scheduledTime == nil) {
            _scheduledTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 65, 30)];
            _scheduledTime.text = @"预订时间:";
            _scheduledTime.textColor = [UIColor blackColor];
            _scheduledTime.font = [UIFont systemFontOfSize:15];
            _scheduledTime.textAlignment = NSTextAlignmentLeft;
            _scheduledTime.backgroundColor = [UIColor clearColor];
            [self.selectedBtn addSubview:_scheduledTime];
        }
        
        if (_numberDate == nil) {
            _numberDate = [[UILabel alloc] initWithFrame:CGRectMake(80, 6, 120, 30)];
            _numberDate.text = [NSString stringWithFormat:@"%@",[_selectedDate substringFromIndex:5]];
            _numberDate.textColor = [UIColor blackColor];
            _numberDate.font = [UIFont systemFontOfSize:13];
            _numberDate.textAlignment = NSTextAlignmentLeft;
            _numberDate.backgroundColor = [UIColor clearColor];
            [self.selectedBtn addSubview:_numberDate];
        }
        
        if (_numberTimer == nil) {
            _numberTimer = [[UILabel alloc] initWithFrame:CGRectMake(200, 6, 40, 30)];
            _numberTimer.text = [NSString stringWithFormat:@"%@",_selectedTimer];
            _numberTimer.textColor = [UIColor blackColor];
            _numberTimer.font = [UIFont systemFontOfSize:13];
            _numberTimer.textAlignment = NSTextAlignmentLeft;
            _numberTimer.backgroundColor = [UIColor clearColor];
            [self.selectedBtn addSubview:_numberTimer];
        }
        
        if (_numberPerson == nil) {
            _numberPerson = [[UILabel alloc] initWithFrame:CGRectMake(255, 6, 40, 30)];
            _numberPerson.text = [NSString stringWithFormat:@"%@",_selectedPersons];
            _numberPerson.textColor = [UIColor blackColor];
            _numberPerson.font = [UIFont systemFontOfSize:13];
            _numberPerson.textAlignment = NSTextAlignmentLeft;
            _numberPerson.backgroundColor = [UIColor clearColor];
            [self.selectedBtn addSubview:_numberPerson];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];    
    _numberPerson.text = [NSString stringWithFormat:@"%@",_selectedPersons];
    _numberDate.text = [NSString stringWithFormat:@"%@",[_selectedDate substringFromIndex:5]];
    _numberTimer.text = [NSString stringWithFormat:@"%@",_selectedTimer];
}

// 时间选择器
- (void)createPickerBgView
{
    if (_pickerBgView == nil) {
        _pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -210, SCREEN_WIDTH, 210)];
        _pickerBgView.backgroundColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
    }
    
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 180)];
        //在当前选择上显示一个透明窗口
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [_pickerView selectRow:_component0Row inComponent:0 animated:NO];
        [_pickerView selectRow:_component1Row inComponent:1 animated:NO];
        [_pickerView selectRow:_component2Row inComponent:2 animated:NO];
        [_pickerBgView addSubview:_pickerView];
    }
    
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(30, 0, 50, 30);
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(pickerViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerBgView addSubview:_cancelBtn];
    }
    
    if (_timerLabel == nil) {
        _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, 0, 50, 30 )];
        _timerLabel.text = @"";                     //  已取消显示
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont systemFontOfSize:17];
        _timerLabel.backgroundColor = [UIColor clearColor];
        [_pickerBgView addSubview:_timerLabel];
    }
    
    if (_scuessBtn == nil) {
        _scuessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scuessBtn.frame = CGRectMake(240, 0, 50, 30);
        _scuessBtn.backgroundColor = [UIColor clearColor];
        [_scuessBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_scuessBtn addTarget:self action:@selector(pickerViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerBgView addSubview:_scuessBtn];
    }
}

// 移除视图
- (void)removePickerBgView
{
    if (_pickerBgView != nil) {
        [_pickerBgView removeFromSuperview];
        _pickerBgView = nil;
    }
    
    if (_pickerView != nil) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    if (_cancelBtn != nil) {
        [_cancelBtn removeFromSuperview];
        _cancelBtn = nil;
    }
    
    if (_timerLabel != nil) {
        [_timerLabel removeFromSuperview];
        _timerLabel = nil;
    }
    
    if (_scuessBtn != nil) {
        [_scuessBtn removeFromSuperview];
        _scuessBtn = nil;
    }
}

// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//  行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0 ) {
        return [_dateArrs count];
    }else if (component == 1){
//        return [_timerArrs count];
        return [_timerArrData count];
    }else if (component == 2){
        return [_personArrs count];
    }else{
        return 0;
    }
}

//  宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 100;
    }else if (component == 1){
        return 60;
    }else if (component == 2){
        return 40;
    }else{
        return 0;
    }
}

//  高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

// 设置内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (component == 0) {
        UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        dateLable.text = [_dateArrs[row] substringFromIndex:5];
        dateLable.textColor = [UIColor blackColor];
        dateLable.textAlignment = NSTextAlignmentCenter;
        dateLable.font = [UIFont systemFontOfSize:13];
        return dateLable;
    }else if (component == 1){
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//        timerLabel.text = _timerArrs[row];
        timerLabel.text = _timerArrData[row];
        timerLabel.textColor = [UIColor blackColor];
        timerLabel.textAlignment = NSTextAlignmentCenter;
        timerLabel.font = [UIFont systemFontOfSize:13];
        return timerLabel;
//        if (component == 0 && row == 0) {
//            UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//            timerLabel.text = _toDayTimerArr[row];
//            timerLabel.textColor = [UIColor blackColor];
//            timerLabel.textAlignment = NSTextAlignmentCenter;
//            timerLabel.font = [UIFont systemFontOfSize:13];
//            return timerLabel;
//        }else{
//            UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//            timerLabel.text = _timerArrs[row];
//            timerLabel.textColor = [UIColor blackColor];
//            timerLabel.textAlignment = NSTextAlignmentCenter;
//            timerLabel.font = [UIFont systemFontOfSize:13];
//            return timerLabel;
//        }
    }else if (component == 2){
        UILabel *personLabels = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        personLabels.text = _personArrs[row];
        personLabels.textColor = [UIColor blackColor];
        personLabels.textAlignment = NSTextAlignmentCenter;
        personLabels.font = [UIFont systemFontOfSize:13];
        return personLabels;
    }else{
        return nil;
    }
}

//  选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _component0Row = (int)row;
        if (component == 0 && row == 0) {
            _timerArrData = [NSMutableArray arrayWithArray:_toDayTimerArr];
        }else{
            _timerArrData = [NSMutableArray arrayWithArray:_timerArrs];
        }
        [pickerView reloadComponent:1];
    }else if (component == 1){
        _component1Row = (int)row;
    }else if (component == 2){
        _component2Row = (int)row;
    }
}

// 取消OR确定选中
- (void)pickerViewAction:(UIButton *)sender
{
    if (sender == _cancelBtn) {
        
        [self removePickerBgView];
    }else if (sender == _scuessBtn){
        
        _selectedDate = _dateArrs[[_pickerView selectedRowInComponent:0]];
        _selectedTimer =  _timerArrData[[_pickerView selectedRowInComponent:1]];
        _selectedPersons =  _personArrs[[_pickerView selectedRowInComponent:2]];
        [self setNeedsLayout];
        
        [self removePickerBgView];
    }
}

// 将pickerView添加到当前窗口中
- (void)selectedAction:(UIButton *)sender
{
    [self createPickerBgView];
    
    //  在控制器上添加PickerBgView视图 加以展示及供用户操作
    if ([self.timerSelectedDelegate respondsToSelector:@selector(addPickerBgView)]) {
        [self.timerSelectedDelegate addPickerBgView];
    }else{
        NSLog(@"未实现代理");
    }
}

//  当前日期
- (void)createCurrentDate
{
    if (_currentDate == nil) {
        _currentDate = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        // 指定时区
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
        [formatter setDateFormat:@"yyyy年MM月dd日EEEE"];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _selectedDate = [formatter stringFromDate:_currentDate];
    }
}

//  当前时间
- (void)createCurrentTimer
{
    if (_currentTimer == nil) {
        _currentTimer = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        [formatter setTimeZone:timeZone];
        NSString *timerStr = [formatter stringFromDate:_currentTimer];
        // 默认选择最近的下一个时段
        [self compareTimer:timerStr];
    }
}

//  生成今天后的20天日期
- (void)createDates
{
    if (_currentDate != nil) {
        for (int i = 1; i < 21; i++) {
            NSTimeInterval secondsPerDay1 = 24*60*60*i;
            NSDate *tomorrows = [_currentDate dateByAddingTimeInterval:secondsPerDay1];
            NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY年MM月dd日EEEE"];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            // 指定时区
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
            [formatter setTimeZone:timeZone];
            NSString *tomorrowsStr = [formatter stringFromDate:tomorrows];
            [_dateArrs addObject:tomorrowsStr];
        }
        [_dateArrs insertObject:_selectedDate atIndex:0];
    }
}

// 生成全部小时段
- (void)createTimerSection
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *nowTimer = [formatter dateFromString:@"00:00"];
    for (int i = 0; i < 48; i++) {
        NSTimeInterval timerSection = 30*60*i;
        NSDate *nextTimer =[nowTimer dateByAddingTimeInterval:timerSection];
        NSString *nextTimerStr = [formatter stringFromDate:nextTimer];
        [_timerArrs addObject:nextTimerStr];
    }
    
}

// 生成人数
- (void)createPersons
{
    for (int i = 1; i <= 15; i++) {
        NSString *numberPerson = [NSString stringWithFormat:@"%d人",i];
        [_personArrs addObject:numberPerson];
    }
    //  默认设置为4人
    _selectedPersons = _personArrs[3];
}

/*
 *  获取当前时间，然后取他最近的一个时段作为默认显示
 */
- (void)compareTimer:(NSString *)currentTimer
{
    [self createTimerSection];
    
    NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
    [currentFormatter setDateFormat:@"HH:mm"];
    NSDate *currentTimerDate = [currentFormatter dateFromString:currentTimer];
    
    for (int i = 0; i < [_timerArrs count]; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSDate *nextTimer = [formatter dateFromString:_timerArrs[i]];
        
        if ([currentTimerDate isEqualToDate:nextTimer]) {
            _selectedTimer = _timerArrs[i];
//            _component1Row = i;
            //  设置今天之前的时间不可选
            [self todaySelectableTime:_timerArrs andNSInteger:i];
            return;
        }else if ([currentTimerDate laterDate:nextTimer] == nextTimer){
            _selectedTimer = _timerArrs[i];
//            _component1Row = i;
            [self todaySelectableTime:_timerArrs andNSInteger:i];
            return;
        }
    }
}

//  设置今天可选时间
- (void)todaySelectableTime:(NSMutableArray *)timerArr andNSInteger:(NSInteger)index
{
    for (NSInteger i = index; i < [timerArr count]; i++) {
        [_toDayTimerArr addObject:timerArr[i]];
    }
//    _selectedTimer = _toDayTimerArr[0];
    _timerArrData = [NSMutableArray arrayWithArray:_toDayTimerArr];
}

//  修改订座订单设置
- (void)setNumberDate:(NSString *)oldDate andOldTimer:(NSString *)oldTimer andOldPersons:(NSString *)oldPersons
{
    _numberDate.text = [NSString stringWithFormat:@"%@",oldDate];
    _numberTimer.text = [NSString stringWithFormat:@"%@",oldTimer];
    _numberPerson.text = [NSString stringWithFormat:@"%@人",oldPersons];
    
    _selectedDate = [NSString stringWithFormat:@"%@",oldDate];
    _selectedTimer = [NSString stringWithFormat:@"%@",oldTimer];
    _selectedPersons = [NSString stringWithFormat:@"%@人",oldPersons];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
