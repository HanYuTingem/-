//
//  BookSeatModel.h
//  HCheap
//
//  Created by dairuiquan on 14-12-18.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PropertyString(s) @property (nonatomic, copy) NSString *s;
@interface BookSeatModel : NSObject

PropertyString(createTime)      //创建时间
PropertyString(customerId)      //用户ID
PropertyString(deleteFlag)      //删除状态 0 未删除1已删除
PropertyString(note)            //备注
PropertyString(operationState)  //操作状态 0待处理1已确认,2已完成 3已关闭
PropertyString(ownerId)         //商家ID
PropertyString(ownerName)       //信诺天下管理员",商家名称
PropertyString(phone)           //"18600546661",订座手机号码
PropertyString(seatId)          //订座ID
PropertyString(seatNumber)      //888888, 订座编号
PropertyString(seatPeople)      //订座人数
PropertyString(seatState)       //订座状态" 0等待中,1已确认,2已到店,3商家关闭
PropertyString(seatTime)       //":1418632736000, 订座时间
PropertyString(sex)             //性别 0 男 1女
PropertyString(updateTime)      //
PropertyString(userName)        //用户名
PropertyString(ownerDeleteFlag) //删除状态 0 未删除1已删除
PropertyString(readFlag)        //0 未读  1 以读
PropertyString(customerPhone)  //用户手机号

@end
