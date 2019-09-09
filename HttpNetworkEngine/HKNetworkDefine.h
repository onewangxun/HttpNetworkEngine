//
//  HKNetworkDefine.h
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//


/**
 *  请求类型
 */
typedef enum {
    HKNetWorkGET = 1,   /**< GET请求 */
    HKNetWorkPOST       /**< POST请求 */
} HKNetWorkType;

/**
 *  网络请求超时的时间
 */
#define HK_API_TIME_OUT 10


/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^HKStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^HKSuccessBlock)(NSDictionary *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^HKFailureBlock)(NSError *error);
/**
 *  上传数据回调
 *
 *  @param value 回调block
 */
typedef void (^HKProgressValueBlock)(double value);


