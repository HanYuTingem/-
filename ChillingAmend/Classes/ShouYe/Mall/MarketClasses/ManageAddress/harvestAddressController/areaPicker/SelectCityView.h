//
//  SelectCityView.h
//  行业版
//
//  Created by WangShandong on 13-12-3.
//  Copyright (c) 2013年 zhongke. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@protocol selectDelegate <NSObject>
-(void)sendCityStr:(NSString *)sStr chengshi:(NSString *)cStr quxiang:(NSString *)qStr;


@end
@interface SelectCityView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    UIPickerView *picker;
    UIButton *button;
    
    NSMutableDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;

}
@property (nonatomic,unsafe_unretained)id<selectDelegate> delegate;
- (void) buttobClicked: (id)sender;

- (void)showPicker:(UIView*)view;
- (void)cancelPicker;

@end
