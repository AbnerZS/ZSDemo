//
//  BaseTabBarController.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController<UITabBarControllerDelegate>

- (void)setupTabBarItems;
- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;



@end
