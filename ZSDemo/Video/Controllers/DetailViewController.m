//
//  DetailViewController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/24.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "DetailViewController.h"
#import "VideoPlayer.h"


@interface DetailViewController ()<VideoPlayerDelegate>
{
    VideoPlayer *videoPlayer;
    CGRect playerFrame;
    BOOL isHiddenStatusBar;
}
@end

@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    if (isHiddenStatusBar) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

///播放器事件: 播放器返回按钮事件, 分为全屏和非全屏两种状态
-(void)videoplayer:(VideoPlayer *)videoplayer clickedCloseButton:(UIButton *)closeBtn{
    if (videoplayer.isFullscreen) {
        [self toOrientation:UIInterfaceOrientationPortrait];
        videoplayer.isFullscreen = NO;
        self.enablePanGesture = YES;
        
    }else{
        [self releaseWMPlayer];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
///播放暂停

- (void)videoplayer:(VideoPlayer *)videoplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn {
    DLog(@"clickedPlayOrPauseButton");
}

///全屏按钮

- (void)videoplayer:(VideoPlayer *)videoplayer clickedFullScreenButton:(UIButton *)fullScreenBtn {
    if (videoplayer.isFullscreen==YES) {//全屏
        [self toOrientation:UIInterfaceOrientationPortrait];
        videoplayer.isFullscreen = NO;
        self.enablePanGesture = YES;
        
    }else{//非全屏
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
        videoplayer.isFullscreen = YES;
        self.enablePanGesture = NO;
    }
}

///单击播放器

- (void)videoplayer:(VideoPlayer *)videoplayer singleTaped:(UITapGestureRecognizer *)singleTap {
    DLog(@"didSingleTaped");
}
///双击播放器

- (void)videoplayer:(VideoPlayer *)videoplayer doubleTaped:(UITapGestureRecognizer *)doubleTap {
    DLog(@"didDoubleTaped");
}

///播放状态

- (void)videoplayerFailedPlay:(VideoPlayer *)videoplayer VideoPlayerStatus:(VideoPlayerState)state {
    DLog(@"videoplayerDidFailedPlay");
}


- (void)videoplayerReadyToPlay:(VideoPlayer *)videoplayer VideoPlayerStatus:(VideoPlayerState)state {
    DLog(@"videoplayerDidReadyToPlay");
}


- (void)videoplayerFinishedPlay:(VideoPlayer *)videoplayer {
    DLog(@"videoplayerDidFinishedPlay");
}


//操作栏隐藏或者显示都会调用此方法

- (void)videoplayer:(VideoPlayer *)videoplayer isHiddenTopAndBottomView:(BOOL)isHidden {
    isHiddenStatusBar = isHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (videoPlayer==nil||videoPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
            videoPlayer.isFullscreen = NO;
            self.enablePanGesture = NO;
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
            videoPlayer.isFullscreen = NO;
            self.enablePanGesture = YES;
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
            videoPlayer.isFullscreen = YES;
            self.enablePanGesture = NO;
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
            videoPlayer.isFullscreen = YES;
            self.enablePanGesture = NO;
        }
            break;
        default:
            break;
    }
}

//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) {
        return;
    }
    
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {//
        [videoPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(0);
            make.left.equalTo(self.view).with.offset(0);
            make.right.equalTo(self.view).with.offset(0);
            make.height.equalTo(@(playerFrame.size.height));
        }];
    }else{
        //这个地方加判断是为了从全屏的一侧,直接到全屏的另一侧不用修改限制,否则会出错;
        if (currentOrientation ==UIInterfaceOrientationPortrait) {
            [videoPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(kScreenHeight));
                make.height.equalTo(@(kScreenWidth));
                make.center.equalTo(videoPlayer.superview);
            }];
        }
    }
    //iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    //也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    
    //获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    //更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    //给你的播放视频的view视图设置旋转
    videoPlayer.transform = CGAffineTransformIdentity;
    videoPlayer.transform = [VideoPlayer getCurrentDeviceOrientation];
    [UIView setAnimationDuration:2.0];
    //开始旋转
    [UIView commitAnimations];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    playerFrame = CGRectMake(0, 0, kScreenWidth, (kScreenWidth)*(0.75));
    //    wmPlayer = [[WMPlayer alloc]init];
    videoPlayer = [VideoPlayer new];
    
    videoPlayer.delegate = self;
    videoPlayer.URLString = self.URLString;
    videoPlayer.titleLabel.text = self.title;
    videoPlayer.closeBtn.hidden = NO;
    [self.view addSubview:videoPlayer];
    [videoPlayer play];
    
    [videoPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@(playerFrame.size.height));
    }];
}

- (void)releaseWMPlayer
{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [videoPlayer pause];
    [videoPlayer removeFromSuperview];
    [videoPlayer.playerLayer removeFromSuperlayer];
    [videoPlayer.player replaceCurrentItemWithPlayerItem:nil];
    videoPlayer.player = nil;
    videoPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [videoPlayer.autoDismissTimer invalidate];
    videoPlayer.autoDismissTimer = nil;
    videoPlayer.playOrPauseBtn = nil;
    videoPlayer.playerLayer = nil;
    videoPlayer = nil;
}
- (void)dealloc
{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DetailViewController deallco");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
