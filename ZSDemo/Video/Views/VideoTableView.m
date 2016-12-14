//
//  VideoTableView.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/25.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "VideoTableView.h"
#import "VideoListCell.h"
#import "VideoListApi.h"
#import "VideoListModel.h"
#import "JumpToOtherVCHandler.h"
#import "VideoPlayer.h"
#import "DetailViewController.h"


static NSString *const VideoListIdentifier = @"VideoListIdentifier";

@interface VideoTableView ()<UITableViewDataSource, UITableViewDelegate, VideoPlayerDelegate>
{
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
}

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) VideoListCell *currentCell;

@end
@implementation VideoTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        isSmallScreen = NO;
        [self setupTableView];
        [self loadData];
    }
    return self;
}

- (void)setupTableView {
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:VideoListCell.class forCellReuseIdentifier:VideoListIdentifier];
    self.tableFooterView = [UIView new];
}

- (void)loadData {
    [VideoListApi getVideoListData:^(NSMutableArray * _Nullable dataArray) {
        [self.tableArray addObjectsFromArray:dataArray];
        [self reloadData];
    }];
}


- (NSMutableArray *)tableArray {
    if (!_tableArray) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoListIdentifier];
    cell.videoModel = self.tableArray[indexPath.row];
    __weak typeof(self)weakSelf = self;
    [cell setPlayBtnAction:^(UIButton *btn, VideoListModel *model) {
        currentIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [weakSelf startPlayVideo:btn model:model];

    }];
    
    if (self.videoPlayer&&self.videoPlayer.superview) {
        if (indexPath.row==currentIndexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]&&currentIndexPath!=nil) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.videoPlayer]) {
                self.videoPlayer.hidden = NO;
            }else{
                self.videoPlayer.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
        }else{
            if ([cell.backgroundIV.subviews containsObject:_videoPlayer]) {
                [cell.backgroundIV addSubview:_videoPlayer];
                
                [_videoPlayer play];
                _videoPlayer.hidden = NO;
            }
            
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 264;
}

