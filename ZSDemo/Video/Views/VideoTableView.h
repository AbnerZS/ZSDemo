//
//  VideoTableView.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/25.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "BaseTableView.h"
@class VideoListModel;
@class VideoPlayer;

@interface VideoTableView : BaseTableView

@property (nonatomic, strong) VideoPlayer *videoPlayer;
@property (nonatomic, copy) void(^updateStatusBar)();

-(void)toCell;
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation;
-(void)toSmallScreen;

-(void)releaseWMPlayer;
@end
