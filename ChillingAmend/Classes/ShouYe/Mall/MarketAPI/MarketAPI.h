//
//  MarketAPI.h
//  MarketManage
//
//  Created by Rice on 15/1/10.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "UIBarButtonItem+IW.h"
#import "RSACrypto.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NSString+SBJSON.h"
#import "ZXYIndicatorView.h"
#import "BSaveMessage.h"

#import "GCRequest.h"
#import "ASIFormDataRequest.h"
#import "ZXYCommitOrderRequestModel.h"
#import "LSYGoodsInfo.h"
#import "CrazyShoppingCartShopModel.h"
#import "CrazyShoppingCartShopCommodityModel.h"
#import "JSON.h"
#import "CJAttributeModle.h"

@class ZXYCommitOrderRequestModel;

#pragma mark - 商城需要修改的地方 
/*
 APPNAME :项目名称
 ZHIFUBAOAPPSCHEME：跳转的标志 一般在info - URL 添加
 PROINDEN： 产品表示
 SHANGCHENG_url: 更换环境
 kkUserCenterId ： 个人中心的用户id
 INTERGRAL_NAME    积分名称
1、登陆页面 ：需要在商品详情里面 收藏和立即购买 还有发表咨询判断用户是否登陆没有跳转登陆页面
2、callOutShareGoodS 分享的方法 就一个地方存在分享
3、sourceApplication APPdelegate里面实现 跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
4、在支付订单的页面 code＝27 把积分不足替换你需要的哪种币不足
 
 lib 为第三库  mall文件包替换
 */

#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

//判断字段时候为空的情况
#define IfNullToString(x)  ([(x) isEqual:[NSNull null]]||(x)==nil)?@"":TEXTString(x)
#define TEXTString(x) [NSString stringWithFormat:@"%@",x]  //转换为字符串

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) //判读是否是640*1136的屏幕

#define ORIGIN_X(o_x) o_x.frame.origin.x       //x
#define ORIGIN_Y(o_y) o_y.frame.origin.y       //y
#define FRAMNE_W(f_w) f_w.frame.size.width     //width
#define FRAMNE_H(f_h) f_h.frame.size.height    //height

#pragma mark - Request

#define APPNAME @"黑土"
//积分名称
#define  INTERGRAL_NAME @"积分"
//请求的时间 20s
#define REQUEST_TIMEOUTSECONDS 20
//支付宝的回调名称 再URL 设置
#define ZHIFUBAOAPPSCHEME @"HeiTuDiApp"

//#define PROINDEN @"9291c40ec1cec1281638720c74c7245f"  //辽宁卫视的产品标识
#define PROINDEN @"XN01_LNTV_HT"    //黑土的产品标识
//#define PROINDEN @"cf18f7feae8a9e6daa1876e1383fffea"   //食话食说的产品标识
//#define PROINDEN @"a2a52e0476b94ff5489b348b4ce17aab"  //乐玩互动的产品标识
//#define PROINDEN @"fbe7f2d5075352686f61d256c80ff0a3"  //天天乐玩的产品标识
//#define PROINDEN @"25f70260a81487f1682f6fa470384ccb"//红枸杞的产品标识
//#define PROINDEN @"136cb41573bd7e272b555bd5351b660e"//黑龙江新闻的产品标识

//压测
//#define SHANGCHENG_url                        @"http://192.168.10.12:80/app/"

//测试
//#define SHANGCHENG_url                        @"http://192.168.10.11:8013/app/"

//测试购物车
//#define SHANGCHENG_url                          @"http://192.168.10.11:8013/app_v1.2.0/?"

//test环境
//#define  SHANGCHENG_url                       @"http://malltest.sinosns.cn/app_v1.2.0/?"

//正式
//#define SHANGCHENG_url                        @"http://mall.sinosns.cn/app_v1.2.0/?"

//2015.7 测试版
//#define SHANGCHENG_url                        @"http://192.168.10.11:8013/app_v1.3.0/?"

// 商城 1.3.0 test 测试

//#define    SHANGCHENG_url                @"http://malltest.sinosns.cn/app_v1.3.0/?"
//#warning 这条请求数据是要被删除的  换成 SHANGCHENG_url

//商城 全部分类
//#define MallCategories_url                    @"http://192.168.10.11:8013/app_v1.3.0/?"

#pragma mark - 充值

//正式
#define  ReCharge  @"http://sjchongzhi.sinosns.cn/app.jsp"

//测试
//#define  ReCharge  @"http://192.168.10.86:9011/top-up/app.jsp?"

//test测试
//#define  ReCharge  @"http://java.test.sinosns.cn/top-up/app.jsp?"
#define  CHONGZHI  @"2e9f4615-3ef5-479b-bca7-c8458a2b6d21"


@interface MarketAPI : NSObject

/** 现金+积分数据显示
*/
+(NSString *)judgeCostTypeWithCash:(NSString *)cash andIntegral:(NSString *)integral withfreight:(NSString*)freight withWrap:(BOOL)wrap;
/** 现金+积分数据显示
 */
