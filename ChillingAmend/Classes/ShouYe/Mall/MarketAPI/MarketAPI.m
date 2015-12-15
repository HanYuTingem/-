//
//  MarketAPI.m
//  MarketManage
//
//  Created by Rice on 15/1/10.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "MarketAPI.h"
#include <CommonCrypto/CommonDigest.h>
#import "BSaveMessage.h"
#import "GCRequest.h"
#import "CJAttributeModle.h"
#import "CJAttributeSpecModel.h"

/** 后来更换的模型 */
#import "ListModel.h"
@implementation MarketAPI

+(NSString *)judgeCostTypeWithCash:(NSString *)cash andIntegral:(NSString *)integral withfreight:(NSString*)freight withWrap:(BOOL)wrap
{
    NSString *cashResult = @"";
    NSString *integralResult = @"";
    if ([cash floatValue] + [freight floatValue] == 0.00) {
        cashResult = @"";
    }else{
        cashResult = [NSString stringWithFormat:@"￥%.2f",[cash floatValue] + [freight floatValue]];
    }
    if ([integral integerValue] == 0) { 
        integralResult = @"";
    }else{
        integralResult = [NSString stringWithFormat:@"%@%@",integral,INTERGRAL_NAME];
    }
    if ([cashResult isEqual:@""]) {
        return integralResult;
    }
    if ([integralResult isEqual:@""]) {
        return cashResult;
    }
    if (wrap) {
        //之前的有换行 积分在下面  现更改为在一行  15.9
//        return [[cashResult stringByAppendingString:@"\n+"] stringByAppendingString:integralResult];
        return [[cashResult stringByAppendingString:@"+"] stringByAppendingString:integralResult];
    }
    return [[cashResult stringByAppendingString:@"+"] stringByAppendingString:integralResult];
}

+(NSString *)judgeCostTypeWithCashF:(NSString *)cash andIntegral:(NSString *)integral withfreight:(NSString*)freight withWrap:(BOOL)wrap
{
    NSString *cashResult = @"";
    NSString *integralResult = @"";
    if ([cash floatValue] + [freight floatValue] == 0.00) {
        cashResult = @"";
    }else{
        cashResult = [NSString stringWithFormat:@"￥%.2f元",[cash floatValue] + [freight floatValue]];
    }
    if ([integral integerValue] == 0) {
        integralResult = @"";
    }else{
        integralResult = [NSString stringWithFormat:@"%@%@",integral,INTERGRAL_NAME];
    }
    if ([cashResult isEqual:@""]) {
        return integralResult;
    }
    if ([integralResult isEqual:@""]) {
        return cashResult;
    }
    if (wrap) {
//        return [[cashResult stringByAppendingString:@"\n+"] stringByAppendingString:integralResult];
        return [[cashResult stringByAppendingString:@"+"] stringByAppendingString:integralResult];
    }
    return [[cashResult stringByAppendingString:@"+"] stringByAppendingString:integralResult];
}

/** 计算加运费的价格 来自秒杀 ／购物车 ／商品详情
 */
+ (NSString*)judgeCostCashbuyType:(BOOL)seck crazy:(BOOL)crazy ms_price:(NSString*)ms_price  cash:(float)cash goodNums:(NSString*)good_num price:(float)price freigt:(NSString*)freigt crazyPrice:(NSString*)crazyPrice;
{
    
    NSString  * countPrice = @"";
    if(seck)
    {
      countPrice = [NSString stringWithFormat:@"%.2f元",[ms_price doubleValue] * [good_num integerValue] + [freigt doubleValue]];
    }else{
       
        if(crazy){
            
           countPrice = [self judgeCostTypeWithCash:[NSString stringWithFormat:@"%.2f",cash * [good_num integerValue]] andIntegral:[NSString stringWithFormat:@"%.0f",price* [good_num integerValue]]  withfreight:freigt  withWrap:YES];
        }else{
            
            if([crazyPrice rangeOfString:@"+"].location !=NSNotFound){
                NSString * Price = [[[[crazyPrice componentsSeparatedByString:@"+"]objectAtIndex:0]componentsSeparatedByString:@"￥"]objectAtIndex:1];
                
//                countPrice = [NSString stringWithFormat:@"￥%.2f元\n+%@",[Price floatValue] + [freigt doubleValue],[[crazyPrice componentsSeparatedByString:@"+"]objectAtIndex:1]];
                countPrice = [NSString stringWithFormat:@"￥%.2f元+%@",[Price floatValue] + [freigt doubleValue],[[crazyPrice componentsSeparatedByString:@"+"]objectAtIndex:1]];
                
            }else if([crazyPrice rangeOfString:@"￥"].location !=NSNotFound){
                NSString * Price = [[crazyPrice componentsSeparatedByString:@"￥"]objectAtIndex:1];
                countPrice = [NSString stringWithFormat:@"￥%.2f元",[Price floatValue] + [freigt doubleValue]];
                
            }else if([freigt doubleValue] ==0){
                
                countPrice = [NSString stringWithFormat:@"%@",crazyPrice];
                
                
            }else{
                //               countPrice = [NSString stringWithFormat:@"￥%.2f元\n+%@",[freigt doubleValue],crazyPrice];
                countPrice = [NSString stringWithFormat:@"￥%.2f元+%@",[freigt doubleValue],crazyPrice];
                
            }

        }
    }
   
    return countPrice;
}

