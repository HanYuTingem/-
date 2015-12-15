//
//  AccountViewController.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/22.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "TakeoutRootViewController.h"

@interface AccountViewController : TakeoutRootViewController

@property (nonatomic, copy) NSString *name;    //商户名称
@property (nonatomic, strong) NSString *totalprice;     //商品总价
@property (nonatomic, copy) NSString *ownerId;          //商户id

@property (nonatomic, strong) NSArray *shoppingCartArray; //购物车页面数组

@end