+(NSString *)judgeCostTypeWithCashF:(NSString *)cash andIntegral:(NSString *)integral withfreight:(NSString*)freight withWrap:(BOOL)wrap;
/** 计算加运费的价格 来自秒杀 ／购物车 ／商品详情
 */
+ (NSString*)judgeCostCashbuyType:(BOOL)seck crazy:(BOOL)crazy ms_price:(NSString*)ms_price  cash:(float)cash goodNums:(NSString*)good_num price:(float)price freigt:(NSString*)freigt crazyPrice:(NSString*)crazyPrice;

/**判断是否谈有特殊字符
 */
+(BOOL)isHasSpecialcharacters:(NSString*)characters;

/**正则判断手机号码地址格式
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;

/**判断是否输入中文 或者 英文
 */
+(BOOL)isHasNumder:(NSString*)numStr;

/**订单md5加密
 */
+(NSString *)md5:(NSString *)str;

/**设置红按钮
 */
+(void)setRedButton:(UIButton *)redBtn;

/**设置灰按钮
 */
+(void)setGrayButton:(UIButton *)grayBtn;

/**把时间戳转换为时间的格式
 */
+(NSString*)getTimestamp:(NSString*)timeDate;
/** 把时间戳转换为时间的格式 */
+(NSString*)getTimesSubtamp:(NSString*)timeDate;

/**
 计算字符串高度
 第一个参数：要计算的字符串，第二个参数，lalbel的字体大小，第三个参数，label允许的最大尺寸。
 */
