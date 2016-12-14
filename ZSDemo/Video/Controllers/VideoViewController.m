//
//  VideoViewController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoTableView.h"
#import "VideoPlayer.h"

@interface VideoViewController () {
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
    VideoListModel *currentModel;
}
@property (nonatomic, strong) VideoTableView *tableView;
@end

@implementation VideoViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    if (self.tableView.videoPlayer) {
        if (self.tableView.videoPlayer.isFullscreen) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

- (void)onDeviceOrientationChange{
    if (self.tableView.videoPlayer==nil||self.tableView.videoPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (self.tableView.videoPlayer.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
                    [self.tableView toSmallScreen];
                }else{
                    [self.tableView toCell];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            self.tableView.videoPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self.tableView toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            self.tableView.videoPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self.tableView toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}


- (VideoTableView *)tableView {
    if (!_tableView) {
        _tableView = [[VideoTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
        __weak typeof(self) weakSelf = self;
        [_tableView setUpdateStatusBar:^{
            [weakSelf setNeedsStatusBarAppearanceUpdate];
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.tableView releaseWMPlayer];
}
@end
