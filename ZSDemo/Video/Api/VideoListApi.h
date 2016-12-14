//
//  VideoListApi.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoListApi : NSObject

+ (void)getVideoListData:(nullable void (^)(NSMutableArray * _Nullable dataArray))success;

@end
