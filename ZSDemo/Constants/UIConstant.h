//
//  UIConstant.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#ifndef UIConstant_h
#define UIConstant_h

#define kScreenWidth ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

#define kScreenHeight ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

#define kTabBarHeight 49
#define kNavbarHeight ((kDeviceVersion>=7.0)? 64 :44 )
//#define kIOS7DELTA   ((kDeviceVersion>=7.0)? 20 :0 )
#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]


#define IMAGE(loadPath) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:loadPath ofType:nil]]

#define kKeyWindow          [UIApplication sharedApplication].keyWindow

#define kUserDefaults      [NSUserDefaults standardUserDefaults]

#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define kRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kThemeColor    [UIColor colorWithRed:(96)/255.0 green:(219)/255.0 blue:(243)/255.0 alpha:1.0]




#endif /* UIConstant_h */
