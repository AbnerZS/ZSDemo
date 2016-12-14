//
//  NewsListModel.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsListModel : JSONModel

@property (nonatomic, strong)NSString<Optional> *article_id;
@property (nonatomic, strong)NSString<Optional> *article_title;
@property (nonatomic, strong)NSString<Optional> *article_class_id;
@property (nonatomic, strong)NSString<Optional> *article_abstract;
@property (nonatomic, strong)NSString<Optional> *article_image;
@property (nonatomic, strong)NSString<Optional> *article_publish_time;
@property (nonatomic, strong)NSString<Optional> *article_click;

@end
