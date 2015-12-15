//
//  Toos.m
//  LaoYiLao
//
//  Created by wzh on 15/10/29.
//  Copyright (c) 2015年 王兆华. All rights reserved.
//

#import "LYLTools.h"

@interface WZHButton()

@property (nonatomic, copy) MyBlock tempBlock;

@end

@implementation WZHButton
+ (WZHButton *)buttonWithFrame:(CGRect)frame fontSize:(int)size title:(NSString *)title type:(UIButtonType)type tag:(int)tag backgroundImage:(NSString *)backgroundImage image:(NSString *)image andBlock:(MyBlock)myBlock{
    
    WZHButton *button = [WZHButton buttonWithType:type];//按钮类型
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];//设置标题
    [button.titleLabel setFont:[UIFont systemFontOfSize:size]];//字体大小
    [button setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];//设置背景图片
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];//设置图片
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];//方法
    button.tag = tag;
    
    button.tempBlock = myBlock;//myBlock给tempBlock
    
    return button;
    
    
}

+ (WZHButton *)buttonWithFrame:(CGRect)frame
                     fontSize:(int)size
                        title:(NSString *)title
                        image:(NSString *)image
                     andBlock:(MyBlock)myBlock{
    
    WZHButton *button = [WZHButton buttonWithType:UIButtonTypeCustom];//按钮类型
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];//设置标题
    [button.titleLabel setFont:[UIFont systemFontOfSize:size]];//字体大小
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];//设置图片
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];//方法
    button.tempBlock = myBlock;//myBlock给tempBlock
    return button;
}

+ (WZHButton *)buttonWithFrame:(CGRect)frame
                     fontSize:(UIFont *)fontsize
                        title:(NSString *)title
                        backgroundSelectImage:(NSString *)backgroundSelectImage
        backgroundNormalImage:(NSString *)backgroundNormalImage
                     andBlock:(MyBlock)myBlock{
    
    WZHButton *button = [WZHButton buttonWithType:UIButtonTypeCustom];//按钮类型
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];//设置标题
    [button.titleLabel setFont:fontsize];//字体大小
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundImage: [UIImage imageNamed:backgroundNormalImage] forState:UIControlStateNormal];//设置图片
    [button setBackgroundImage: [UIImage imageNamed:backgroundNormalImage] forState:UIControlStateSelected];//设置图片
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];//方法
    button.tempBlock = myBlock;//myBlock给tempBlock
    return button;
}
- (void)buttonClicked:(WZHButton *)button{
    button.tempBlock(button);//返回button
    
}

@end

@implementation LYLTools



+ (void)file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format, ...
{
#ifdef TARGET_IPHONE_DEBUG
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    va_list ap;
    NSString *print, *file, *function;
    va_start(ap,format);
    file = [[NSString alloc] initWithBytes: sourceFile length: strlen(sourceFile) encoding: NSUTF8StringEncoding];
    
    function = [NSString stringWithCString:functionName encoding:NSUTF8StringEncoding];
    print = [[NSString alloc] initWithFormat: format arguments: ap];
    va_end(ap);
    NSLog(@"%@:%d %@; %@\n\n", [file lastPathComponent], lineNumber, function, print);
    
#endif
}


/**
 求字符串CGSize私有方法
 */
+(CGSize)sizeOfString:(NSString*)str andLabelSize:(CGSize) labelSize andFontSize:(UIFont *)font{
    return [str boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+ (float)labWithStringW:(NSString*)str andLabelHeight:(float)labelHeight andFontSize:(UIFont *)font{
    CGSize size = [LYLTools sizeOfString:str andLabelSize:CGSizeMake(0, labelHeight) andFontSize:font];
    return size.width;
}

//计算UILabel的高度
+ (CGSize)contentSizeWithLabString:(NSString*)strTest labelWidth:(CGFloat)width font:(UIFont *)font{
    UILabel *currentLab;
    [currentLab setNumberOfLines:0];
    currentLab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    
    currentLab.font = font;
    
    CGSize size = CGSizeMake(width,9999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    
    CGSize labelsize = [strTest sizeWithFont:font constrainedToSize:size lineBreakMode:currentLab.lineBreakMode];
    return labelsize;
}

//求label高度
+ (CGFloat)boundingRectWithStrH:(NSString*)string labStrW:(CGFloat)labStrW andFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(labStrW,9999);//LableWight标签宽度，固定的

    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    return retSize.height;
}

+ (CGFloat)boundingRectWithStrW:(NSString*)string labStrH:(CGFloat)labStrH andFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(99999,labStrH);//LableWight标签宽度，固定的
    
    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    return retSize.width;
}

+(void)connectedToNetwork:(connectedToNetBlock)type{
    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring ];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *Network = @"";
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                Network = @"当前无网络";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                Network = @"正在使用Wifi";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                Network = @"正在使用蜂窝移动网络";
                break;
            }
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"AFNetworkReachabilityStatusUnknown");
                break;
            }
            default:
                break;
        }
        
        type(Network);
    } ];
}

+ (void)didConnectionStateChangedBlock:(void(^)(AFNetworkReachabilityStatus netWorkStatusChangeBlock))didConnectionStateChanged{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        didConnectionStateChanged(status);
    }];
}

+ (void)didConnectionStateChangedIsSuccessful:(void (^)())connectionSuccessful andFailure:(void(^)())connectionFailure;
{
    
    [LYLTools didConnectionStateChangedBlock:^(AFNetworkReachabilityStatus netWorkStatusChangeBlock) {
        if(netWorkStatusChangeBlock == AFNetworkReachabilityStatusNotReachable){
            connectionFailure();
        }else{
            connectionSuccessful();
        }
        
    }];
}

