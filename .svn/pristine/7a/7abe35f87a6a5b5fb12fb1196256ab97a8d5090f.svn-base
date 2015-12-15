//
//  LYQSelectPickerView.h
//  Chiliring
//
//  Created by nsstring on 14-9-24.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYQSelectPickerViewDelegate <NSObject>
@required
- (void)selectPickerViewWithDateStr:(NSString*)dateStr;
- (void)cancelPickerView;
@end

@interface LYQSelectPickerView : UIView

@property (nonatomic,strong)UIDatePicker *datePicker;

@property (nonatomic,assign) id<LYQSelectPickerViewDelegate>delegate;



@end
