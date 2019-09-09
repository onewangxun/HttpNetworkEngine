//
//  HKNetworHKanager.m
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

#import "HKNetworkManager.h"
#import "HKNetwrok_Header.h"

@implementation HKNetworkManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static HKNetworkManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
//返回单例
+(instancetype)sharedInstance {
    return [[super alloc] init];
}
#pragma mark - GET 请求
/**
 *   GET请求 一Block回调结果
 *
 *   @param url           ur
 *   @param params   paramsDict
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
            successBlock:(HKSuccessBlock)successBlock
            failureBlock:(HKFailureBlock)failureBlock{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[HKNetworkHandler sharedInstance] conURL:url networkType:HKNetWorkGET params:mutableDict successBlock:successBlock failureBlock:failureBlock];
}

#pragma mark - POST请求
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
              successBlock:(HKSuccessBlock)successBlock
              failureBlock:(HKFailureBlock)failureBlock{
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[HKNetworkHandler sharedInstance] conURL:url networkType:HKNetWorkPOST params:mutableDict successBlock:successBlock failureBlock:failureBlock];
    
}

@end

