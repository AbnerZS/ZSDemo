//
//  APIRequestHandler.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/18.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "APIRequestHandler.h"
#import "AFNetworking.h"

#define TIMEOUT 15

static BOOL canCheckNetwork = NO;

@implementation APIRequestHandler

+ (void)GETWithUrl:(NSString *)urlStr Parameters:(id)parameters Success:(void (^)(id _Nullable))success Failure:(void (^)(NSError * _Nonnull))failure {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开始监听
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        canCheckNetwork = YES;//网络监听已经启动
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                break;
            }
            default:
                break;
        }
    }];
    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    //BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    //BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    //网络有问题
    if(isOK == NO && canCheckNetwork == YES){
        NSError *error = [NSError errorWithDomain:@"网络错位" code:100 userInfo:nil];
        failure(error);
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    //请求超时时间设置
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 杀掉其他网络线程
    //[manager.operationQueue cancelAllOperations];
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求数据出现错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

+ (void)POSTWithUrl:(NSString *)urlStr Parameters:(id)parameters Success:(void (^)(id _Nullable))success Failure:(void (^)(NSError * _Nonnull))failure {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开始监听
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        canCheckNetwork = YES;//网络监听已经启动
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                break;
            }
            default:
                break;
        }
    }];
    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    //BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    //BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    //网络有问题
    if(isOK == NO && canCheckNetwork == YES){
        NSError *error = [NSError errorWithDomain:@"网络错位" code:100 userInfo:nil];
        failure(error);
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //请求超时时间设置
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 杀掉其他网络线程
    //[manager.operationQueue cancelAllOperations];
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络状态" message:@"亲,网络不给力,请检查网络设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}

@end
