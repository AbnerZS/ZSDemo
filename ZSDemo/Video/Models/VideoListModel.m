//
//  VideoListModel.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "VideoListModel.h"

@implementation VideoListModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"descriptionDe": @"description"}];
}

@end
