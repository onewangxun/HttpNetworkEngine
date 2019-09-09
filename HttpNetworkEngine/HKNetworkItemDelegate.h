//
//  HKNetworkItemDelegate.h
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

@class HKNetworkItem;
/**
 *   AFN 请求封装的代理协议
 */
@protocol HKNetworkItemDelegate <NSObject>

@optional
/**
 *   请求结束
 *
 *   @param returnData 返回的数据
 */
- (void)requestDidFinishLoading:(NSDictionary*)returnData;
/**
 *   请求失败
 *
 *   @param error 失败的 error
 */
- (void)requestdidFailWithError:(NSError*)error;

/**
 *   网络请求项即将被移除掉
 *
 *   @param itme 网络请求项
 */
- (void)netWorkWillDealloc:(HKNetworkItem*)itme;

@end
