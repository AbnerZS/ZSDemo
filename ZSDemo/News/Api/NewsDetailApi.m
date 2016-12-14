//
//  NewsDetailApi.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "NewsDetailApi.h"
#import "APIRequestHandler.h"

@implementation NewsDetailApi

+ (void)getTopicDetailWithId:(NSString *)topicId Data:(void (^)(NSDictionary * _Nullable))success {
    
    NSDictionary *dicBody = @{@"article_id":topicId};
    NSString *httpUrl = [NSString stringWithFormat:@"%@?act=news&op=getDetail&datetype=raw", HTTPHEADER];
    [APIRequestHandler POSTWithUrl:httpUrl Parameters:dicBody Success:^(id  _Nullable responseObject) {
        NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(obj);
    } Failure:^(NSError * _Nonnull error) {
        
    }];
    
}

@end