+ (void)didConnectionStateChangedIsSuccessfulStatus:(void (^)(AFNetworkReachabilityStatus networkStatus))connectionSuccessfulWithState andFailure:(void(^)())connectionFailure{
    [LYLTools didConnectionStateChangedBlock:^(AFNetworkReachabilityStatus netWorkStatusChangeBlock) {
        if(netWorkStatusChangeBlock == AFNetworkReachabilityStatusNotReachable){
            connectionFailure();
        }else{
            connectionSuccessfulWithState(netWorkStatusChangeBlock);
        }
        
    }];
}


+ (void)didConnectionStateChanged:(void (^)())didConnectionStateChanged{
    [LYLTools didConnectionStateChangedBlock:^(AFNetworkReachabilityStatus netWorkStatusChangeBlock) {
        didConnectionStateChanged();
    }];
}


//字典转字符串
+(NSString *)JsonWithDict:(NSDictionary*)dict{
    NSError *error ;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (void)showInfoAlert:(NSString*)aInfo{
    UIAlertView *tAlert=[[UIAlertView alloc] initWithTitle:@"提示" message:aInfo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [tAlert show];
}

//拉伸图片
+ (UIImage *)resizedImageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


+ (UIImage*)scaleImage:(UIImage*)aImage ToSize:(CGSize)aSize
{
    float iImageWidth=aSize.width;
    float iImageHeight=aSize.height;
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(iImageWidth, iImageHeight));
    // 绘制改变大小的图片
    [aImage drawInRect:CGRectMake(0, 0, iImageWidth, iImageHeight)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//正则判断手机号码地址格式
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,178,182,187,188
     * 联通：130,131,132,152,155,156,176,185,186
     * 电信：133,1349,153,177,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|78)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 177,133,1349,153,180,189
     22         */
    NSString * CT = @"^1((77|33|53|8[039])[0-9]|349)\\d{7}$";
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

+ (NSString *)currentDateWithDay{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    NSArray *timeStr = [currentDateStr componentsSeparatedByString:@"-"];
   return [timeStr lastObject];
}


+ (void)removeBounceViewWithVC:(UIViewController *)vc{
    for (UIView *subView in vc.navigationController.view.subviews){
        if([subView isKindOfClass:[BouncedView class]]){
            [subView removeFromSuperview];
        }
    }
}
+ (NSMutableArray *)modelArrayWithJson:(NSMutableArray *)array{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *subDic in array) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        [dataArray addObject:model];
    }
    return dataArray;
}

+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


+ (NSString *)getPhoneUuid {
    UIDevice * device = [[UIDevice alloc]init];
    return [device uniqueDeviceIdentifier];
}

/**
 * @brief 显示正在加载进度视图
 * @param N/A
 * @return N/A
 */
+(void)showloadingProgressView
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.delegate = nil;
}

/**
 * @brief 隐藏加载进度视图
 * @param N/A
 * @return N/A
 */
+(void)hideloadingProgressView
{
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
}


+ (void)addSaveCacheInLoginWithJson:(id)json{
//    ZHLog(@"登陆信息%@",json);
}


+ (void)removeCacheAndOutLogin{
    MySetObjectForKey(@"", UserIDKey);
    //清除缓存饺子信息
//    NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
//    [dumplingInforArray removeAllObjects];
//    [dumplingInforArray writeToFile:DumplingInforNoLogingPath atomically:YES];
    
    //清除缓存饺子信息
    NSMutableArray *dumplingLogingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
    [dumplingLogingInforArray removeAllObjects];
    [dumplingLogingInforArray writeToFile:DumplingInforLogingPath atomically:YES];
}


+ (CGFloat)todayTotalMoneyWithPath:(NSString *)path{
    CGFloat totalMoney = 0.00;
    NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:path];
    for (NSDictionary *subDic in dumplingInforArray) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        if([model.resultListModel.dumplingModel.dumplingType isEqualToString:DumplingTypeMoney]){
            totalMoney = totalMoney +  [model.resultListModel.dumplingModel.prizeAmount floatValue];
        }
    }
    return totalMoney;
}

+ (void)removeDumplingInforOfFailureWithPath:(NSString *)path{
    
    ZHLog(@"%d,%d",[MyObjectForKey(DumplingNoLogingTimeKey) intValue],[[LYLTools currentDateWithDay]intValue]);
    
    NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:path];
    if(!dumplingInforArray){
        dumplingInforArray = [[NSMutableArray alloc]init];
    }
    //当前时间和过去比较看是否失效
    if([MyObjectForKey(DumplingNoLogingTimeKey) intValue] != [[LYLTools currentDateWithDay]intValue]){
        [dumplingInforArray removeAllObjects];//饺子失效 清除缓存
        NSLog(@"饺子失效，清除过期饺子信息成功");
    }
//    [self isYESorNONowdate:(NSDate *) andLastDate:<#(NSDate *)#>]
    if([dumplingInforArray writeToFile:path atomically:YES]){
        NSLog(@"清除饺子信息过程后信息保存成功");
    }else{
        NSLog(@"清除饺子信息过程后信息保存失败");
    }
}



+ (BOOL)isYESorNONowdate:(NSDate *)nowDate andLastDate:(NSDate *)lastDate{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if ((int)(([nowDate timeIntervalSince1970] + timezoneFix)/(24*3600)) -(int)(([lastDate timeIntervalSince1970] + timezoneFix)/(24*3600)) == 0){
        return YES;
    }else
        return NO;
}
@end