+(BOOL)isHasSpecialcharacters:(NSString*)characters
{
    NSString *  englishNameRule = @"^[(A-Za-z0-9)*(\u4e00-\u9fa5)*(,|\\.|，|。|\\:|;|：|；|!|！|\\*|\\×|\\(|\\)|\\（|\\）|#|#|\\$|&#|\\$|&amp;|\\^|@|&#|\\$|&amp;|\\^|@|＠|＆|\\￥|\\……)*]+$";
    
    NSPredicate * englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    
    if ([englishpredicate evaluateWithObject:characters] == YES) {
        //implement
        return YES;
    }else{
        return NO;
        
    }
    
    
}

+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[039])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isHasNumder:(NSString*)numStr
{
    NSString *  englishNameRule = @"[A-Za-z]{2,}|[\u4e00-\u9fa5]{1,}[A-Za-z]+$";
    NSString * chineseNameRule =@"^[\u4e00-\u9fa5]{2,}$";
    
    NSPredicate * englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    NSPredicate *chinesepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseNameRule];
    
    if ([englishpredicate evaluateWithObject:numStr] == YES||[chinesepredicate evaluateWithObject:numStr] == YES) {
        //implement
        return YES;
    }else{
        return NO;
        
    }
    
}

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/** 设置红按钮 */
+(void)setRedButton:(UIButton *)redBtn
{
    UIColor *borderColor = [UIColor colorWithRed:184/255. green:6/255. blue:6/255. alpha:1];
    redBtn.layer.borderColor = borderColor.CGColor;
    redBtn.layer.borderWidth = 1;
    redBtn.layer.cornerRadius = 3;
    [redBtn setTitleColor:borderColor forState:UIControlStateNormal];
}

/** 设置灰按钮 */
+(void)setGrayButton:(UIButton *)grayBtn
{
    UIColor *borderColor = [UIColor colorWithRed:170/255. green:170/255. blue:170/255. alpha:1];
    grayBtn.layer.borderColor = borderColor.CGColor;
    grayBtn.layer.borderWidth = 1;
    grayBtn.layer.cornerRadius = 3;
    [grayBtn setTitleColor:borderColor forState:UIControlStateNormal];
}

/** 把时间戳转换为时间的格式 */
+(NSString*)getTimestamp:(NSString*)timeDate
{
    double create =[timeDate doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:create];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString *showtimeNew = [formatter1 stringFromDate:confromTimesp];
    return showtimeNew;
}
/** 把时间戳转换为时间的格式 */
+(NSString*)getTimesSubtamp:(NSString*)timeDate
{
    double create =[timeDate doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:create];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showtimeNew = [formatter1 stringFromDate:confromTimesp];
    return showtimeNew;
}

/** 第一个参数：要计算的字符串，第二个参数，lalbel的字体大小，第三个参数，label允许的最大尺寸。 */
+(CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

/** 转换字符串格式 参数1：要转换的字符串 参数2：转换前的格式 参数3：转换后的格式 */
+(NSString *)changeTimeFormat:(NSString *)timeStr andFormat1:(NSString *)format1 andFormat2:(NSString *)format2
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format1];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:format2];
    
    NSDate* date = [formatter dateFromString:timeStr];
    
    NSString *nowtimeStr = [formatter2 stringFromDate:date];
    return nowtimeStr;
}
/** 清空历史搜索记录 */
+(void)clearSearchHistroy
{
    NSUserDefaults *userDefatul = [NSUserDefaults standardUserDefaults];
    [userDefatul setObject:nil forKey:@"histroy"];
    [userDefatul synchronize];
}
/** 加载历史搜索记录 */
+(NSArray *)loadsearchHistroy
{
    NSUserDefaults *userDefatul = [NSUserDefaults standardUserDefaults];
    NSArray *histroyAry = [[NSArray alloc] init];

    if ([userDefatul objectForKey:@"histroy"] != nil) {
    histroyAry = [userDefatul objectForKey:@"histroy"];
    }
    return histroyAry;
}
/** 保存历史记录 */
+(void)saveSearchHistroy:(NSString *)histroy
{
    NSUserDefaults *userDefatul = [NSUserDefaults standardUserDefaults];
    NSMutableArray *histroyAry = [[NSMutableArray alloc] initWithArray:[userDefatul objectForKey:@"histroy"]];
    BOOL isRepeat = NO;
    for (int i =0 ; i < histroyAry.count; i++) {
        if ([histroy isEqual:histroyAry[i]]) {
            isRepeat = YES;
        }
    }
    if (!isRepeat) {
        if (histroyAry.count == 5) {
            [histroyAry removeLastObject];
        }
        [histroyAry insertObject:histroy atIndex:0];
        [userDefatul setObject:histroyAry forKey:@"histroy"];
        [userDefatul synchronize];
    }
}


/** 调转登陆页面 */
+(void)jumLoginControllerWithNavPush:(UINavigationController*)nav
{
    LoginViewController *loginPublic = [[LoginViewController alloc]init];
    loginPublic.viewControllerIndex = 2;
    [nav pushViewController:loginPublic animated:YES];
}


#pragma mark -  Reuqest Mothod

/** 首页页面 100端口*/
+ (GCRequest*)requestHomePost100WithController:(id)controller
{
    GCRequest  * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=100;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"100" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}
