//
//  TimerSelectedView.h
//  HCheap
//
//  Created by JianDan on 14/12/17.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 *  时间选择view
 */
#import <UIKit/UIKit.h>
@protocol TimerSelectedViewDelegate <NSObject>
// 添加pickerView到控制器上
- (void)addPickerBgView;

@end

@interface TimerSelectedView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
{
    //  日期Label
    UILabel *_numberDate;
    //  时间Label
    UILabel *_numberTimer;
    //  人数Label
    UILabel *_numberPerson;
    //  预定时间
    UILabel *_scheduledTime;
    // pickerView
    UIPickerView *_pickerView;
    //  取消
    UIButton *_cancelBtn;
    //  确定
    UIButton *_scuessBtn;
    //  时间
    UILabel *_timerLabel;
    
    //  当前日期 - 时间
    NSDate *_currentDate;
    NSDate *_currentTimer;
    
    // pickerViewDacustor
    NSMutableArray *_dateArrs;
    NSMutableArray *_timerArrs;
    NSMutableArray *_personArrs;
}

// 选中时间
@property (nonatomic, strong)NSString *selectedDate;
@property (nonatomic, strong)NSString *selectedTimer;
@property (nonatomic, strong)NSString *selectedPersons;

//  判断是否为修改 0-修改入口 1-订单入口
@property (nonatomic, strong)NSString *isModification;
//  修改前日期
@property (nonatomic, strong)NSString *oldDate;
//  修改前时间
@property (nonatomic, strong)NSString *oldTimer;
//  修改前人数
@property (nonatomic, strong)NSString *oldPersons;

//  弹出pickerView按钮
@property (nonatomic, strong)UIButton *selectedBtn;
//  pickerView背景View
@property (nonatomic, strong)UIView *pickerBgView;

@property (nonatomic, weak)id<TimerSelectedViewDelegate> timerSelectedDelegate;

- (void)setNumberDate:(NSString *)oldDate andOldTimer:(NSString *)oldTimer andOldPersons:(NSString *)oldPersons;
- (void)removePickerBgView;
@end
