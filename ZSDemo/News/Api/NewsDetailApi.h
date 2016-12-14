//
//  NewsDetailApi.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailApi : NSObject

+ (void)getTopicDetailWithId:(nullable NSString *)topicId
                        Data:(nullable void (^)(NSDictionary * _Nullable dataDictionary))success;

@end
