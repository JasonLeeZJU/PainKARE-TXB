//
//  HMine_TreatmentLog_ResultViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/2/8.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_TreatmentLog_ResultViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@interface HMine_TreatmentLog_ResultViewController () <UIWebViewDelegate>

@end

@implementation HMine_TreatmentLog_ResultViewController {
    UIWebView *mine_TreatmentLog_ResultWebView;
    UIView *mine_TreatmentLog_ResultView;
    UILabel *mine_TreatmentLog_ResultTipLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mine_TreatmentLog_ResultNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
//    mine_TreatmentLog_ResultWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - 44 - TABBAR_HEIGHT)];
//    [self createWebView];
//    [self.view addSubview:mine_TreatmentLog_ResultWebView];
    
    mine_TreatmentLog_ResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mine_TreatmentLog_ResultView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mine_TreatmentLog_ResultView];
    
    mine_TreatmentLog_ResultTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    mine_TreatmentLog_ResultTipLabel.textColor = [HAppUIModel grayColor1];
    mine_TreatmentLog_ResultTipLabel.font = [HAppUIModel normalFont1];
    [mine_TreatmentLog_ResultTipLabel setTextAlignment:NSTextAlignmentCenter];
    //    mine_TreatmentLog_ResultTipLabel.text = @"一句话提示";
    mine_TreatmentLog_ResultTipLabel.alpha = 0;
    [mine_TreatmentLog_ResultView addSubview:mine_TreatmentLog_ResultTipLabel];
    
    [self createWebView];
}

- (void)createWebView {
//    mine_TreatmentLog_ResultWebView.backgroundColor = [HAppUIModel whiteColor1];
//    mine_TreatmentLog_ResultWebView.delegate = self;
//    [mine_TreatmentLog_ResultWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5.app.aceme-medical.com"]];
//    [mine_TreatmentLog_ResultWebView loadRequest:request];
    
    mine_TreatmentLog_ResultWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - 44 - TABBAR_HEIGHT)];
    mine_TreatmentLog_ResultWebView.backgroundColor = [HAppUIModel whiteColor1];
    [self.view addSubview:mine_TreatmentLog_ResultWebView];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"html"];
    NSString *htmlcont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [mine_TreatmentLog_ResultWebView loadHTMLString:htmlcont baseURL:baseURL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGFloat downHeight = -mine_TreatmentLog_ResultWebView.scrollView.contentOffset.y;
    NSLog(@"downHeight >>> %f",downHeight);
    // 根据下拉高度计算出 homeView 拉伸的高度
    CGRect homeViewframe = mine_TreatmentLog_ResultView.frame;
    homeViewframe.size.height = STATUS_HEIGHT + 44 + downHeight;
    if (downHeight >= 0) {
        mine_TreatmentLog_ResultView.frame = homeViewframe;
        if (downHeight > 20) {
            mine_TreatmentLog_ResultTipLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, STATUS_HEIGHT + 20 + downHeight);
            mine_TreatmentLog_ResultTipLabel.alpha = (downHeight - 20) * 0.015;
        }
    } else {
        mine_TreatmentLog_ResultView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44);
        mine_TreatmentLog_ResultTipLabel.alpha = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Web");
    self.tabBarController.tabBar.hidden = YES;
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
