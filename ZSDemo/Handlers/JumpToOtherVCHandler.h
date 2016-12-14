//
//  JumpToOtherVCHandler.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabBarController.h"

@interface JumpToOtherVCHandler : NSObject

+ (BaseTabBarController *)getTabbarViewController;
+ (void)pushToOtherView:(UIViewController *)vc animated:(BOOL)animated;
+ (void)presentToOtherView:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion;

@end
