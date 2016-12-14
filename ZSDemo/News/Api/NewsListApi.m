//
//  NewsListApi.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "NewsListApi.h"
#import "APIRequestHandler.h"
#import "NewsListModel.h"

@implementation NewsListApi

+ (void)getTopicListDataWithPage:(NSInteger)page getData:(void (^)(NSMutableArray * _Nullable))success {
    NSDictionary *dicBody = @{@"article_class_id":@"", @"curpage":[NSString stringWithFormat:@"%zi", page]};
    NSString *httpUrl = [NSString stringWithFormat:@"%@?act=news&op=getNewsList&datetype=raw", HTTPHEADER];
    [APIRequestHandler POSTWithUrl:httpUrl Parameters:dicBody Success:^(id  _Nullable responseObject) {
        NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *datas = [obj objectForKey:@"datas"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in datas) {
            NewsListModel *listModel = [[NewsListModel alloc] initWithDictionary:dic error:nil];
            // 可以在此设置cell或者某一段文字的高度, 在布局的时候用
            //infor.cellHeight = [NSNumber numberWithInt:200];
            [array addObject:listModel];
        }
        success(array);
    } Failure:^(NSError * _Nonnull error) {
        
    }];
}


@end