/** 推荐页面 * 109 端口*/
+ (GCRequest*)requestRecommedPost109WithController:(id)controller{
    
    GCRequest  *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=109;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"109" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:@"2" forKey:@"type"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;

}
/** 首页购物车数量 端口113*/
+ (GCRequest*)requestHomeCardNumPost113WithController:(id)controller
{
    GCRequest  *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=113;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"113" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
    
}
/** 商品详情 端口102 */
+ (GCRequest*)requestGoodsInfoPost102WithController:(id)controller goodsId:(NSString*)goodsId
{
//    goodsId = @"247";
    GCRequest *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=99;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"102" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(goodsId) forKey:@"id"];
    if (kkUserCenterId!=nil&&kkUserCenterId!=NULL) {
        [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    }
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];

    return lsyMainRequest;
}
/** 商品详情厂商介绍 端口103 good_shopId type为3 15.8改为属性规格 goods_id为商品ID type为1 */
+ (GCRequest*)requestChangshangInfoPost103Controller:(id)controller good_shopId:(NSString*)shopId goods_id:(NSString*)goodId type:(NSString*)type
{
//    shopId = @"247";
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"103" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    if ([type intValue] == 2) {
        [dict setObject:IfNullToString(shopId) forKey:@"id"];
    }else{
        [dict setObject:IfNullToString(goodId) forKey:@"id"];
    }
    [dict setObject:type forKey:@"type"];
    [lsyMainRequest setTag:[[NSString stringWithFormat:@"103%@",type]intValue]];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;

}
/** 秒杀详情 端口603
 * @parm goodsId 商品id
 * @pram huId   活动id
 */
+ (GCRequest*)requestMiaoShaPost603WithController:(id)controller good_id:(NSString*)goodsId hd_ID:(NSString*)huId
{
   GCRequest *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=603;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"603" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(goodsId) forKey:@"id"];
    if (huId!=nil) {
        [dict setObject:IfNullToString(huId) forKey:@"hd_id"];
    }
    if (kkUserCenterId!=nil&&kkUserCenterId!=NULL) {
        [dict setObject:kkUserCenterId forKey:@"user_id"];
    }
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];

    return lsyMainRequest;
}
/** 收藏商品 端口505
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestCollection505WithController:(id)controller good_id:(NSString*)goodsId
{
    GCRequest *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=505;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"505" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(goodsId) forKey:@"obj_id"];
    if (kkUserCenterId!=nil&&kkUserCenterId!=NULL) {
        [dict setObject:kkUserCenterId forKey:@"user_id"];
    }
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}
/** 取消收藏 端口507
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestCancelCollection507WithController:(id)controller good_id:(NSString*)goodsId
{
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=507;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"507" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(goodsId) forKey:@"obj_id"];
    if (kkUserCenterId!=nil&&kkUserCenterId!=NULL) {
        [dict setObject:kkUserCenterId forKey:@"user_id"];
    }
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}

/** 获取评论／购买咨询 端口104
 * @parm goodsId 商品id
 * @parm limit1:***;  //从第 $limit1 条开始查询数据
 * @parm limit2:***;  //一次加载共 $limit2 条数据
 * @parm type”: 1    //评论类型：1=售后评论，2=售前咨询
 */
+ (GCRequest*)requestEvlautionAndZiXun104WithController:(id)controller good_id:(NSString*)goodsId type:(int)type
{
    GCRequest *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=type;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"104" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:@"0" forKey:@"limit1"];
    [dict setObject:@"1" forKey:@"limit2"];
    [dict setObject:IfNullToString(goodsId) forKey:@"id"];
    [dict setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
 
    return lsyMainRequest;
}
/** 秒杀子活动列表 端口601 */
+ (GCRequest*)requestSeckillingList601WithController:(id)controller miaoshaId:(NSString *)miaosha_id
{
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=601;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"601" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(miaosha_id) forKey:@"id"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    
    return lsyMainRequest;
  
}
/** 秒杀列表 端口602*/
+ (GCRequest*)requestSeckillingActivyList602WithController:(id)controller huodongId:(NSString *)huodong_id pageIndex:(NSInteger)page_index tag:(NSInteger)tag
{
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=tag;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"602" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:@"10" forKey:@"pageSize"];
    [dict setObject:IfNullToString(huodong_id) forKey:@"id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page_index] forKey:@"pageNum"];
    NSString  * URL = @"";
    for (NSString * key in dict){
        URL = [NSString stringWithFormat:@"%@&%@=%@",URL,key,dict[key]];
    }
    
    NSString  * p = [NSString stringWithFormat:@"%@%@",SHANGCHENG_url,URL];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];

    return lsyMainRequest;
}
/** 立即购买 端口604
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestSeckillingBuy604WithController:(id)controller good_id:(NSString*)goodsId;
{
    GCRequest *lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag=604;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"604" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(goodsId) forKey:@"goods_id"];
    if (kkUserCenterId!=nil&&kkUserCenterId!=NULL) {
        [dict setObject:kkUserCenterId forKey:@"user_id"];
    }
    [dict setObject:kkUserName forKey:@"user_name"];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    [dict setObject:timeString forKey:@"order_time"];
    
    NSString * signStr=[NSString stringWithFormat:@"goods_id=%@&order_time=%@&por=604&proIden=%@&user_id=%@&user_name=%@",goodsId,timeString,PROINDEN,kkUserCenterId,kkUserName];
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:signStr]] forKey:@"sign"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}

/** 获取默认地址 端口5004*/
+ (ASIFormDataRequest*)requestMorenAddress5004WithController:(id)controller
{
     NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"5004" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
     return [self requestparams:dict WithTag:5004 controller:controller];
  
}
/** 获取运费
 * @pram goodsArray商品的数据
 * @pram model goods 数据模型
 * @pram seck 是否是秒杀
 */
