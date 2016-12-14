//
//  VideoListCell.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "VideoListCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "VideoListModel.h"

@implementation VideoListCell

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self setConstraints];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [super updateConstraints];
}


- (void)setVideoModel:(VideoListModel *)videoModel {
    if (videoModel) {
        _videoModel = videoModel;
        [self loadData];
    }
}

- (void)loadData {
    self.titleLabel.text = self.videoModel.title;
    self.descriptionLabel.text = self.videoModel.descriptionDe;
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:self.videoModel.cover] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.countLabel.text = [NSString stringWithFormat:@"%ld.%ld万",_videoModel.playCount/10000,_videoModel.playCount/1000-_videoModel.playCount/10000];
    self.timeDurationLabel.text = [_videoModel.ptime substringWithRange:NSMakeRange(12, 4)];
}

- (void)setConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@30);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@30);
    }];
    [self.backgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@184);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundIV.mas_centerX);
        make.centerY.equalTo(self.backgroundIV.mas_centerY);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [self.timeDurationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundIV.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.backgroundIV.mas_bottom);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textColor = kRGBColor(100, 100, 100);
        _descriptionLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

- (UIImageView *)backgroundIV {
    if (!_backgroundIV) {
        _backgroundIV = [UIImageView new];
        _backgroundIV.userInteractionEnabled = YES;
        [self.contentView addSubview:_backgroundIV];
    }
    return _backgroundIV;
}

- (UILabel *)timeDurationLabel {
    if (!_timeDurationLabel) {
        _timeDurationLabel = [UILabel new];
        [self.contentView addSubview:_timeDurationLabel];
    }
    return _timeDurationLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        [self.contentView addSubview:_countLabel];

    }
    return _countLabel;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_playBtn];
    }
    return _playBtn;
}

- (void)playAction:(UIButton *)button {
    self.playBtnAction(button, self.videoModel);
}



@end
