//
//  DemoHeader.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/17.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#ifndef DemoHeader_h
#define DemoHeader_h

#import "UIConstant.h"
#import "APIConstant.h"
#import "SecretConstant.h"
#import "JumpToOtherVCHandler.h"
#import <Masonry/Masonry.h>

#define DLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else

#define DLog(...)

#endif /* DemoHeader_h */


