//
//  BaseNavigationController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()


@end

@implementation BaseNavigationController


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#warning VC中的这个方法不执行, 在Navigation中这样设置
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = kThemeColor;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    // 设置状态栏为白色: 1. 在plist文件设置Status bar style UIStatusBarStyleLightContent 2. 在plist文件设置View controller-based status bar appearance 为NO
    
    
    // Do any additional setup after loading the view.
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
