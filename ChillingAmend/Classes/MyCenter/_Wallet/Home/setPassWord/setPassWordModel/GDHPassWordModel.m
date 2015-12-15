//
//  GDHPassWordModel.m
//  Wallet
//
//  Created by GDH on 15/10/24.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#define PassWordFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"passWord.data"]

#import "GDHPassWordModel.h"

@implementation GDHPassWordModel
/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.oldPayPassword = [aDecoder decodeObjectForKey:@"oldPayPassword"];
        self.payPassword = [aDecoder decodeObjectForKey:@"payPassword"];
        self.newpayPassword = [aDecoder decodeObjectForKey:@"newPayPassword"];

    }
    return self;
}
/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.oldPayPassword forKey:@"oldPayPassword"];
    [aCoder encodeObject:self.payPassword forKey:@"payPassword"];
    [aCoder encodeObject:self.newpayPassword forKey:@"newPayPassword"];

}
/** 归档 */
+(void)save:(GDHPassWordModel *)passWord{
    [NSKeyedArchiver archiveRootObject:passWord toFile:PassWordFilepath];
}

/** 读取账号 */
+(GDHPassWordModel *)passWord{
    GDHPassWordModel *passWord_passWord =  [NSKeyedUnarchiver unarchiveObjectWithFile:PassWordFilepath];
    return passWord_passWord;
}
@end
