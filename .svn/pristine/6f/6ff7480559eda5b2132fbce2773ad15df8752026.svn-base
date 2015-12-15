//
//  LYQDatePickerView.m
//  Chiliring
//
//  Created by nsstring on 14-8-18.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQDatePickerView.h"
#import "NSData+LYQCommon.h"

#define PICKER_ORGIN_Y 40
#define PICKER_HEIGHT 216
#define PICKER_WIDTH  170
#define YEAR_BEGIN 1900

@interface LYQDatePickerView ()
@property (nonatomic, retain) UIPickerView* yearPicker;     // 年
@property (nonatomic, retain) UIPickerView* monthPicker;    // 月
@property (nonatomic, retain) UIPickerView* dayPicker;      // 日

@property (nonatomic, retain) UIToolbar*    toolBar;        // 工具条
@property (nonatomic, retain) UILabel*      hintsLabel;     // 提示信息


@property (nonatomic, retain) NSMutableArray* yearArray;
@property (nonatomic, retain) NSMutableArray* monthArray;
@property (nonatomic, retain) NSMutableArray* dayArray;


@property (nonatomic, assign) NSUInteger yearValue;
@property (nonatomic, assign) NSUInteger monthValue;
@property (nonatomic, assign) NSUInteger dayValue;


/**
 * 创建数据源
 */
-(void)createDataSource;

/**
 * create month Arrays
 */
-(void)createMonthArrayWithYear:(NSInteger)yearInt month:(NSInteger)monthInt;


@end

@implementation LYQDatePickerView



@synthesize delegate;
@synthesize yearPicker, monthPicker, dayPicker;
@synthesize selectDate;
@synthesize yearArray, monthArray, dayArray;
@synthesize toolBar, hintsLabel;

