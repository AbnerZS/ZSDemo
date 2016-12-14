//
//  BaseDelegate.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabBarController.h"

@interface BaseDelegate : UIResponder<UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) RootTabBarController *tabBarViewController;
@end
