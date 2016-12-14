//
//  NewsTableView.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "NewsTableView.h"
#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import "NewsListApi.h"
#import "JumpToOtherVCHandler.h"
#import "NewsDetailViewController.h"
#import <MJRefresh/MJRefresh.h>

static NSString *const NewsIdentifier = @"NewsIdentifier";

@interface NewsTableView ()

{
    NSInteger pageNumber;
}

@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation NewsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupTableView];
        pageNumber = 1;
        [self loadDataWithPage:pageNumber];
    }
    return self;
}

- (void)loadDataWithPage:(NSInteger)page {
    
    [NewsListApi getTopicListDataWithPage:page getData:^(NSMutableArray * _Nullable dataArray) {
        [self.dataArray addObjectsFromArray:dataArray];
        [self reloadData];
    }];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupTableView {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NewsIdentifier];
    self.rowHeight = 80.0f;
    self.tableFooterView = [UIView new];
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNumber = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf loadDataWithPage:pageNumber];
        [weakSelf.mj_header endRefreshing];
    }];
    
    self.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        pageNumber++;
        [weakSelf loadDataWithPage:pageNumber];
        [weakSelf.mj_footer endRefreshing];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsIdentifier];
    cell.listModel = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *VC = [[NewsDetailViewController alloc] init];
    NewsListModel *listModel = self.dataArray[indexPath.row];
    VC.articleId = listModel.article_id;
    VC.title = listModel.article_title;
    [JumpToOtherVCHandler pushToOtherView:VC animated:YES];
}


@end
