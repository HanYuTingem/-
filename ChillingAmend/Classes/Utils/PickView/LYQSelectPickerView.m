//
//  LYQSelectPickerView.m
//  Chiliring
//
//  Created by nsstring on 14-9-24.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQSelectPickerView.h"
#import "JPCommonMacros.h"

@implementation LYQSelectPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kkDColor;
        [self setDatePicker];
    }
    return self;
}

-(void)setDatePicker
{
    _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-40)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventTouchDragEnter];

    //获得当前时间
   // [datePicker setMinimumDate:[NSDate date]];
    [_datePicker setMaximumDate:[NSDate date]];
    
    // NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//设置为英文显示
     NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
     _datePicker.locale = locale;
    
    [self addSubview:_datePicker];
    
    
     UIToolbar* tempToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    [self addSubview:tempToolBar];
    

    UIButton * amemdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [amemdBtn setFrame:CGRectMake(320-65,0,60, 40)];
    [self addSubview:amemdBtn];
    [amemdBtn addTarget:self action:@selector(amemdBtnDataCliked:) forControlEvents:UIControlEventTouchUpInside];
    [amemdBtn setTitle:@"确定" forState:UIControlStateNormal];
    [amemdBtn setTitleColor:[UIColor colorWithRed:141/255.0 green:58/255.0 blue:9/255.0 alpha:1.0] forState:UIControlStateNormal];

    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(10,0,60, 40)];
    [self addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:141/255.0 green:58/255.0 blue:9/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnDataCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
    line.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:.5];
    [self addSubview:line];
    
}
- (void)datePickerDateChanged:(UIDatePicker*)Picker
{
    NSLog(@"Selected date=%@",Picker.date);
}
#pragma mark -- 获取生日  确定
- (void)amemdBtnDataCliked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPickerViewWithDateStr:)]) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr=[formatter stringFromDate:_datePicker.date];
        
        [self.delegate selectPickerViewWithDateStr:dateStr ];
    }
}

//取消
- (void)cancelBtnDataCliked:(id)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPickerView)]) {
        [self.delegate cancelPickerView];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
