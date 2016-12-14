//
//  NewsTableViewCell.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageViewController.h"
#import "JumpToOtherVCHandler.h"

@implementation NewsTableViewCell

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self setConstraints];
    
    [super updateConstraints];
}


- (void)setListModel:(NewsListModel *)listModel {
    if (listModel) {
        _listModel = listModel;
        [self loadData];
    }
}

- (void)loadData {
    self.topicTitle.text = self.listModel.article_title;
    self.topicContent.text = self.listModel.article_abstract;
    [self.topicImg sd_setImageWithURL:[NSURL URLWithString:self.listModel.article_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)setConstraints {
    [self.topicTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.topicImg.mas_left).offset(-5);
        make.height.equalTo(@20);
    }];
    [self.topicContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicTitle.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.topicImg.mas_left).offset(-5);
        make.height.equalTo(@50);
    }];
    [self.topicImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.width.equalTo(@70);
        make.height.equalTo(@70);
    }];
}



- (UILabel *)topicTitle {
    if (!_topicTitle) {
        _topicTitle = [UILabel new];
        _topicTitle.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:_topicTitle];
    }
    return _topicTitle;
}

- (UILabel *)topicContent {
    if (!_topicContent) {
        _topicContent = [UILabel new];
        _topicContent.numberOfLines = 3;
        _topicContent.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_topicContent];
    }
    return _topicContent;
}

- (UIImageView *)topicImg {
    if (!_topicImg) {
        _topicImg = [UIImageView new];
        [self.contentView addSubview:_topicImg];
        _topicImg.contentMode = UIViewContentModeScaleAspectFill;
        _topicImg.clipsToBounds = YES;
        _topicImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_topicImg addGestureRecognizer:tap];
    }
    return _topicImg;
}

- (void)tapAction {
    ImageViewController *imgVC = [[ImageViewController alloc] init];
    imgVC.imgStr = self.listModel.article_image;
    
    [JumpToOtherVCHandler pushToOtherView:imgVC animated:YES];
}



@end
