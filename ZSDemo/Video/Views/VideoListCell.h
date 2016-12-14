//
//  VideoListCell.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "BaseTableViewCell.h"
@class VideoListModel;
@interface VideoListCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *backgroundIV;
@property (strong, nonatomic) UILabel *timeDurationLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) UIButton *playBtn;

@property (nonatomic, strong) VideoListModel *videoModel;

@property (nonatomic, copy) void(^playBtnAction)(UIButton *button, VideoListModel *model);

@end
