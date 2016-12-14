//
//  VideoPlayer.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
// 集成其他人的作品 作者Github地址：https://github.com/zhengwenming

#import <UIKit/UIKit.h>
@import MediaPlayer;
@import AVFoundation;


//播放器的状态
typedef NS_ENUM(NSInteger, VideoPlayerState) {
    VideoPlayerStateFailed,        // 播放失败
    VideoPlayerStateBuffering,     // 缓冲中
    VideoPlayerStatePlaying,       // 播放中
    VideoPlayerStateStopped,        //停止播放
    VideoPlayerStateFinished,        //结束播放
    VideoPlayerStatePause,       // 暂停播放
};

// 播放器左上角的关闭按钮的类型
typedef NS_ENUM(NSInteger, CloseBtnStyle){
    CloseBtnStylePop, //箭头<-
    CloseBtnStyleClose  //关闭（x）
};

//手势操作的类型
typedef NS_ENUM(NSUInteger,VideoControlType) {
    progressControl,//视频进度调节操作
    voiceControl,//声音调节操作
    lightControl,//屏幕亮度调节操作
    noneControl//无任何操作
} ;

@class VideoPlayer;
@protocol VideoPlayerDelegate <NSObject>

@optional

///播放器事件
//点击播放暂停按钮代理方法
-(void)videoplayer:(VideoPlayer *)videoplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn;
//点击关闭按钮代理方法
-(void)videoplayer:(VideoPlayer *)videoplayer clickedCloseButton:(UIButton *)closeBtn;
//点击全屏按钮代理方法
-(void)videoplayer:(VideoPlayer *)videoplayer clickedFullScreenButton:(UIButton *)fullScreenBtn;
//单击WMPlayer的代理方法
-(void)videoplayer:(VideoPlayer *)videoplayer singleTaped:(UITapGestureRecognizer *)singleTap;
//双击WMPlayer的代理方法
-(void)videoplayer:(VideoPlayer *)videoplayer doubleTaped:(UITapGestureRecognizer *)doubleTap;
//WMPlayer的的操作栏隐藏和显示
-(void)videoplayer:(VideoPlayer *)videoplayer isHiddenTopAndBottomView:(BOOL)isHidden;

///播放状态
//播放失败的代理方法
-(void)videoplayerFailedPlay:(VideoPlayer *)videoplayer VideoPlayerStatus:(VideoPlayerState)state;
//准备播放的代理方法
-(void)videoplayerReadyToPlay:(VideoPlayer *)videoplayer VideoPlayerStatus:(VideoPlayerState)state;
//播放完毕的代理方法
-(void)videoplayerFinishedPlay:(VideoPlayer *)videoplayer;


@end


@interface VideoPlayer : UIView

/**
 *  播放器player
 */
@property (nonatomic,strong) AVPlayer       *player;
/**
 *playerLayer,可以修改frame
 */
@property (nonatomic,strong) AVPlayerLayer  *playerLayer;

/** 播放器的代理 */
@property (nonatomic, weak)id <VideoPlayerDelegate> delegate;
/**
 *  底部操作工具栏
 */
@property (nonatomic,strong) UIImageView         *bottomView;
/**
 *  顶部操作工具栏
 */
@property (nonatomic,strong) UIImageView         *topView;

/**
 *  显示播放视频的title
 */
@property (nonatomic,strong) UILabel        *titleLabel;

/**
 *  是否使用手势控制音量
 */
@property (nonatomic,assign) BOOL  enableVolumeGesture;

/**
 ＊  播放器状态
 */
@property (nonatomic, assign) VideoPlayerState   state;
/**
 ＊  播放器左上角按钮的类型
 */
@property (nonatomic, assign) CloseBtnStyle   closeBtnStyle;
/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer        *autoDismissTimer;
/**
 *  BOOL值判断当前的状态
 */
@property (nonatomic, assign) BOOL            isFullscreen;
/**
 *  控制全屏的按钮
 */
@property (nonatomic, strong) UIButton       *fullScreenBtn;
/**
 *  播放暂停按钮
 */
@property (nonatomic, strong) UIButton       *playOrPauseBtn;
/**
 *  左上角关闭按钮
 */
@property (nonatomic, strong) UIButton       *closeBtn;
/**
 *  显示加载失败的UILabel
 */
@property (nonatomic, strong) UILabel        *loadFailedLabel;

/**
 *  /给显示亮度的view添加毛玻璃效果
 */
@property (nonatomic, strong) UIVisualEffectView * effectView;
/**
 *  wmPlayer内部一个UIView，所有的控件统一管理在此view中
 */
@property (nonatomic,strong) UIView        *contentView;

/**
 *  当前播放的item
 */
@property (nonatomic, strong) AVPlayerItem   *currentItem;
/**
 *  菊花（加载框）
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
/**
 *  设置播放视频的USRLString，可以是本地的路径也可以是http的网络路径
 */
@property (nonatomic,copy) NSString       *URLString;

//这个用来显示滑动屏幕时的时间
//@property (nonatomic,strong) FastForwardView * FF_View;
/**
 *  跳到time处播放
 */
@property (nonatomic, assign) double  seekTime;

/** 播放前占位图片，不设置就显示默认占位图（需要在设置视频URL之前设置） */
@property (nonatomic, copy  ) UIImage              *placeholderImage ;
/**
 *  播放
 */
- (void)play;

/**
 * 暂停
 */
- (void)pause;

/**
 *  获取正在播放的时间点
 *
 *  @return double的一个时间点
 */
- (double)currentTime;

/**
 * 重置播放器
 */
- (void )resetWMPlayer;

//获取当前的旋转状态
+(CGAffineTransform)getCurrentDeviceOrientation;

@end