+(CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

/**转换字符串格式 参数1：要转换的字符串 参数2：转换前的格式 参数3：转换后的格式
 */
+(NSString *)changeTimeFormat:(NSString *)timeStr andFormat1:(NSString *)format1 andFormat2:(NSString *)format2;
/**清空搜索历史记录
 */
+(void)clearSearchHistroy;
/**读取搜索历史记录
 */
+(NSArray *)loadsearchHistroy;

/**存一条搜索历史记录
 */
+(void)saveSearchHistroy:(NSString *)histroy;

/** 调转登陆页面 */
+(void)jumLoginControllerWithNavPush:(UINavigationController*)nav;



#pragma mark Request Modth

/** 首页的请求删除 端口100 */

+ (GCRequest*)requestHomePost100WithController:(id)controller;

/** 首页推荐商品 端口109 */

+ (GCRequest*)requestRecommedPost109WithController:(id)controller;

/** 首页购物车数量 端口113*/
+ (GCRequest*)requestHomeCardNumPost113WithController:(id)controller;


/** 商品详情 端口102 
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestGoodsInfoPost102WithController:(id)controller goodsId:(NSString*)goodsId;

/** 商品详情厂商介绍 端口103
 * @parm shopId 商家id  15.8 改为属性规格
 * @pram goodId 商品id
 * @pram type   @"1" 商城的地址 3为属性规格
 */
+ (GCRequest*)requestChangshangInfoPost103Controller:(id)controller good_shopId:(NSString*)shopId goods_id:(NSString*)goodId type:(NSString*)type;

/** 秒杀详情 端口603
 * @parm goodsId 商品id
 * @pram huId   活动id
 */
+ (GCRequest*)requestMiaoShaPost603WithController:(id)controller good_id:(NSString*)goodsId hd_ID:(NSString*)huId;

/** 收藏商品 端口505
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestCollection505WithController:(id)controller good_id:(NSString*)goodsId;

/** 取消收藏 端口507
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestCancelCollection507WithController:(id)controller good_id:(NSString*)goodsId;

/** 获取评论／购买咨询 端口104
 * @parm goodsId 商品id
 * @parm limit1:***;  //从第 $limit1 条开始查询数据
 * @parm limit2:***;  //一次加载共 $limit2 条数据
 * @parm type”: 1    //评论类型：1=售后评论，2=售前咨询
 */
+ (GCRequest*)requestEvlautionAndZiXun104WithController:(id)controller good_id:(NSString*)goodsId type:(int)type;

/** 秒杀子活动列表 端口601 */
+ (GCRequest*)requestSeckillingList601WithController:(id)controller miaoshaId:(NSString *)miaosha_id;

/** 秒杀列表 端口602*/
+ (GCRequest*)requestSeckillingActivyList602WithController:(id)controller huodongId:(NSString *)huodong_id pageIndex:(NSInteger)page_index tag:(NSInteger)tag;


/** 立即购买 端口604
 * @parm goodsId 商品id
 */
+ (GCRequest*)requestSeckillingBuy604WithController:(id)controller good_id:(NSString*)goodsId;

/** 获取默认地址 端口5004*/

+ (ASIFormDataRequest*)requestMorenAddress5004WithController:(id)controller;

/** 获取运费 107
* @pram goodsArray商品的数据
* @pram model goods 数据模型
* @pram seck 是否是秒杀
*/
+ (ASIFormDataRequest*)requestFeight107WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(ZXYCommitOrderRequestModel*)model goodInfo:(LSYGoodsInfo*)goods seckilling:(BOOL)seck;

/** 202 605 提交订单*/

+ (ASIFormDataRequest*)requestFeight202Or605WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(ZXYCommitOrderRequestModel*)model goodInfo:(LSYGoodsInfo*)goods my_sign:(NSString*)my_sign ms_sign:(NSString*)ms_sign  seckilling:(BOOL)seck;

/** 202不是秒杀 605是秒杀 提交订单  2015.8更改
 * @pram goodsArray商品的数据
 * @pram model goods 数据模型
 * @pram seck 是否是秒杀
 */
+ (ASIFormDataRequest*)requestFeight202Or605WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(ZXYCommitOrderRequestModel*)model goodInfo:(LSYGoodsInfo*)goods my_sign:(NSString*)my_sign ms_sign:(NSString*)ms_sign  seckilling:(BOOL)seck attributeModel:(CJAttributeModle *)attributeModel;


/** U付 端口204*/

+(ASIFormDataRequest*)requestUfu204WithController:(id)controller commitModel:(ZXYCommitOrderRequestModel*)model act_Id:(NSString*)act_id;

/** 支付宝 端口204*/

+(ASIFormDataRequest*)requesZhiFuBao204WithController:(id)controller commitModel:(ZXYCommitOrderRequestModel*)model act_Id:(NSString*)act_id;

/** 订单列表  端口200*/
+(GCRequest*)requestOderList200WithController:(id)controller currenPage:(NSString*)currentPage requestStatus:(NSString*)requestStatus;

/** 退款电话 208*/
+(GCRequest*)requestRefund208WithController:(id)controller;

/** 删除订单 端口207*/

+(GCRequest*)requestDeleteOderList207WithCntroller:(id)controller oderNum:(NSString*)oderNum;

/** 取消订单 端口203*/
+(GCRequest*)requestCancelOder203WithController:(id)controller oderNum:(NSString*)oderNum;

/** 确认收货 端口205*/
+(GCRequest*)requestAffirm205WithController:(id)controller oderNum:(NSString*)oderNum;

/** 订单详情 端口201*/
+(GCRequest*)requestoderDetail201WithController:(id)controller oderNum:(NSString*)oderNum;

/** 评论列表 端口104*/

+(ASIFormDataRequest*)requestCommentList104WithController:(id)controller productId:(NSString*)product_Id limit:(NSInteger)limit_index type:(NSString*)type;

/** 发表评论/发表咨询 端口105*/
+(ASIFormDataRequest*)requestSendComment105WithController:(id)controller oderNum:(NSString*)oder_num contentArray:(NSArray*)contentArray type:(NSString*)type;

/** 地址列表 端口5001*/
+(ASIFormDataRequest*)requestAddressList5001WithController:(id)controller;

/**删除地址/设置默认地址 端口5003
 *@pram action_type 1删除 2 默认
 */
+(ASIFormDataRequest*)requestAddressDelete5003WithController:(id)controller oderNum:(NSString*)oder_num action:(NSString*)action_type tag:(NSInteger)tag;

/**编辑/保存地址 端口5002 */
+ (ASIFormDataRequest*)requestEdit5002WithController:(id)controller oderNum:(NSString*)oder_num addressCity:(NSString*)city detailAddress:(NSString*)address connectName:(NSString*)content_name iphone:(NSString*)connect_tel;

/** 收藏的列表 端口506*/
+ (ASIFormDataRequest*)requestCollectList506WithController:(id)controller pageIndex:(NSString*)page_index;

/** 删除收藏的数据 端口507*/
+ (ASIFormDataRequest*)requestDeleteCollectList507WithController:(id)controller goodId:(NSString*)good_id;


#pragma mark - 2015.7增加
/** 全部分类 端口114 cate_id 为0时是一级分类请求 其他的为相应请求 */
+ (GCRequest *)requestAllCategories114WithController:(id)controller cate_id:(NSString *)cate_id;

/** 意见反馈（新增） 端口1001 information联系方式 message反馈内容 type反馈类型 1功能意见 2页面意见 3新需求 4操作 */
+ (ASIFormDataRequest *)requestFeedback1001WithController:(id)controller information:(NSString *)information message:(NSString *)message type:(NSString *)type;



/** 购物车（新增） 清除失效的 商品端口116 */
+(ASIFormDataRequest *)requestInvaild116WithController:(id)controller information:(NSString *)cart_ID ;




/** GDH 修改 提交订单  202 605*/
//+ (ASIFormDataRequest*)requestFeight202Or605WithController:(id)controller goodsArray:(NSArray*)goodsArray commitModel:(NSArray *) goodInfo:(LSYGoodsInfo*)goods my_sign:(NSString*)my_sign ms_sign:(NSString*)ms_sign  seckilling:(BOOL)seck;

/** 判断文字 最多显示textNum个汉字 textNum*2个字母 数字 textNum是显示的个数 textName是文字 */
+ (NSString *)labelTextNumConfineWithTextNum:(int)textNum textName:(NSString *)textName;

@end
