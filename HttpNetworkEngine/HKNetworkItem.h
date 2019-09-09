//
//  HKNetworkItem.h
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKNetworkDefine.h"
#import "HKNetworkItemDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  网络请求子项
 */
@interface HKNetworkItem : NSObject

/**
 *  网络请求方式
 */
@property (nonatomic, assign) HKNetWorkType networkType;

/**
 *  网络请求URL
 */
@property (nonatomic, strong) NSString *url;

/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSDictionary *params;


/**
 *  网络请求的委托
 */
@property (nonatomic, assign) id<HKNetworkItemDelegate>delegate;


#pragma mark - 创建一个网络请求项，开始请求网络

/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *  @return MHAsiNetworkItem对象
 */
- (HKNetworkItem *)initWithtype:(HKNetWorkType)networkType
                            url:(NSString *)url
                         params:(NSDictionary * _Nullable)params
                   successBlock:(HKSuccessBlock)successBlock
                   failureBlock:(HKFailureBlock)failureBlock;


@end


NS_ASSUME_NONNULL_END