- (void)startPlayVideo:(UIButton *)sender model:(VideoListModel *)model {
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
        self.currentCell = (VideoListCell *)sender.superview.superview;
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (VideoListCell *)sender.superview.superview.subviews;
    }
    
    //    isSmallScreen = NO;
    if (isSmallScreen) {
        [self releaseWMPlayer];
        isSmallScreen = NO;
        
    }
    if (self.videoPlayer) {
        [self releaseWMPlayer];
        self.videoPlayer = [[VideoPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        self.videoPlayer.delegate = self;
        self.videoPlayer.closeBtnStyle = CloseBtnStyleClose;
        self.videoPlayer.URLString = model.mp4_url;
        self.videoPlayer.titleLabel.text = model.title;
        //        [wmPlayer play];
    }else{
        self.videoPlayer = [[VideoPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        self.videoPlayer.delegate = self;
        self.videoPlayer.closeBtnStyle = CloseBtnStyleClose;
        self.videoPlayer.titleLabel.text = model.title;
        self.videoPlayer.URLString = model.mp4_url;
    }
    [self.currentCell.backgroundIV addSubview:self.videoPlayer];
    [self.currentCell.backgroundIV bringSubviewToFront:self.videoPlayer];
    [self.videoPlayer bringSubviewToFront:self.videoPlayer.contentView];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self reloadData];
}



-(void)toCell{
    VideoListCell *currentCell = (VideoListCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [_videoPlayer removeFromSuperview];
    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        _videoPlayer.transform = CGAffineTransformIdentity;
        _videoPlayer.frame = currentCell.backgroundIV.bounds;
        _videoPlayer.playerLayer.frame =  _videoPlayer.bounds;
        [currentCell.backgroundIV addSubview:_videoPlayer];
        [currentCell.backgroundIV bringSubviewToFront:_videoPlayer];
        [_videoPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_videoPlayer).with.offset(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(_videoPlayer.frame.size.height);
            
        }];
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            _videoPlayer.effectView.frame = CGRectMake(kScreenWidth/2-155/2, kScreenHeight/2-155/2, 155, 155);
        }else{
            //            wmPlayer.lightView.frame = CGRectMake(kScreenWidth/2-155/2, kScreenHeight/2-155/2, 155, 155);
        }
        
        //        [videoPlayer.FF_View  mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.center.mas_equalTo(CGPointMake(kScreenWidth/2-180, videoPlayer.frame.size.height/2-144));
        //            make.height.mas_equalTo(60);
        //            make.width.mas_equalTo(120);
        //
        //        }];
        
        [self.videoPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer).with.offset(0);
            make.right.equalTo(self.videoPlayer).with.offset(0);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(self.videoPlayer).with.offset(0);
        }];
        
        [self.videoPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer).with.offset(0);
            make.right.equalTo(self.videoPlayer).with.offset(0);
            make.height.mas_equalTo(70);
            make.top.equalTo(self.videoPlayer).with.offset(0);
        }];
        [self.videoPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer.topView).with.offset(45);
            make.right.equalTo(self.videoPlayer.topView).with.offset(-45);
            make.center.equalTo(self.videoPlayer.topView);
            make.top.equalTo(self.videoPlayer.topView).with.offset(0);
        }];
        [self.videoPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.videoPlayer).with.offset(20);
        }];
        [self.videoPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.videoPlayer);
            make.width.equalTo(self.videoPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        self.videoPlayer.isFullscreen = NO;
        self.updateStatusBar();
        isSmallScreen = NO;
        self.videoPlayer.fullScreenBtn.selected = NO;
        
    }];
    
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [self.videoPlayer removeFromSuperview];
    self.videoPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.videoPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.videoPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.videoPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.videoPlayer.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    
    [self.videoPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.height.mas_equalTo(kScreenWidth);
        make.left.equalTo(self.videoPlayer).with.offset(0);
        make.top.equalTo(self.videoPlayer).with.offset(0);
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        self.videoPlayer.effectView.frame = CGRectMake(kScreenHeight/2-155/2, kScreenWidth/2-155/2, 155, 155);
    }else{
        //        wmPlayer.lightView.frame = CGRectMake(kScreenHeight/2-155/2, kScreenWidth/2-155/2, 155, 155);
    }
    //    [videoPlayer.FF_View  mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(videoPlayer).with.offset(kScreenHeight/2-120/2);
    //        make.top.equalTo(videoPlayer).with.offset(kScreenWidth/2-60/2);
    //        make.height.mas_equalTo(60);
    //        make.width.mas_equalTo(120);
    //    }];
    
    
    [self.videoPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(kScreenHeight);
        make.bottom.equalTo(self.videoPlayer.contentView).with.offset(0);
    }];
    
    [self.videoPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.left.equalTo(self.videoPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [self.videoPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoPlayer.topView).with.offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self.videoPlayer).with.offset(20);
    }];
    
    [self.videoPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoPlayer.topView).with.offset(45);
        make.right.equalTo(self.videoPlayer.topView).with.offset(-45);
        make.center.equalTo(self.videoPlayer.topView);
        make.top.equalTo(self.videoPlayer.topView).with.offset(0);
    }];
    
    [self.videoPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoPlayer).with.offset(0);
        make.top.equalTo(self.videoPlayer).with.offset(kScreenWidth/2-30/2);
        make.height.equalTo(@30);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    
    [self.videoPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoPlayer).with.offset(kScreenHeight/2-22/2);
        make.top.equalTo(self.videoPlayer).with.offset(kScreenWidth/2-22/2);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
    }];
    [self addSubview:self.videoPlayer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.videoPlayer];
    self.videoPlayer.fullScreenBtn.selected = YES;
    self.videoPlayer.isFullscreen = YES;
    //videoPlayer.FF_View.hidden = YES;
    
}
-(void)toSmallScreen{
    //放widow上
    [self.videoPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        self.videoPlayer.transform = CGAffineTransformIdentity;
        self.videoPlayer.frame = CGRectMake(kScreenWidth/2,kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75, kScreenWidth/2, (kScreenWidth/2)*0.75);
        self.videoPlayer.playerLayer.frame =  self.videoPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoPlayer];
        [self.videoPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/2);
            make.height.mas_equalTo((kScreenWidth/2)*0.75);
            make.left.equalTo(self.videoPlayer).with.offset(0);
            make.top.equalTo(self.videoPlayer).with.offset(0);
        }];
        [self.videoPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer).with.offset(0);
            make.right.equalTo(self.videoPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.videoPlayer).with.offset(0);
        }];
        [self.videoPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer).with.offset(0);
            make.right.equalTo(self.videoPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(self.videoPlayer).with.offset(0);
        }];
        [self.videoPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer.topView).with.offset(45);
            make.right.equalTo(self.videoPlayer.topView).with.offset(-45);
            make.center.equalTo(self.videoPlayer.topView);
            make.top.equalTo(self.videoPlayer.topView).with.offset(0);
        }];
        [self.videoPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.videoPlayer).with.offset(5);
            
        }];
        [self.videoPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.videoPlayer);
            make.width.equalTo(self.videoPlayer);
            make.height.equalTo(@30);
        }];
        
    }completion:^(BOOL finished) {
        self.videoPlayer.isFullscreen = NO;
        self.updateStatusBar();
        self.videoPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        //videoPlayer.FF_View.hidden = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.videoPlayer];
    }];
    
}


