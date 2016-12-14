//
//  BaseDelegate.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "BaseDelegate.h"

@implementation BaseDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    _tabBarViewController = [[RootTabBarController alloc] init];
    
    [self.window setRootViewController:_tabBarViewController];
    
    [self.window makeKeyAndVisible];

    return YES;
}

@end
