//
//  GCRequest.h
//  aiGuoShi
//
//  Created by dreamRen on 13-3-19.
//  Copyright (c) 2013年 dreamRen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@protocol GCRequestDelegate;
@protocol LKIndicatorDelegate;
@interface GCRequest : NSObject<ASIHTTPRequestDelegate>{
    id <GCRequestDelegate> delegate;
    ASIFormDataRequest *mRequest;
    NSUInteger miMethod;
    BOOL isRequest;
    NSUInteger tag;
    
    UIView *mFHLView;
}

@property(nonatomic,retain) id <GCRequestDelegate> delegate;
@property(assign)NSUInteger tag;
@property(assign)BOOL isRequest;
@property(nonatomic,retain) id<LKIndicatorDelegate> lkIndicatorDelegate;
//发起get请求
-(void)requestHttpWithGet:(NSString*)aHttpString;
-(void)requestHttpWithGet:(NSString*)aHttpString withFHLView:(UIView*)aView;
//发起post请求
-(void)requestHttpWithPostNoLoading:(NSString*)aHttpString;
-(void)requestHttpWithPost:(NSString*)aHttpString;
-(void)requestHttpWithPosttoo:(NSString*)aHttpString;
-(void)requestImageHttpWithPost:(NSString*)aHttpString;
-(void)requestHttpWithPost:(NSString*)aHttpString withFHLView:(UIView*)aView;
//发起post请求
-(void)requestHttpWithPost:(NSString*)aHttpString withDict:(NSMutableDictionary*)aDict;
-(void)requestHttpWithPost:(NSString*)aHttpString withDict:(NSMutableDictionary*)aDict withFHLView:(UIView*)aView;

-(void)cancelRequest;

//get请求
+(void)requestHttpWithGet:(NSString*)aHttpString;

@end

@protocol GCRequestDelegate <NSObject>

@optional

-(void)GCRequest:(GCRequest*)aRequest Finished:(NSString*)aString;
-(void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError;

@end

@protocol LKIndicatorDelegate <NSObject>
@optional
-(void)startIndicatorDelegateWithContent:(NSString *)content;
-(void)stopIndicatorDelegate;
@end
