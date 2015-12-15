//
//  ContactsView.h
//  HCheap
//
//  Created by JianDan on 14/12/17.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 *  联系人view
 */
#import <UIKit/UIKit.h>
@protocol ContactsViewDelegate <NSObject>
// 添加pickerView到控制器上
- (void)modifyNumberTell;
@end

@interface ContactsView : UIView<UITextFieldDelegate>
{
    UILabel *_womanLabel;
    UILabel *_manLabel;
    UIView *_lineView;
    UILabel *_numberTellLabel;
    
    UIButton *_womanBtn;
    UIButton *_manBtn;
    
    UIButton *_tellnumberBtn;
    
}

// 电话号
@property (nonatomic, strong)NSString *phone;
// 1-女 0-男
@property (nonatomic, strong)NSString *sex;
// 名字
@property (nonatomic, strong)NSString *name;
// 联系人姓名
@property (nonatomic, strong)UITextField *nameTextfield;

@property (nonatomic, weak)id<ContactsViewDelegate> contactsViewDelegate;

- (void)setOldPhone:(NSString *)oldPhone andOldName:(NSString *)oldName andOldSex:(NSString *)oldSex;

@end
