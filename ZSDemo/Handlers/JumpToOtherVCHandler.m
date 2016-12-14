//
//  JumpToOtherVCHandler.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "JumpToOtherVCHandler.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"

@implementation JumpToOtherVCHandler

+ (UIViewController *)getTabbarViewController {
    BaseTabBarController *tabBar = [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarViewController];
    return tabBar;
}

+ (void)pushToOtherView:(UIViewController *)vc animated:(BOOL)animated {
    BaseTabBarController *tabBar = [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarViewController];
    [tabBar pushToViewController:vc animated:animated];
}

+ (void)presentToOtherView:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion {
    BaseTabBarController *tabBar = [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarViewController];
    BaseNavigationController *baseNC = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [tabBar presentViewController:baseNC animated:animated completion:completion];
}

@end
