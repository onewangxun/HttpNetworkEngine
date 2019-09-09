//
//  HKNetworkHandler.m
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

#import "HKNetworkHandler.h"
#import "HKNetworkItem.h"
#import "HKNetwrok_Header.h"

@interface HKNetworkHandler ()<HKNetworkItemDelegate>
@end

@implementation HKNetworkHandler
+ (HKNetworkHandler *)sharedInstance{
    static HKNetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[HKNetworkHandler alloc] init];
    });
    return handler;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.networkError = NO;
    }
    return self;
}
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
            failureBlock:(HKFailureBlock)failureBlock{
    
    if (self.networkError == YES){
        //[self showAlertLostNetWork];
        if (failureBlock) {
            failureBlock(nil);
        }
        return nil;
    }
    
    if (params == nil){
        params = [NSMutableDictionary dictionary];
    }
    
    // 如果有一些公共处理，可以写在这里
    self.netWorkItem = [[HKNetworkItem alloc]initWithtype:networkType url:url params:params successBlock:successBlock failureBlock:failureBlock];
    self.netWorkItem.delegate = self;
    [self.items addObject:self.netWorkItem];
    return self.netWorkItem;
}

#pragma makr - 开始监听网络连接
+ (void)startMonitoring {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status){
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"************未知网络************");
                [HKNetworkHandler sharedInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"************没有网络************");
                [HKNetworkHandler sharedInstance].networkError = YES;
                 [[NSNotificationCenter defaultCenter]postNotificationName:KLostNetWorkNotificationName object:nil];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"************手机自带网络************");
                [HKNetworkHandler sharedInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"************WIFI************");
                [HKNetworkHandler sharedInstance].networkError = NO;
                break;
        }
    }];
    [mgr startMonitoring];
}
#pragma MARK - 网络状态监听
- (void)showAlertLostNetWork{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"网络丢失啦~请求开启网络权限" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL success) {
            }];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    
    UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
    while (topRootViewController.presentedViewController){
        topRootViewController = topRootViewController.presentedViewController;
    }
    [topRootViewController presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - HKNetworkItemDelegate
/**
 *   取消所有正在执行的所有网络请求项
 */
+ (void)cancelAllNetItems{
    HKNetworkHandler *handler = [HKNetworkHandler sharedInstance];
    [handler.items removeAllObjects];
    handler.netWorkItem = nil;
}
/**
 *  移除当前的请求
 */
- (void)netWorkWillDealloc:(HKNetworkItem *)itme{
    [self.items removeObject:itme];
    self.netWorkItem = nil;
}
#pragma mark - getter & setter
- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end

