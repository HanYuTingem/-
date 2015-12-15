//
//  UserShoppingAddorRemoveModel.m
//  MarketManage
//
//  Created by fielx on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingAddorRemoveModel.h"

#import "CrazyBasisRequset.h"
#import "MarketAPI.h"






@implementation CrazyShoppingAddorRemoveModel



+(void)crazyShoppingAddorRemoveModelType:(CrazyShoppingAddorRemoveModelType)type loadController:(id)controller  goodsId:(NSString *)goodsId completeBlock:(completeBlock)block
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:@"111" forKey:@"por"];
    
    [dic setObject:PROINDEN forKey:@"proIden"];

    [dic setObject:kkUserCenterId forKey:@"user_id"];


    if (type == CrazyShoppingAddorRemoveModelTypeAdd) {
        [dic setObject:@"1" forKey:@"type"];
        
        [dic setObject:goodsId forKey:@"goods_id"];
    }
    else {
        
        [dic setObject:goodsId forKey:@"cat_id"];
        [dic setObject:@"2" forKey:@"type"];
    }
    
   
    /** 需要添加的商品属性的数组 */
//    [dic setObject:goodsId forKey:@"spec_arr"];
    
//    [dic setObject:goodsId forKey:@"spec_id"];
    
    [CrazyBasisRequset requestPostInClass:controller andWithUrlString:SHANGCHENG_url andContentDic:dic Completion:^(NSDictionary *dic) {
        
        NSLog(@"加入购物车 %@",dic);
      
            block(dic);
        
    } Failed:^(NSError *error) {
            block(dic);
    }];
}

/**
 * 15.8.11添加 type添加或删除 goodsId商品的ID spec_arr属性选择后的属性数组 spec_id属性选择后的具体商品ID nums 购买的商品数量
 */
+(void)crazyShoppingAddorRemoveModelType:(CrazyShoppingAddorRemoveModelType)type loadController:(id)controller  goodsId:(NSString *)goodsId goodsAttributeArray:(NSArray *)spec_arr goodsAttributeId:(NSString *)spec_id goodsAttributeNums:(NSString *)nums isupdate:(BOOL)isupdate completeBlock:(completeBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:@"111" forKey:@"por"];
    
    [dict setObject:PROINDEN forKey:@"proIden"];
    
    [dict setObject:kkUserCenterId forKey:@"user_id"];
    
    [dict setObject:goodsId forKey:@"goods_id"];
    
    if (type == CrazyShoppingAddorRemoveModelTypeAdd) {
        [dict setObject:@"1" forKey:@"type"];
    }
    else {
        [dict setObject:@"2" forKey:@"type"];
    }
    if (isupdate == YES) {
        [dict setObject:@"1" forKey:@"isupdate"];
    }else{
        [dict setObject:@"0" forKey:@"isupdate"];
    }
    
    //将数组转换成 json字符串
    
    NSString *str = [spec_arr JSONFragment];
    
    if (spec_arr.count == 0) {
        str = @"";
        spec_id = @"";
    }
    
//    NSData *JsonData = [NSJSONSerialization dataWithJSONObject:spec_arr options:kNilOptions error:nil];
//    NSLog(@"JsonData  --- %@",JsonData);

    
    /** 需要添加的商品属性的数组 */
    [dict setObject:str forKey:@"spec_arr"];
    
    [dict setObject:spec_id forKey:@"spec_id"];
    
    [dict setObject:nums forKey:@"nums"];
    
    [CrazyBasisRequset requestPostInClass:controller andWithUrlString:SHANGCHENG_url andContentDic:dict Completion:^(NSDictionary *dic) {
        
        NSLog(@"加入购物车 %@",dic);
        
        block(dic);
        
    } Failed:^(NSError *error) {
        block(dict);
    }];

}


@end
