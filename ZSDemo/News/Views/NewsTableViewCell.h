//
//  NewsTableViewCell.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "BaseTableViewCell.h"
@class NewsListModel;


@interface NewsTableViewCell : BaseTableViewCell


@property (nonatomic, strong) UILabel *topicTitle;
@property (nonatomic, strong) UILabel *topicContent;
@property (nonatomic, strong) UIImageView *topicImg;
@property (nonatomic, strong) NewsListModel *listModel;

@end
