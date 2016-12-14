//
//  BaseViewController.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface BaseViewController : UIViewController

- (void)closeLoginView;

/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@property (nonatomic, assign) BOOL enablePanGesture;//是否支持自定义拖动pop手势，默认yes,支持手势

@property (nonatomic,retain) MBProgressHUD* hud;
- (void)addHud;
- (void)addHudWithMessage:(NSString*)message;
- (void)removeHud;

@end
