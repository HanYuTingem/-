//
//  ChangePhoneNumViewController.h
//  QQList
//
//  Created by sunsu on 15/6/30.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"
/*
 *  更改手机号码界面  暂时不用
 */
@protocol ChangePhoneNumDelegate <NSObject>
- (void)changePhoneNum:(NSString *)phoneNum;
@end


@interface ChangePhoneNumViewController : BaseViewController
@property (nonatomic,strong)NSString * phonenum;
@property (nonatomic,assign)id<ChangePhoneNumDelegate> delegate;

@end
