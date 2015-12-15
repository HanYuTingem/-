//
//  LYQDatePickerView.h
//  Chiliring
//
//  Created by nsstring on 14-8-18.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ePickerViewTagYear = 2012,
    ePickerViewTagMonth,
    ePickerViewTagDay,
    
}PickViewTag;

@protocol DatePickerDelegate;

@interface LYQDatePickerView : UIView
<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, retain) NSDate*   selectDate;       // 当前date
@property (nonatomic, assign) id<DatePickerDelegate>delegate;
@property (nonatomic,assign) BOOL isNotSelectBeforeDate;//是否设置不选择以前的日期


/**
 * 设置默认值为当前时间
 */
-(void)resetDateToCurrentDate;

/**
 * 设置提示信息
 */
-(void)setHintsText:(NSString*)hints;


@end

@protocol DatePickerDelegate <NSObject>

/**
 * 点击确定后的事件
 */
@optional
-(void)DatePickerDelegateEnterActionWithDataPicker:(LYQDatePickerView*)picker;
-(void)cancleActionPicker;
@end
