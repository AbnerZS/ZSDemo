//
//  NewsViewController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableView.h"
#import "BaseNavigationController.h"

@interface NewsViewController ()
@property (nonatomic, strong) NewsTableView *tableView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self setupNavigationItem];
    // Do any additional setup after loading the view.
}

- (void)setupNavigationItem {
    self.title = @"新闻";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (NewsTableView *)tableView {
    if (!_tableView) {
        _tableView = [[NewsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    }
    return _tableView;
}


- (void)rightItemAction {
    Class aClass = NSClassFromString(@"ImageViewController");
    if (aClass) {
        BaseViewController *ctrl = aClass.new;
        [JumpToOtherVCHandler presentToOtherView:ctrl animated:YES completion:nil];
    }
    
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
