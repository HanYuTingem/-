//
//  SelectCityView.m
//  行业版
//
//  Created by WangShandong on 13-12-3.
//  Copyright (c) 2013年 zhongke. All rights reserved.
//

#import "SelectCityView.h"

@implementation SelectCityView
{
    NSString *provinceStr;
    NSString *cityStr;
    NSString *districtStr;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        self.alpha = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        if(frame.size.height == 215){
            
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *plistPath = [bundle pathForResource:@"LYQ_faqiarea" ofType:@"plist"];
            areaDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

        }else{
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *plistPath = [bundle pathForResource:@"LYQ_area" ofType:@"plist"];
            areaDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

        }
        
        NSArray *components = [areaDic allKeys];
        NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *tmp = [[areaDic objectForKey: index] allKeys];
            [provinceTmp addObject: [tmp objectAtIndex:0]];
        }
        
        province = [[NSArray alloc] initWithArray: provinceTmp];
        
        
        NSString *index = [sortedArray objectAtIndex:0];
        NSString *selected = [province objectAtIndex:0];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
        
        NSArray *cityArray = [dic allKeys];
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
        city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
        
        
        NSString *selectedCity = [city objectAtIndex: 0];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
        
        picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, SCREENWIDTH, 216)];
        picker.dataSource = self;
        picker.delegate = self;
        picker.showsSelectionIndicator = YES;
        [picker selectRow: 0 inComponent: 0 animated: YES];
        [self addSubview:picker];
        selectedProvince = [province objectAtIndex: 0];
        
//        button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle: @"确定选择" forState: UIControlStateNormal];
//        [button setFrame: CGRectMake(20, 360, 280, 40)];
//        [button setBackgroundImage:[UIImage imageNamed:@"loginactivity_btn_nomal"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"loginactivity_btn_click"] forState:UIControlStateHighlighted];
//        [button setTintColor: [UIColor grayColor]];
//        [button addTarget: self action: @selector(buttobClicked:) forControlEvents: UIControlEventTouchUpInside];
//        button.alpha = 0.8;
//        [self addSubview:button];
        // Initialization code
        
        
            }
    return self;
}
- (void) buttobClicked:(id)sender {
    NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
    NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
    NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
    
    provinceStr = [province objectAtIndex: provinceIndex];
    cityStr = [city objectAtIndex: cityIndex];
    districtStr = [district objectAtIndex:districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
        districtStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }
    
    NSString *showMsg = [NSString stringWithFormat: @"%@ %@ %@.", provinceStr, cityStr, districtStr];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"您选择的是"
                                                    message: showMsg
                                                   delegate: self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: @"重新选择", nil];
    
    [alert show];
   
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

if(buttonIndex==alertView.cancelButtonIndex)
{

  if([_delegate respondsToSelector:@selector(sendCityStr:chengshi:quxiang:)])
  {
      [_delegate sendCityStr:provinceStr chengshi:cityStr quxiang:districtStr];
  
  }
    [UIView animateWithDuration:0.8f animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}else
{
    return;


}



}
#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province count];
    }
    else if (component == CITY_COMPONENT) {
        return [city count];
    }
    else {
        return [district count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [city objectAtIndex: row];
    }
    else {
        return [district objectAtIndex: row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == PROVINCE_COMPONENT) {
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%d", row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        
        city = [[NSArray alloc] initWithArray: array];
       
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        [picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: CITY_COMPONENT];
        [picker reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%d", [province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
       
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: DISTRICT_COMPONENT];
    }
    
    
    
    
    
    
    if([_delegate respondsToSelector:@selector(sendCityStr:chengshi:quxiang:)])
    {
        
        NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
        NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
        NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
        
        provinceStr = [province objectAtIndex: provinceIndex];
        cityStr = [city objectAtIndex: cityIndex];
        districtStr = [district objectAtIndex:districtIndex];
        
        if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
            cityStr = @"";
            districtStr = @"";
        }
        else if ([cityStr isEqualToString: districtStr]) {
            districtStr = @"";
        }
        

        [_delegate sendCityStr:provinceStr chengshi:cityStr quxiang:districtStr];
        
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}

#pragma mark - animation

- (void)showPicker:(UIView*)view
{
    self.hidden = NO;

    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         self.hidden = YES;
                         
                     }];
    
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
