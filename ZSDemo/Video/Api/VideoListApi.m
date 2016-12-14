//
//  VideoListApi.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "VideoListApi.h"
#import "APIRequestHandler.h"
#import "VideoListModel.h"

@implementation VideoListApi

+ (void)getVideoListData:(void (^)(NSMutableArray * _Nullable))success {
    NSString *httpUrl = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/0-10.html"];
    
    [APIRequestHandler GETWithUrl:httpUrl Parameters:nil Success:^(id  _Nullable responseObject) {
        NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *datas = [obj objectForKey:@"videoList"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *video in datas) {
            VideoListModel *model = [[VideoListModel alloc] initWithDictionary:video error:nil];
            
//            if ([model.descriptionDe isEqualToString:@""] || model.descriptionDe == nil || model.descriptionDe.length < 3) {
//                model.descriptionHeight = [NSNumber numberWithFloat:0];
//            } else {
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0f], NSFontAttributeName, nil];
//                CGRect rect = [model.descriptionDe boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:dic context:nil];
//                CGFloat height = rect.size.height;
//                
//                
//                model.descriptionHeight = [NSNumber numberWithFloat:height];
//            }
            [array addObject:model];
        }
        success(array);
    } Failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
