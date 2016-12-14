//
//  ImageViewController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/18.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "ImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageViewController ()

@end

@implementation ImageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看图片";
    UIImageView *testImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    testImg.center = CGPointMake(self.view.center.x, 164);
    if (self.imgStr.length > 0) {
        [testImg sd_setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:[UIImage imageNamed:@"placeholer"]];
        
    } else {
        testImg.backgroundColor = UIColor.redColor;
    }
    [self.view addSubview:testImg];
    testImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [testImg addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}

- (void)tapAction {
    [self closeLoginView];
 
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
