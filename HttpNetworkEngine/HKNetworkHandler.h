//
//  HKNetworkHandler.h
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKNetworkDefine.h"

@class HKNetworkItem;

NS_ASSUME_NONNULL_BEGIN

@interface HKNetworkHandler : NSObject

/**
 *  单例
 *
 *  @return HKNetworkHandler的单例对象
 */
+ (HKNetworkHandler *)sharedInstance;

/**
 *  items
 */
@property(nonatomic,strong)NSMutableArray *items;

/**
 *   单个网络请求项
 */
@property(nonatomic,strong, nullable)HKNetworkItem *netWorkItem;

/**
 *  networkError
 */
@property(nonatomic,assign)BOOL networkError;

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param networkType  网络请求方式
 *  @param params       网络请求参数
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 根据网络请求的委托delegate而生成的唯一标示
 */
- (HKNetworkItem*)conURL:(NSString *)url
             networkType:(HKNetWorkType)networkType
                  params:(NSMutableDictionary *)params
            successBlock:(HKSuccessBlock)successBlock
            failureBlock:(HKFailureBlock)failureBlock;

/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems;
@end


NS_ASSUME_NONNULL_END
