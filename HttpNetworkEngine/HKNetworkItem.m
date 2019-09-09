//
//  HKNetworkItem.m
//  TestDemo
//
//  Created by wangxun on 2019/9/8.
//  Copyright © 2019 wangxun. All rights reserved.
//

#import "HKNetworkItem.h"
#import "HKNetwrok_Header.h"

@implementation HKNetworkItem

#pragma mark - 网络请求项

- (HKNetworkItem *)initWithtype:(HKNetWorkType)networkType
                            url:(NSString *)url
                         params:(NSDictionary *)params
                   successBlock:(HKSuccessBlock)successBlock
                   failureBlock:(HKFailureBlock)failureBlock{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 60.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
         __weak typeof(self)weakSelf = self;
        
        if (networkType==HKNetWorkGET){
            [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [HKSVProgressHUD showSuccessWithStatus:@"加载成功~"];
                if (successBlock){
                    successBlock(dict);
                }
                 [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [HKSVProgressHUD showErrorWithStatus:@"加载失败，请稍后再试~"];
                if (failureBlock) {
                    failureBlock(error);
                }
                  [weakSelf removewItem];
            }];
            
        }else{
            
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [HKSVProgressHUD showSuccessWithStatus:@"加载成功~"];
                if (successBlock) {
                    successBlock(dict);
                }
                [weakSelf removewItem];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [HKSVProgressHUD showErrorWithStatus:@"加载失败，请稍后再试~"];
                if (failureBlock) {
                    failureBlock(error);
                }
                [weakSelf removewItem];
            }];
            
        }
    }
    return self;
}

/**
 *   移除当前的网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

@end