- (void)videoplayer:(VideoPlayer *)videoplayer clickedCloseButton:(UIButton *)closeBtn {
    VideoListCell *currentCell = (VideoListCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    self.updateStatusBar();
}

- (void)videoplayer:(VideoPlayer *)videoplayer clickedFullScreenButton:(UIButton *)fullScreenBtn {
    if (fullScreenBtn.isSelected) {//全屏显示
        videoplayer.isFullscreen = YES;
        self.updateStatusBar();
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}

- (void)videoplayer:(VideoPlayer *)videoplayer singleTaped:(UITapGestureRecognizer *)singleTap {
    DLog(@"didSingleTaped");
}

- (void)videoplayer:(VideoPlayer *)videoplayer doubleTaped:(UITapGestureRecognizer *)doubleTap {
    DLog(@"didDoubleTaped");
    
}

- (void)videoplayerFailedPlay:(VideoPlayer *)videoplayer VideoPlayerStatus:(VideoPlayerState)state {
    DLog(@"videoplayerDidFailedPlay");
    
}

- (void)videoplayerReadyToPlay:(VideoPlayer *)videoplayer VideoPlayerStatus:(VideoPlayerState)state {
    DLog(@"videoplayerDidReadyToPlay");
    
}

- (void)videoplayerFinishedPlay:(VideoPlayer *)videoplayer {
    VideoListCell *currentCell = (VideoListCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    self.updateStatusBar();
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self){
        if (self.videoPlayer==nil) {
            return;
        }
        
        if (self.videoPlayer.superview) {
            CGRect rectInTableView = [self rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self convertRect:rectInTableView toView:[self superview]];
            if (rectInSuperview.origin.y<-self.currentCell.backgroundIV.frame.size.height||rectInSuperview.origin.y>kScreenHeight-kNavbarHeight-kTabBarHeight) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.videoPlayer]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if ([self.currentCell.backgroundIV.subviews containsObject:self.videoPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }
        
    }
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VideoListModel *   model = [self.tableArray objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.URLString  = model.m3u8_url;
    detailVC.title = model.title;
    detailVC.URLString = model.mp4_url;
    [JumpToOtherVCHandler pushToOtherView:detailVC animated:YES];

}

/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    [self.videoPlayer.player.currentItem cancelPendingSeeks];
    [self.videoPlayer.player.currentItem.asset cancelLoading];
    [self.videoPlayer pause];
    
    
    [self.videoPlayer removeFromSuperview];
    [self.videoPlayer.playerLayer removeFromSuperlayer];
    [self.videoPlayer.player replaceCurrentItemWithPlayerItem:nil];
    self.videoPlayer.player = nil;
    self.videoPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [self.videoPlayer.autoDismissTimer invalidate];
    self.videoPlayer.autoDismissTimer = nil;
    
    
    self.videoPlayer.playOrPauseBtn = nil;
    self.videoPlayer.playerLayer = nil;
    self.videoPlayer = nil;
}

@end
