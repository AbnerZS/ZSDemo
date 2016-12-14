//
//  BaseTabBarController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

#import "NewsViewController.h"
#import "VideoViewController.h"
#import "MineViewController.h"


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

#warning VC中的这个方法不执行, 在TabBar中这样设置

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBarItems];
    
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)setupTabBarItems {
    // 设置图片的偏移
    //UIEdgeInsets insets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);

    NewsViewController *newsVC = [[NewsViewController alloc] init];
    BaseNavigationController *newsNC = [[BaseNavigationController alloc] initWithRootViewController:newsVC];
    newsNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"tab_news"] selectedImage:nil];
    
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    BaseNavigationController *videoNC = [[BaseNavigationController alloc] initWithRootViewController:videoVC];
    videoNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:[UIImage imageNamed:@"tab_video"] selectedImage:nil];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    BaseNavigationController *mineNC = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    mineNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tab_me"] selectedImage:nil];
    self.tabBar.tintColor = kThemeColor;
    self.viewControllers = @[videoNC, newsNC, mineNC];
    newsNC.navigationBar.translucent = NO;
    videoNC.navigationBar.translucent = NO;
    mineNC.navigationBar.translucent = NO;
    
    self.delegate = self;
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.25];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];
    
    return YES;
}


- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([self.selectedViewController isKindOfClass:[BaseNavigationController class]]) {
        BaseNavigationController *navigation = (BaseNavigationController *)self.selectedViewController;
        [navigation pushViewController:viewController animated:animated];
    }
}


- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    if([self.selectedViewController isKindOfClass:[BaseNavigationController class]]) {
        BaseNavigationController *navigation = (BaseNavigationController *)self.selectedViewController;
        [navigation presentViewController:viewController animated:animated completion:completion];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
