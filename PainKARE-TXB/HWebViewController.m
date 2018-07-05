//
//  HWebViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/22.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HWebViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@interface HWebViewController () <UIWebViewDelegate>

@end

@implementation HWebViewController {
    UIWebView *mainWebView;
    UIView *webView;
    UILabel *webTipLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"webNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
//    mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - 44 - TABBAR_HEIGHT)];
//    [self createWebView];
//    [self.view addSubview:mainWebView];
    
    [self createWebView];
    
    webView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    webView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:webView];
    
    webTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    webTipLabel.textColor = [HAppUIModel grayColor1];
    webTipLabel.font = [HAppUIModel normalFont1];
    [webTipLabel setTextAlignment:NSTextAlignmentCenter];
//    webTipLabel.text = @"一句话提示";
    webTipLabel.alpha = 0;
    [webView addSubview:webTipLabel];
    
}

- (void)createWebView {
    mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - 44 - TABBAR_HEIGHT)];
    mainWebView.backgroundColor = [HAppUIModel whiteColor1];
    [self.view addSubview:mainWebView];
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"painkare_main" ofType:@"html"];
//    NSString *htmlcont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    [mainWebView loadHTMLString:htmlcont baseURL:baseURL];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"painkare_main.html" ofType:nil];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [mainWebView loadRequest:request];
    
    
    
    
//    [mainWebView loadHTMLString:htmlcont baseURL:baseURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
//    [mainWebView loadRequest:request];
}

//- (void)createWebView {
//    mainWebView.backgroundColor = [HAppUIModel whiteColor1];
//    mainWebView.delegate = self;
//    [mainWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5.app.aceme-medical.com"]];
//    [mainWebView loadRequest:request];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGFloat downHeight = -mainWebView.scrollView.contentOffset.y;
    NSLog(@"downHeight >>> %f",downHeight);
    // 根据下拉高度计算出 homeView 拉伸的高度
    CGRect homeViewframe = webView.frame;
    homeViewframe.size.height = STATUS_HEIGHT + 44 + downHeight;
    if (downHeight >= 0) {
        webView.frame = homeViewframe;
        if (downHeight > 20) {
            webTipLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, STATUS_HEIGHT + 20 + downHeight);
            webTipLabel.alpha = (downHeight - 20) * 0.015;
        }
    } else {
        webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44);
        webTipLabel.alpha = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Web");
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
