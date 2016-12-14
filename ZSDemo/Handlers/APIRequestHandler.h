//
//  APIRequestHandler.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/18.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequestHandler : NSObject

+ (void)GETWithUrl:(nullable NSString *)urlStr
        Parameters:(nullable id)parameters
           Success:(nullable void (^)(_Nullable id responseObject))success
           Failure:(nullable void (^)(NSError * _Nonnull error))failure;


+ (void)POSTWithUrl:(nullable NSString *)urlStr
         Parameters:(nullable id)parameters
            Success:(nullable void (^)(_Nullable id responseObject))success
            Failure:(nullable void (^)(NSError * _Nonnull error))failure;

@end