@synthesize yearValue, monthValue,dayValue;
@synthesize isNotSelectBeforeDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSMutableArray* tempArray1 = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray* tempArray2 = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray* tempArray3 = [[NSMutableArray alloc] initWithCapacity:0];
        
        [self setYearArray:tempArray1];
        [self setMonthArray:tempArray2];
        [self setDayArray:tempArray3];
        
        // 更新数据源
        [self createDataSource];
        // 创建 toolBar & hintsLabel & enter button
        UIToolbar* tempToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        [self setToolBar:tempToolBar];
        [self addSubview:self.toolBar];
        
        UILabel* tempHintsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 250, 34)];
        [self setHintsLabel:tempHintsLabel];
        [self.hintsLabel setBackgroundColor:[UIColor clearColor]];
        //[self addSubview:self.hintsLabel];
        [self.hintsLabel setFont:[UIFont systemFontOfSize:24.0f]];
        [self.hintsLabel setTextColor:[UIColor orangeColor]];
        
        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.backgroundColor = [UIColor clearColor];
        [tempBtn setTitle:@"确定" forState:UIControlStateNormal];
        [tempBtn setTitleColor:[UIColor colorWithRed:141/255.0 green:58/255.0 blue:9/255.0 alpha:1.0] forState:UIControlStateNormal];
        tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [tempBtn sizeToFit];
        [self.toolBar addSubview:tempBtn];
        [tempBtn setFrame:CGRectMake(320-65,0,60, 40)];
        [tempBtn addTarget:self action:@selector(actionEnter:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:141/255.0 green:58/255.0 blue:9/255.0 alpha:1.0] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [cancelButton sizeToFit];
        [self.toolBar addSubview:cancelButton];
        [cancelButton setFrame:CGRectMake(10,0,60, 40)];
        [cancelButton addTarget:self action:@selector(cancelButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 初始化各个视图
        UIPickerView* yearPickerTemp = [[UIPickerView alloc] initWithFrame:CGRectMake(0, PICKER_ORGIN_Y, 120, PICKER_HEIGHT)];
        [self setYearPicker:yearPickerTemp];
        [self.yearPicker setFrame:CGRectMake(0, PICKER_ORGIN_Y, 120, PICKER_HEIGHT)];
        UIPickerView* monthPickerTemp = [[UIPickerView alloc] initWithFrame:CGRectMake(yearPickerTemp.frame.size.width, PICKER_ORGIN_Y, 100, PICKER_HEIGHT)];
        [self setMonthPicker:monthPickerTemp];
        [self.monthPicker setFrame:CGRectMake(yearPickerTemp.frame.size.width, PICKER_ORGIN_Y, 100, PICKER_HEIGHT)];
        
        
        UIPickerView* dayPickerTemp = [[UIPickerView alloc] initWithFrame:CGRectMake(monthPickerTemp.frame.origin.x + monthPickerTemp.frame.size.width, PICKER_ORGIN_Y, 100, PICKER_HEIGHT)];
        [self setDayPicker:dayPickerTemp];
        [self.dayPicker setFrame:CGRectMake(monthPickerTemp.frame.origin.x + monthPickerTemp.frame.size.width, PICKER_ORGIN_Y, 100, PICKER_HEIGHT)];
        
        [self.yearPicker setDataSource:self];
        [self.monthPicker setDataSource:self];
        [self.dayPicker setDataSource:self];
        
        [self.yearPicker setDelegate:self];
        [self.monthPicker setDelegate:self];
        [self.dayPicker setDelegate:self];
        
       
        
        
        [self.yearPicker setTag:ePickerViewTagYear];
        [self.monthPicker setTag:ePickerViewTagMonth];
        [self.dayPicker setTag:ePickerViewTagDay];

        [self addSubview:self.yearPicker];
        [self addSubview:self.monthPicker];
        [self addSubview:self.dayPicker];
        
        [self.yearPicker setShowsSelectionIndicator:YES];
        [self.monthPicker setShowsSelectionIndicator:YES];
        [self.dayPicker setShowsSelectionIndicator:YES];
        [self resetDateToCurrentDate];


    }
    return self;
}
- (void)dealloc
{
    delegate = nil;
}
/**
 * 创建数据源
 */
-(void)createDataSource{
    
    // 年 设置从1971年开始到2044年
    NSInteger yearInt = [[NSDate date]year];
    [self.yearArray removeAllObjects];
    for (int i=YEAR_BEGIN; i<=yearInt; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    // 月
    [self.monthArray removeAllObjects];

   
        for (int i=1; i<=12; i++) {
            [self.monthArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
 
         NSInteger month = [[NSDate date] month];
    
    [self createMonthArrayWithYear:yearInt month:month];
    
 }

/**
 * 判断年份为闰年还是平年
 根据～年设置月份的天数
 */
- (void)createMonthArrayWithYear:(NSInteger)yearInt month:(NSInteger)monthInt
{
    
    int endDate = 0;
    
    switch (monthInt) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            endDate = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            endDate = 30;
            break;
        case 2:
            if (yearInt%400 == 0){
                endDate = 29;
            } else {
                if (yearInt%100!=0 && yearInt%4==4) {
                    endDate = 29;
                } else {
                    endDate = 28;
                }
            }
            break;
        default:
            break;
    }
    
    if (self.dayValue>endDate) {
        self.dayValue = endDate;
    }
    
    //日
    
    [self.dayArray removeAllObjects];
    
   
    NSDate * localDate = [self getLocalDate];
    NSString *timeStr = [[[NSString stringWithFormat:@"%@",localDate] componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString * mothStr = [[timeStr componentsSeparatedByString:@"-"]objectAtIndex:1];
   // NSString* yeaStr = [[timeStr componentsSeparatedByString:@"-"]objectAtIndex:0];
    if (monthInt == [mothStr integerValue]) {
        
        NSDate * localDate = [self getLocalDate];
        NSString *timeStr = [[[NSString stringWithFormat:@"%@",localDate] componentsSeparatedByString:@" "] objectAtIndex:0];
        NSString * dayStr = [[timeStr componentsSeparatedByString:@"-"]objectAtIndex:2];

        for(int i=1;i<=[dayStr integerValue]+1;i++){
            [self.dayArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }else
    {
        for(int i=1;i<=endDate;i++){
            [self.dayArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
}
#pragma mark - 点击确定按钮
-(void)actionEnter:(id)sender{
    
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(DatePickerDelegateEnterActionWithDataPicker:)]) {
            [self.delegate DatePickerDelegateEnterActionWithDataPicker:self];
        }
 
}
- (void)cancelButtonCliked:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleActionPicker)]) {
        [self.delegate cancleActionPicker];
    }
}
/**
 *获取本地的时间
 */

-(NSDate*)getLocalDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [dateFormatter stringFromDate:nowDate];
    
    return [dateFormatter dateFromString:nowString];
}
- (void)resetDateToCurrentDate
{
    NSDate* nowDate = [NSDate date];
    [self.yearPicker selectRow:[nowDate year]-YEAR_BEGIN inComponent:0 animated:YES];
    [self.monthPicker selectRow:[nowDate month]-1 inComponent:0 animated:YES];
    [self.dayPicker selectRow:[nowDate day]-1 inComponent:0 animated:YES];
  
    
    
    [self setYearValue:[nowDate year]];
    [self setMonthValue:[nowDate month]];
    [self setDayValue:[nowDate day]];
    
    
    NSString* str = [NSString stringWithFormat:@"%04lu-%02lu-%02lu ",(unsigned long)self.yearValue, (unsigned long)self.monthValue, (unsigned long)self.dayValue];
    [self setSelectDate:[self dateFromString:str withFormat:@"yyyy-MM-dd"]];
    
}
-(NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *subDate = [inputFormatter dateFromString:string];
    
    //NSDate存储的是世界标准时(UTC)，输出时需要根据时区转换为本地时间
    //从ios4.1开始[NSDate date];获取的是GMT时间，这个时间和北京时间相差8个小时，以下代码可以解决这个问题
    //NSTimeZone * zone = [NSTimeZone systemTimeZone];
    // return  [subDate dateByAddingTimeInterval:[zone secondsFromGMTForDate:subDate]];
    return subDate;
}
//UIPickerView控件中自定义显示的字体大小及样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (ePickerViewTagYear == pickerView.tag) {
        return [self.yearArray count];
    }
    
    if (ePickerViewTagMonth == pickerView.tag) {
        return [self.monthArray count];
    }
    
    if (ePickerViewTagDay == pickerView.tag) {
        return [self.dayArray count];
    }
    
    return 0;
}
#pragma makr - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (ePickerViewTagYear == pickerView.tag) {
        return [self.yearArray objectAtIndex:row];
    }
    
    if (ePickerViewTagMonth == pickerView.tag) {
        return [self.monthArray objectAtIndex:row];
    }
    
    if (ePickerViewTagDay == pickerView.tag) {
        return [self.dayArray objectAtIndex:row];
    }
    
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if(ePickerViewTagYear == pickerView.tag ){
        self.yearValue = [[self.yearArray objectAtIndex:row] intValue];
    } else if(ePickerViewTagMonth == pickerView.tag){
        self.monthValue = [[self.monthArray objectAtIndex:row] intValue];
    } else if(ePickerViewTagDay == pickerView.tag){
        self.dayValue = [[self.dayArray objectAtIndex:row]intValue];
    }
    
    
    if (ePickerViewTagMonth == pickerView.tag || ePickerViewTagYear == pickerView.tag) {
        [self createMonthArrayWithYear:self.yearValue month:self.monthValue];
        [self.dayPicker reloadAllComponents];
    }
    

    NSString* str = [NSString stringWithFormat:@"%04lu-%02lu-%02lu ",(unsigned long)self.yearValue, (unsigned long)self.monthValue, (unsigned long)self.dayValue];
    [self setSelectDate:[self dateFromString:str withFormat:@"yyyy-MM-dd"]];
    
}
#pragma mark - 设置提示信息
-(void)setHintsText:(NSString*)hints{
    [self.hintsLabel setText:hints];
}
#pragma mark -
-(void)removeFromSuperview{
    self.delegate = nil;
    [super removeFromSuperview];
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