+ (ASIFormDataRequest*)requestFeight107WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(ZXYCommitOrderRequestModel*)model goodInfo:(LSYGoodsInfo*)goods seckilling:(BOOL)seck
{
    /*
     运费请求
     “id”：1  //商品id；
     “num”：1//商品数量
     “type”1/2/3;// 快递方式：1=快递，2=EMS，3=平邮
     “address”：“北京-北京-丰台”//省-市-县
     */
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"107" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    //is_act: 1 //1活动商品，0非活动商品，0可不传该参数
    NSString *dictStr;
    //判断商品是否是从购物车过来 和是否从商品详情过来的
    if(goodsArray !=nil && goodsArray.count !=0){
        NSMutableArray *arr = [[NSMutableArray alloc]init];
//        for (CrazyShoppingCartShopModel * model in goodsArray){
            for (ListModel* subModel in goodsArray){
                NSMutableDictionary *dictJson = [@{@"goods_id":subModel.goods_id ,@"goods_num":[NSString stringWithFormat:@"%d",subModel.goods_nums],@"goods_cash":subModel.goods_cash,@"goods_price":subModel.price} mutableCopy];
                [arr addObject:dictJson];
//            }
        }
        dictStr = [arr JSONFragment];
    }else{
        
        //修改的传参
        NSMutableDictionary *dictJson = [@{@"goods_id":goods.goods_id ,@"goods_num":model.goods_nums,@"goods_cash":[NSString stringWithFormat:@"%f",goods.cash],@"goods_price":[NSString stringWithFormat:@"%f",goods.price]} mutableCopy];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:dictJson, nil];
        dictStr = [arr JSONFragment];
        
    }
    [dict setObject:dictStr forKey:@"goods"];
    NSString *signStr;
    if(seck){
        [dict setObject:@"1" forKey:@"is_act"];
        [dict setObject:goods.act_id forKey:@"act_id"];
        signStr = [NSString stringWithFormat:@"act_id=%@&address=%@&goods=%@&is_act=1&por=%@&proIden=%@",goods.act_id,model.area,dictStr,@"107",PROINDEN];
    }else{
        signStr = [NSString stringWithFormat:@"address=%@&goods=%@&por=%@&proIden=%@",model.area,dictStr,@"107",PROINDEN];
        
    }
    [dict setObject:model.area forKey:@"address"];
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:signStr]] forKey:@"sign"];
    NSString  * strff = @"";
    for (NSDictionary * key in dict){
        strff = [NSString stringWithFormat:@"%@%@=%@&",strff,key,dict[key]];
    }
    
    NSLog(@"8888%@%@",SHANGCHENG_url,strff);
    return [self requestparams:dict WithTag:107 controller:controller];
  
    
}

/** 202不是秒杀 605是秒杀 提交订单  2015.8更改
 * @pram goodsArray商品的数据
 * @pram model goods 数据模型
 * @pram seck 是否是秒杀
 */
