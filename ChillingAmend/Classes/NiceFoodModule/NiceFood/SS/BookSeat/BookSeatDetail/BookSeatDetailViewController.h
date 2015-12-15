//
//  BookSeatDetailViewController.h
//  QQList
//
//  Created by sunsu on 15/7/6.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"

@protocol BookSeatDetailViewControllerDelegate <NSObject>
- (void)bookSeatStatusChange;
@end

@interface BookSeatDetailViewController : BaseViewController
@property (nonatomic, weak) id<BookSeatDetailViewControllerDelegate> delegate;

//@property (nonatomic, copy) NSString * orderStatus;     //订单转发太
//@property (nonatomic, copy) NSString * shopName;        //商家名
//@property (nonatomic, copy) NSString * time;            //订座时间
//@property (nonatomic, copy) NSString * customName;      //xx先生女士
//@property (nonatomic, copy) NSString * phoneNum;        //电话
//@property (nonatomic, copy) NSString * peopleNum;       //人数上限名额
@property (nonatomic, copy) NSString * oId;
@property (nonatomic, copy) NSString * seatId;          //订座id
@property (nonatomic, copy) NSString * operationState;  //操作状态 0待处理1已确认,2已完成 3已关闭
//@property (nonatomic, copy) NSString * note;            //备注
//@property (nonatomic, copy) NSString * sex;             //性别
//@property (nonatomic, assign) int    ownerDeleteFlag;   //判断是否被删除

@property (nonatomic, copy) NSString * ownerId;//商户Id

@property (nonatomic, assign) NSInteger status;//控制可否取消订单
@property (strong, nonatomic) UIButton * changeOrder;//修改订单
@property (strong, nonatomic) UIButton * cancelOrder;//取消订单
@property (strong, nonatomic) UIButton * deleteOrder;//删除订单

@end
