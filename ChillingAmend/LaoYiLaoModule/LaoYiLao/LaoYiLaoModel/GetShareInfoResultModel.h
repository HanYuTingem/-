//
//  GetShareInfoResultModel.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/11.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetShareInfoResultModel : NSObject
/*
 “title”:" 疯狂的饺子” //标题
“content” :” 疯狂的饺子！众明星携手为你包饺子，捞一捞，1亿现金等你拿！” 内容
“picurl”:”url”//图片地址
“url”:” url”//跳转地址
*/
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * picurl;
@property (nonatomic, copy) NSString * url;

+(GetShareInfoResultModel *)getShareInfoResultModelWithDic:(NSDictionary *)dic;
@end