+ (ASIFormDataRequest*)requestFeight202Or605WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(ZXYCommitOrderRequestModel*)model goodInfo:(LSYGoodsInfo*)goods my_sign:(NSString*)my_sign ms_sign:(NSString*)ms_sign  seckilling:(BOOL)seck attributeModel:(CJAttributeModle *)attributeModel
{
    NSString *invoiceCatogary = model.invoice_category;
    NSString *invoiceTitle = model.invoice_title;
    NSString *invoiceType = model.invoice_type;
    NSLog(@"%@",model.invoice_type);
    if ([invoiceCatogary isEqual:@"不开发票"]) {
        invoiceCatogary = @"";
        invoiceTitle = @"";
        invoiceType = @"";
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if(seck){
        [dict setObject:@"605" forKey:@"por"];
    }else{
        [dict setObject:@"202" forKey:@"por"];
    }
    NSLog(@"%@",dict);
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserName) forKey:@"user_name"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    
    NSString *dictStr;
    NSString  * carStatus;
    //判断商品是否是从购物车过来 和是否从商品详情过来的
    if(goodsArray !=nil &&goodsArray.count !=0){
        carStatus = @"1";
        [dict setObject:carStatus forKey:@"is_car"];
        //修改的传参 @"goods_specid":@""  添加的购物车属性
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        //        for (CrazyShoppingCartShopModel * model in goodsArray){
        for (ListModel * subModel in goodsArray){

            NSMutableArray *specArray = [NSMutableArray array];
            NSMutableDictionary *dictJson = [NSMutableDictionary dictionary];
            if (subModel.goods_specarr.count) {
                for (goodsAttributeModel *specModel in subModel.goods_specarr) {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:specModel.key,@"key",specModel.value,@"value", nil];
                    [specArray addObject:dic];
                }
                NSLog(@"%@",subModel.goods_specarr);
                dictJson = [@{@"goods_id":subModel.goods_id ,@"goods_num":[NSString stringWithFormat:@"%d",subModel.goods_nums],@"shop_id":subModel.shop_id,@"type":@"1",@"goods_specid":subModel.goods_specid,@"goods_specarr":specArray} mutableCopy];
                [arr addObject:dictJson];
            } else {//没有商品属性的时候 属性ID 和 商品属性都要赋空
                dictJson = [@{@"goods_id":subModel.goods_id ,@"goods_num":[NSString stringWithFormat:@"%d",subModel.goods_nums],@"shop_id":subModel.shop_id,@"type":@"1",@"goods_specid":@"",@"goods_specarr":@""} mutableCopy];
                [arr addObject:dictJson];
            }
        }
        
        dictStr = [arr JSONFragment];
        NSLog(@"dictStr ---- %@",dictStr);
    }else{
        //修改的传参  @"goods_specid":@""添加的购物车属性
        NSMutableDictionary *dictJson = [NSMutableDictionary dictionary];
        if (attributeModel.spec_idArray.count == 0) {
            dictJson.dictionary = @{@"goods_id":goods.goods_id ,@"goods_num":model.goods_nums,@"shop_id":goods.shop_id,@"type":@"1",@"goods_specid":@"",@"goods_specarr":@""};
        } else {
            
            NSMutableArray *specArray = [NSMutableArray array];
            for (CJAttributeSpecModel *specModel in attributeModel.spec_idArray) {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:specModel.key,@"key",specModel.value,@"value", nil];
                [specArray addObject:dic];
            }
            
            dictJson.dictionary = @{@"goods_id":goods.goods_id ,@"goods_num":model.goods_nums,@"shop_id":goods.shop_id,@"type":@"1",@"goods_specid":attributeModel.ModeleId,@"goods_specarr":specArray};
        }
        
        NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:dictJson, nil];
        dictStr = [arr JSONFragment];
        NSLog(@"dictStr ======---- %@",dictStr);
        
    }
    [dict setObject:dictStr forKey:@"goods"];
    
    NSLog(@"%@",model.note);
    [dict setObject:IfNullToString(model.note) forKey:@"note"];
    [dict setObject:IfNullToString(model.connect_name) forKey:@"connect_name"];
    [dict setObject:IfNullToString(model.connect) forKey:@"connect"];
    [dict setObject:[model.area stringByAppendingString:model.address] forKey:@"address"];
    [dict setObject:IfNullToString(model.rsa_yunfei) forKey:@"rsa_yunfei"];
    [dict setObject:IfNullToString(model.order_time) forKey:@"order_time"];
    [dict setObject:invoiceType forKey:@"invoice_type"];
    [dict setObject:invoiceTitle forKey:@"invoice_title"];
    [dict setObject:invoiceCatogary forKey:@"invoice_category"];
    
    
    NSString *sign;
    if (seck) {
        [dict setObject:my_sign forKey:@"my_sign"];
        [dict setObject:ms_sign forKey:@"ms_sign"];
        sign = [NSString stringWithFormat:@"address=%@&connect=%@&connect_name=%@&goods=%@&invoice_category=%@&invoice_title=%@&invoice_type=%@&ms_sign=%@&my_sign=%@&note=%@&order_time=%@&por=%@&proIden=%@&rsa_yunfei=%@&user_id=%@&user_name=%@",[model.area stringByAppendingString:model.address],model.connect,model.connect_name,dictStr,invoiceCatogary,invoiceTitle,invoiceType,ms_sign,my_sign,model.note,model.order_time,@"605",PROINDEN,model.rsa_yunfei,kkUserCenterId,kkUserName];
    }else{
        if(goodsArray ==nil && goodsArray.count ==0){
            [dict setObject:@"0" forKey:@"is_car"];
            carStatus = @"0";
        }
        
        sign = [NSString stringWithFormat:@"address=%@&connect=%@&connect_name=%@&goods=%@&invoice_category=%@&invoice_title=%@&invoice_type=%@&is_car=%@&note=%@&order_time=%@&por=%@&proIden=%@&rsa_yunfei=%@&user_id=%@&user_name=%@",[model.area stringByAppendingString:model.address],model.connect,model.connect_name,dictStr,invoiceCatogary,invoiceTitle,invoiceType,carStatus,model.note,model.order_time,@"202",PROINDEN,model.rsa_yunfei,kkUserCenterId,kkUserName];
    }
    
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:sign]] forKey:@"sign"];
    
    
    return [self requestparams:dict WithTag:202 controller:controller];
}


/** 202 605 提交订单
 * @pram goodsArray商品的数据
 * @pram model goods 数据模型
 * @pram seck 是否是秒杀
 */
