//
//  CrazyBasisRequset.m
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisRequset.h"

#import "CrazyBasisViewController.h"
#import "shoppingCarViewController.h"
#import "MarketAPI.h"

@implementation CrazyBasisRequset


+(ASIHTTPRequest *)requestGetInClass:(id)controller andWithUrlString:(NSString *)string  Completion:(CompletionBlock)Completion  Failed:(FailedBlock)Failed
{

    
    NSString *url = [[NSString stringWithFormat:@"%@proIden=%@&%@",SHANGCHENG_url,PROINDEN,string] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url = %@",url);
    
    ASIHTTPRequest *requset = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    requset.delegate = self;
    [requset setPersistentConnectionTimeoutSeconds:15];
    [requset startAsynchronous];
    
    __block ASIHTTPRequest * requsetBlock = requset;
    __block CrazyBasisViewController *controllerBlick = controller;
    
    if (controller) {
        [(shoppingCarViewController *)controller startActivity];
        [controllerBlick.mRequsetArray addObject:requsetBlock];
        controllerBlick.view.userInteractionEnabled = YES;


    }
    
    [requset setCompletionBlock:^{
        if (controllerBlick) {
            [controllerBlick stopActivity];
            [controllerBlick.mRequsetArray removeObject:requsetBlock];

        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[requsetBlock responseData]  options:kNilOptions error:nil];
        Completion(dic);
        
    }];
    
    [requset setFailedBlock:^{
        NSError *error = [requsetBlock error];
        NSLog(@"%@",error);
        Failed(error);
        
        if (controllerBlick) {
            [controllerBlick stopActivity];
            [controllerBlick.mRequsetArray removeObject:requsetBlock];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"JIANCHAWANGLUO" object:nil userInfo:nil];
        }
    }];
    return requset;
}





+(ASIFormDataRequest *)requestPostInClass:(id)controller andWithUrlString:(NSString *)string andContentDic:(NSDictionary *)dic Completion:(CompletionBlock)Completion  Failed:(FailedBlock)Failed
{


    NSArray *keyArray = [dic allKeys];
    ASIFormDataRequest *requset = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",string]]];
    for (int i = 0; i < keyArray.count; i++) {
        [requset setPostValue:dic[keyArray[i]] forKey:keyArray[i]];
    }
    requset.delegate = self;
    [requset setPersistentConnectionTimeoutSeconds:15];
    [requset setRequestMethod:@"POST"];
    [requset startAsynchronous];
    __block shoppingCarViewController *controllerBlick = controller;
    __block ASIFormDataRequest * requsetBlock = requset;
    
    
    if (controller) {
        [(shoppingCarViewController *)controller startActivity];
        [controllerBlick.mRequsetArray addObject:requsetBlock];
        controllerBlick.view.userInteractionEnabled = YES;
    }
    
    [requset setCompletionBlock:^{
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[requsetBlock responseData]  options:kNilOptions error:nil];
        Completion(dic);
        
        if (controllerBlick) {
            [controllerBlick.mRequsetArray removeObject:requsetBlock];
            [controllerBlick stopActivity];
        }
    }];
    [requset setFailedBlock:^{
        NSError *error = [requsetBlock error];
        Failed(error);
        if (controllerBlick) {
            [controllerBlick stopActivity];
            [controllerBlick.mRequsetArray removeObject:requsetBlock];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"JIANCHAWANGLUO" object:nil userInfo:nil];
        }
    }];
    return requset;
    
}



@end
