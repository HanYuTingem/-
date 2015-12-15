//



#import "DownLoadData.h"
#import "AFAppDotNetAPIClient.h"
#import "CouponModel.h"
#import "XiangqinMdel.h"
#import "MerchantsListModel.h"
@implementation DownLoadData

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts,NSString *str, NSError *error))block andWithdic:(NSDictionary*)dic {
    
    return [[AFAppDotNetAPIClient sharedClient] GET: NFM_URL parameters:dic success:^(NSURLSessionDataTask * __unused task, NSDictionary *JSON) {
        NSArray *apps = JSON[@"couponList"];
        NSString *total = JSON[@"total"];
        NSMutableArray *dataArr = [NSMutableArray array];
        [apps enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            CouponModel *mode = [CouponModel objectWithKeyValues:obj];
            
            [dataArr addObject:mode];
            
        }];
    
        if (block) {
            block(dataArr,total, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array],@"", error);
        }
    }];
}
+ (NSURLSessionDataTask *)delegeitTimelinePostsWithBlock:(void (^)(NSDictionary *posts, NSError *error))block andWithdic:(NSDictionary*)dic{
    return [[AFAppDotNetAPIClient sharedClient] GET: NFM_URL parameters:dic success:^(NSURLSessionDataTask * __unused task, NSDictionary *JSON) {
      
        if (block) {
            block(JSON, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSDictionary dictionary], error);
        }
    }];
}
+ (NSURLSessionDataTask *)tesitTimelinePostsWithBlock:(void (^)(NSArray *posts,NSArray *post, NSError *error))block andWithdic:(NSDictionary*)dic{
    return [[AFAppDotNetAPIClient sharedClient] GET: NFM_URL parameters:dic success:^(NSURLSessionDataTask * __unused task, NSDictionary*JSON) {
        NSLog(@"%@",JSON);
        NSMutableArray *xiangArr = [NSMutableArray array];
        NSMutableArray *dataArr = [NSMutableArray array];
        XiangqinMdel *modeXiang = [XiangqinMdel objectWithKeyValues:JSON];
        [xiangArr addObject:modeXiang];
        //获取商家列表
        NSArray *app = modeXiang.merchantsList;
        [app enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            MerchantsListModel *merMode = [MerchantsListModel objectWithKeyValues:obj];
            [dataArr addObject:merMode];
        }];
       
        
        if (block) {
            block(xiangArr,dataArr, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array],[NSArray array], error);
        }
    }];
}


@end