+ (ASIFormDataRequest*)requestFeight202Or605WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(ZXYCommitOrderRequestModel*)model goodInfo:(LSYGoodsInfo*)goods my_sign:(NSString*)my_sign ms_sign:(NSString*)ms_sign  seckilling:(BOOL)seck
{
    NSString *invoiceCatogary = model.invoice_category;
    NSString *invoiceTitle = model.invoice_title;
    NSString *invoiceType = model.invoice_type;
    NSLog(@"%@",model.invoice_type);
    if ([invoiceCatogary isEqual:@"不开发票"]) {
        invoiceCatogary = @"";
        invoiceTitle = @"";
        invoiceType = @"";
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if(seck){
        [dict setObject:@"605" forKey:@"por"];
    }else{
        [dict setObject:@"202" forKey:@"por"];
    }
    NSLog(@"%@",dict);
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserName) forKey:@"user_name"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    
    NSString *dictStr;
    NSString  * carStatus;
    //判断商品是否是从购物车过来 和是否从商品详情过来的
    if(goodsArray !=nil &&goodsArray.count !=0){
        carStatus = @"1";
        [dict setObject:carStatus forKey:@"is_car"];
        
        //修改的传参 @"goods_specid":@""  添加的购物车属性
        NSMutableArray *arr = [[NSMutableArray alloc]init];
//        for (CrazyShoppingCartShopModel * model in goodsArray){
            for (ListModel * subModel in goodsArray){
                int i = 0;
                goodsAttributeModel *goodsModel = subModel.goods_specarr[i];

                NSLog(@"%@",goodsModel.key);
                NSLog(@"%@",goodsModel.value);
                NSMutableDictionary *dictJson = [@{@"goods_id":subModel.goods_id ,@"goods_num":[NSString stringWithFormat:@"%d",subModel.goods_nums],@"type":@"1",@"shop_id":subModel.shop_id,@"goods_specid":@""} mutableCopy];
                [arr addObject:dictJson];
                i++;
//            }
        }
        
        dictStr = [arr JSONFragment];
    }else{
        
        
        //修改的传参  @"goods_specid":@""添加的购物车属性
        NSMutableDictionary *dictJson = [@{@"goods_id":goods.goods_id ,@"goods_num":model.goods_nums,@"shop_id":goods.shop_id,@"type":@"1",@"goods_specid":@""} mutableCopy];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:dictJson, nil];
        dictStr = [arr JSONFragment];
        
    }
    [dict setObject:dictStr forKey:@"goods"];
    
    [dict setObject:IfNullToString(model.note) forKey:@"note"];
    [dict setObject:IfNullToString(model.connect_name) forKey:@"connect_name"];
    [dict setObject:IfNullToString(model.connect) forKey:@"connect"];
    [dict setObject:[model.area stringByAppendingString:model.address] forKey:@"address"];
    [dict setObject:IfNullToString(model.rsa_yunfei) forKey:@"rsa_yunfei"];
    [dict setObject:IfNullToString(model.order_time) forKey:@"order_time"];
    [dict setObject:invoiceType forKey:@"invoice_type"];
    [dict setObject:invoiceTitle forKey:@"invoice_title"];
    [dict setObject:invoiceCatogary forKey:@"invoice_category"];
    
    
    NSString *sign;
    if (seck) {
        [dict setObject:my_sign forKey:@"my_sign"];
        [dict setObject:ms_sign forKey:@"ms_sign"];
        sign = [NSString stringWithFormat:@"address=%@&connect=%@&connect_name=%@&goods=%@&invoice_category=%@&invoice_title=%@&invoice_type=%@&ms_sign=%@&my_sign=%@&note=%@&order_time=%@&por=%@&proIden=%@&rsa_yunfei=%@&user_id=%@&user_name=%@",[model.area stringByAppendingString:model.address],model.connect,model.connect_name,dictStr,invoiceCatogary,invoiceTitle,invoiceType,ms_sign,my_sign,model.note,model.order_time,@"605",PROINDEN,model.rsa_yunfei,kkUserCenterId,kkUserName];
    }else{
        if(goodsArray ==nil && goodsArray.count ==0){
            [dict setObject:@"0" forKey:@"is_car"];
            carStatus = @"0";
        }
        
        sign = [NSString stringWithFormat:@"address=%@&connect=%@&connect_name=%@&goods=%@&invoice_category=%@&invoice_title=%@&invoice_type=%@&is_car=%@&note=%@&order_time=%@&por=%@&proIden=%@&rsa_yunfei=%@&user_id=%@&user_name=%@",[model.area stringByAppendingString:model.address],model.connect,model.connect_name,dictStr,invoiceCatogary,invoiceTitle,invoiceType,carStatus,model.note,model.order_time,@"202",PROINDEN,model.rsa_yunfei,kkUserCenterId,kkUserName];
    }
    
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:sign]] forKey:@"sign"];
    
   
    return [self requestparams:dict WithTag:202 controller:controller];


}

+ (ASIFormDataRequest *)requestparams:(NSDictionary *)aDict WithTag:(NSInteger)tag controller:(id)controller
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[SHANGCHENG_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.timeOutSeconds = REQUEST_TIMEOUTSECONDS;
    request.delegate=controller;
    request.requestMethod=@"POST";
    request.tag = tag;
    if (aDict!=nil) {
        for(NSString *key in aDict){
            id value = [aDict objectForKey:key];
            [request setPostValue:value forKey:key];
        }
    }
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request startAsynchronous];
    return request;
}
/** U付 */

+(ASIFormDataRequest*)requestUfu204WithController:(id)controller commitModel:(ZXYCommitOrderRequestModel*)model act_Id:(NSString*)act_id
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:act_id forKey:@"is_act"];
    [dict setObject:@"204" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:model.orderNum forKey:@"order_num"];
    [dict setObject:@"3" forKey:@"pay_type"];
    [dict setObject:kkUserCenterId forKey:@"user_id"];
    NSString *sign = [NSString stringWithFormat:@"is_act=%@&order_num=%@&pay_type=%@&por=204&proIden=%@&user_id=%@",act_id,model.orderNum,@"3",PROINDEN,kkUserCenterId];
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:sign]] forKey:@"sign"];
    return [self requestparams:dict WithTag:1204 controller:controller];
}

/** 支付宝*/

