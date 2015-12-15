//
//  GDHBalanceDetailModel.h
//  Wallet
//
//  Created by GDH on 15/10/28.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHBalanceDetailModel : NSObject

/**
 {“rsno”:  101 系统错误,
 “description”:”There’s an error.” //错误说明
 “productCode”:””      //业务名称
 “content”:”发生接口”     //提示消息内容
 “infoUrl”:”16341654”     //提示消息的url
 “rs”:
*/
/** 系统错误 */
@property (nonatomic,copy) NSString *rsno;
/** 错误说明 */
@property (nonatomic,copy) NSString *description_description;
/** 业务名称 */
@property (nonatomic,copy) NSString *productCode;
/** 提示消息内容 */
@property (nonatomic,copy) NSString *content;
/** 提示消息的url */
@property (nonatomic,copy) NSString *infoUrl;

//@property (nonatomic,strong) NSArray *rs;



@end
