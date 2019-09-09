//
//  HKNetworHKanager.h
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKNetworkDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface HKNetworkManager : NSObject
// 返回单例
+(instancetype)sharedInstance;

#pragma mark - 发送 GET 请求的方法

/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param params   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 */

+ (void)getRequstWithURL:(NSString *)url
                  params:(NSDictionary * _Nullable)params
            successBlock:(HKSuccessBlock)successBlock
            failureBlock:(HKFailureBlock)failureBlock;


#pragma mark - 发送 POST 请求的方法
/**
 *   通过 Block回调结果
 *   @param url           url
 *   @param params    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 */
+ (void)postReqeustWithURL:(NSString *)url
                    params:(NSDictionary * _Nullable)params
              successBlock:(HKSuccessBlock)successBlock
              failureBlock:(HKFailureBlock)failureBlock;

@end



NS_ASSUME_NONNULL_END