+(ASIFormDataRequest*)requesZhiFuBao204WithController:(id)controller commitModel:(ZXYCommitOrderRequestModel*)model act_Id:(NSString*)act_id
{    
    NSString *sign = [NSString stringWithFormat:@"is_act=%@&order_num=%@&pay_type=%@&por=204&proIden=%@&user_id=%@",act_id,model.orderNum,model.pay_type,PROINDEN,kkUserCenterId];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:act_id forKey:@"is_act"];
    [dict setObject:@"204" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:model.orderNum forKey:@"order_num"];
    [dict setObject:model.pay_type forKey:@"pay_type"];
    [dict setObject:kkUserCenterId forKey:@"user_id"];
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:sign]] forKey:@"sign"];
    return [self requestparams:dict WithTag:204 controller:controller];


}

/** 订单列表 */
+(GCRequest*)requestOderList200WithController:(id)controller currenPage:(NSString*)currentPage requestStatus:(NSString*)requestStatus
{
     GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag = 200;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"200" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:@"20" forKey:@"pageSize"];
    [dict setObject:currentPage forKey:@"page"];
    [dict setObject:requestStatus forKey:@"status"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
   
}
/** 退款电话 208*/
+(GCRequest*)requestRefund208WithController:(id)controller
{
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag = 208;
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"208" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}
/** 删除订单 端口207*/

+(GCRequest*)requestDeleteOderList207WithCntroller:(id)controller oderNum:(NSString*)oderNum
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"207" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(oderNum) forKey:@"order_num"];
    [dict setObject:kkUserCenterId forKey:@"user_id"];
    
    NSString *signStr = [NSString stringWithFormat:@"order_num=%@&por=%@&proIden=%@&user_id=%@",dict[@"order_num"],dict[@"por"],dict[@"proIden"],kkUserCenterId];
    [dict setObject:[RSACrypto rsaEncryptionResult:[MarketAPI md5:signStr]] forKey:@"sign"];
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag = 207;
    lsyMainRequest.delegate=controller;
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}

/** 取消订单 端口203*/
+(GCRequest*)requestCancelOder203WithController:(id)controller oderNum:(NSString*)oderNum
{
    NSString * strVlue = [NSString stringWithFormat:@"order_num=%@&por=203&proIden=%@&user_id=%@",oderNum,PROINDEN,kkUserCenterId];
    NSString * str = [RSACrypto rsaEncryptionResult:[MarketAPI md5:strVlue]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"203" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(oderNum) forKey:@"order_num"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:IfNullToString(str) forKey:@"sign"];
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag = 203;
    lsyMainRequest.delegate=controller;
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}
/** 确认收货 端口205*/
+(GCRequest*)requestAffirm205WithController:(id)controller oderNum:(NSString*)oderNum
{
    NSString * strVlue = [NSString stringWithFormat:@"draw_type=2&order_num=%@&por=205&proIden=%@&user_id=%@",oderNum,PROINDEN,kkUserCenterId];
    NSString * str = [RSACrypto rsaEncryptionResult:[MarketAPI md5:strVlue]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"205" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(oderNum) forKey:@"order_num"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:@"2" forKey:@"draw_type"];
    [dict setObject:IfNullToString(str) forKey:@"sign"];
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag = 205;
    lsyMainRequest.delegate=controller;
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;

}

/** 订单详情 端口201*/
+(GCRequest*)requestoderDetail201WithController:(id)controller oderNum:(NSString*)oderNum
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"201" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(oderNum) forKey:@"order_num"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:@"2" forKey:@"draw_type"];
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.tag = 201;
    lsyMainRequest.delegate=controller;
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}

/** 评论列表 端口104*/

+(ASIFormDataRequest*)requestCommentList104WithController:(id)controller productId:(NSString*)product_Id limit:(NSInteger)limit_index type:(NSString*)type
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setObject:@"104" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:[NSString stringWithFormat:@"%d",limit_index] forKey:@"limit1"];
    [dict setObject:@"10" forKey:@"limit2"];
    [dict setObject:IfNullToString(product_Id) forKey:@"id"];
    [dict setObject:type forKey:@"type"];
    return [self requestparams:dict WithTag:104 controller:controller];

}

/** 发表评论/发表咨询 端口105*/

+(ASIFormDataRequest*)requestSendComment105WithController:(id)controller oderNum:(NSString*)oder_num contentArray:(NSArray*)contentArray type:(NSString*)type
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"105" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:kkUserCenterId forKey:@"user_id"];
    [dict setObject:kkUserName forKey:@"user_name"];
    [dict setObject:kkUserNickName forKey:@"nike_name"];
    [dict setObject:type forKey:@"type"];
    [dict setObject:IfNullToString(oder_num) forKey:@"order_num"];
    
       
    NSString *dictStr;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if([type isEqualToString:@"1"]){
        for (int i = 0; i<contentArray.count;i++){
            NSString * conte = contentArray[i][[NSString stringWithFormat:@"%dcontent",i]];
            if(![conte isEqualToString:@""]){
                NSMutableDictionary *dictJson = [@{@"id":contentArray[i][[NSString stringWithFormat:@"%did",i]] ,@"message":contentArray[i][[NSString stringWithFormat:@"%dcontent",i]]} mutableCopy];
                [arr addObject:dictJson];
            }
        }

    }else{
        [arr addObjectsFromArray:contentArray];
    }
    
    dictStr = [arr JSONFragment];
    [dict setObject:dictStr forKey:@"mes_goods"];
    return [self requestparams:dict WithTag:105 controller:controller];
  
    //打印
