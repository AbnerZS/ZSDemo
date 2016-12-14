//
//  NewsDetailViewController.m
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsListModel.h"
#import "NewsDetailApi.h"

@interface NewsDetailViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgress *webProgress;

@property (nonatomic, strong) NJKWebViewProgressView *webViewProgressView;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NewsDetailViewController

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
    [self loadData];
    [self setupWebView];
    
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [NewsDetailApi getTopicDetailWithId:self.articleId Data:^(NSDictionary * _Nullable dataDictionary) {
        
        NSDictionary *dic = [dataDictionary objectForKey:@"datas"];
        
        [self.webView loadHTMLString:[dic objectForKey:@"article_content"] baseURL:nil];
    }];
}

- (void)setupWebView {
    self.webProgress = [[NJKWebViewProgress alloc] init];
    self.webProgress.webViewProxyDelegate = self;
    self.webProgress.progressDelegate = self;
    [self.view addSubview:self.webView];
    [self.navigationController.navigationBar addSubview:self.webViewProgressView];
}


- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = _webProgress;
    }
    return _webView;
}


- (NJKWebViewProgressView *)webViewProgressView {
    if (!_webViewProgressView) {
        CGRect navBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navBounds.size.height - 2, navBounds.size.width, 2);
        _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _webViewProgressView.backgroundColor = [UIColor whiteColor];
        _webViewProgressView.progressBarView.backgroundColor = [UIColor greenColor];
        _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_webViewProgressView setProgress:0 animated:YES];
    }
    return _webViewProgressView;
}


- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_webViewProgressView setProgress:(progress * 10) animated:YES];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_webViewProgressView removeFromSuperview];
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