//    NSString * UER = @"";
//    for (NSString * key in dict){
//        
//        UER = [NSString stringWithFormat:@"%@&%@=%@",UER,key,dict[key]];
//    }
//    UER = [NSString stringWithFormat:@"%@%@",SHANGCHENG_url,UER];
    

}
/** 地址列表 端口5001*/
+(ASIFormDataRequest*)requestAddressList5001WithController:(id)controller
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"5001" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    return [self requestparams:dict WithTag:5001 controller:controller];

}
/**删除地址/设置默认地址 端口5003
 *@pram action_type 1删除 2 默认
 */
+(ASIFormDataRequest*)requestAddressDelete5003WithController:(id)controller oderNum:(NSString*)oder_num action:(NSString*)action_type tag:(NSInteger)tag;
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"5003" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(oder_num) forKey:@"id"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:IfNullToString(kkUserNickName) forKey:@"nike_name"];
    [dict setObject:IfNullToString(kkUserName) forKey:@"user_name"];
    [dict setObject:IfNullToString(action_type) forKey:@"action"];
    return [self requestparams:dict WithTag:tag controller:controller];


}
/**编辑地址 端口5002 */
+ (ASIFormDataRequest*)requestEdit5002WithController:(id)controller oderNum:(NSString*)oder_num addressCity:(NSString*)city detailAddress:(NSString*)address connectName:(NSString*)content_name iphone:(NSString*)connect_tel
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setObject:@"5002" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:IfNullToString(city) forKey:@"area"];
    if(![oder_num isEqualToString:@""]){
        [dict setObject:IfNullToString(oder_num) forKey:@"id"];
    }
    [dict setObject:IfNullToString(address) forKey:@"address"];
    [dict setObject:IfNullToString(content_name) forKey:@"connect_name"];
    [dict setObject:IfNullToString(connect_tel) forKey:@"connect_tel"];
    return [self requestparams:dict WithTag:5002 controller:controller];
    
}

/** 收藏的列表 端口506*/
+ (ASIFormDataRequest*)requestCollectList506WithController:(id)controller pageIndex:(NSString*)page_index
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"506" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:@"10" forKey:@"pageSize"];
    [dict setObject:IfNullToString(page_index) forKey:@"page"];
    return [self requestparams:dict WithTag:506 controller:controller];
    
}
/** 删除收藏的数据 端口507*/
+ (ASIFormDataRequest*)requestDeleteCollectList507WithController:(id)controller goodId:(NSString*)good_id
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"507" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:IfNullToString(good_id) forKey:@"obj_id"];
    return [self requestparams:dict WithTag:507 controller:controller];
}


/** 全部分类 端口114 cate_id 为0时是一级分类请求 其他的为相应请求 */
+ (GCRequest *)requestAllCategories114WithController:(id)controller cate_id:(NSString *)cate_id
{
    GCRequest * lsyMainRequest=[[GCRequest alloc]init];
    lsyMainRequest.delegate=controller;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"114" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:cate_id forKey:@"cate_id"];
    [lsyMainRequest setTag:[cate_id intValue]];
    [lsyMainRequest requestHttpWithPost:SHANGCHENG_url withDict:dict];
    return lsyMainRequest;
}

/** 意见反馈（新增） 端口1001 information联系方式 message反馈内容 type反馈类型 1功能意见 2页面意见 3新需求 4操作 */
+ (ASIFormDataRequest *)requestFeedback1001WithController:(id)controller information:(NSString *)information message:(NSString *)message type:(NSString *)type
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1001" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:IfNullToString(kkUserName) forKey:@"user_name"];
    [dict setObject:IfNullToString(kkUserNickName) forKey:@"nike_name"];
    [dict setObject:information forKey:@"information"];
    [dict setObject:type forKey:@"type"];
    [dict setObject:message forKey:@"message"];
    
    return [self requestparams:dict WithTag:1001 controller:controller];
}
/** 购物车（新增） 清除失效的 商品端口116 */
+(ASIFormDataRequest *)requestInvaild116WithController:(id)controller information:(NSString *)cart_ID {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"116" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:cart_ID forKey:@"cart_id"];
    return [self requestparams:dict WithTag:116 controller:controller];
}

/** 判断文字 最多显示textNum个汉字 textNum*2个字母 数字 textNum是显示的个数 textName是文字 */
+ (NSString *)labelTextNumConfineWithTextNum:(int)textNum textName:(NSString *)textName
{
    //判断文字 最多显示四个汉字 8个字母 数字
    NSMutableString *strName = [NSMutableString stringWithFormat:@"%@",textName];
    if (textName.length > textNum) {
        strName.string = @"";
        int num = 0;
        for (int i = 0; i < textName.length; i++) {
            NSRange range = {i,1};
            NSString *strSub = [textName substringWithRange:range];
            const char *cString = [strSub UTF8String];
            if (strlen(cString) == 1) {
                num++;
                if (num <= textNum * 2) {
                    [strName appendString:strSub];
                } else break;
            } else if(strlen(cString) == 3){
                num += 2;
                if (num <= textNum * 2) {
                    [strName appendString:strSub];
                } else break;
            }
        }
    }
    return strName;
}

@end
