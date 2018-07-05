//
//  HMine_ConnectGuideViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/3/1.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_ConnectGuideViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@interface HMine_ConnectGuideViewController () <UIScrollViewDelegate>

@end

@implementation HMine_ConnectGuideViewController {
    UIView *mine_ConnectGuideView;
    UIScrollView *mine_ConnectGuideScrollView;
    
    // —————————————— 适应 ———————————————————
    CGFloat horizontalSpace1;
    CGFloat horizontalSpace2;
    CGFloat horizontalSpace3;
    
    CGFloat verticalSpace1;
    CGFloat verticalSpace2;
    CGFloat verticalSpace3;
    CGFloat verticalSpace4;
    CGFloat verticalSpace5;
    CGFloat verticalSpace6;
    CGFloat verticalSpace7;
    // ————————————————————————————————————————————
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mine_BuzzerNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // ———————————————— 适应 ————————————————————
    horizontalSpace1 = [HAppUIModel baseWidthChangeLength:339.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace2 = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace3 = [HAppUIModel baseWidthChangeLength:19.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    verticalSpace1 = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace2 = [HAppUIModel baseLongChangeLength:18.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace3 = [HAppUIModel baseLongChangeLength:170.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace4 = [HAppUIModel baseLongChangeLength:10.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace5 = [HAppUIModel baseLongChangeLength:14.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace6 = [HAppUIModel baseLongChangeLength:34.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace7 = [HAppUIModel baseLongChangeLength:22.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    // ——————————————————————————————————————————————
    
    mine_ConnectGuideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44 + verticalSpace1, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44 + verticalSpace1))];
    mine_ConnectGuideScrollView.delegate = self;
    // 设置背景颜色
    mine_ConnectGuideScrollView.backgroundColor = [HAppUIModel whiteColor3];
    // 取消滑条
    [mine_ConnectGuideScrollView setShowsVerticalScrollIndicator:NO];
    [mine_ConnectGuideScrollView setShowsHorizontalScrollIndicator:NO];
    //是否自动裁剪超出部分
    mine_ConnectGuideScrollView.clipsToBounds = YES;
    //设置是否可以缩放
    mine_ConnectGuideScrollView.scrollEnabled = YES;
    //设置是否可以进行页面切换
    mine_ConnectGuideScrollView.pagingEnabled = NO;
    //设置在拖拽的时候是否锁定其在水平或垂直的方向
    mine_ConnectGuideScrollView.directionalLockEnabled = YES;
    
    UIView *bdView = [UIView new];
    bdView.backgroundColor = [HAppUIModel whiteColor4];
    
    UILabel *generalTitleLabel = [UILabel new];
    generalTitleLabel.font = [HAppUIModel mediumFont1];
    generalTitleLabel.textColor = [HAppUIModel grayColor8];
    generalTitleLabel.text = NSLocalizedString(@"mine_ConnectGuideGeneralTitle", nil);
    CGSize generalTitleLabelSize = [NSLocalizedString(@"mine_ConnectGuideGeneralTitle", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont1]}];
    generalTitleLabelSize = CGSizeMake(ceilf(generalTitleLabelSize.width), ceilf(generalTitleLabelSize.height));
    generalTitleLabel.frame = CGRectMake(0, 0, generalTitleLabelSize.width, generalTitleLabelSize.height);
    generalTitleLabel.center = CGPointMake(horizontalSpace2 + generalTitleLabelSize.width * 0.5, verticalSpace2 + generalTitleLabelSize.height * 0.5);
    [bdView addSubview:generalTitleLabel];
    
    UILabel *generalTextLabel = [UILabel new];
    generalTextLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpace3 * 2, 0);
    generalTextLabel.font = [HAppUIModel normalFont2];
    generalTextLabel.textColor = [HAppUIModel grayColor25];
    generalTextLabel.text = NSLocalizedString(@"mine_ConnectGuideGeneralText", nil);
    generalTextLabel.numberOfLines = 0;
    CGSize generalTextLabelSize = [generalTextLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpace3 * 2, MAXFLOAT)];
    CGRect generalTextLabelFrame = generalTextLabel.frame;
    generalTextLabelFrame.size.height = generalTextLabelSize.height;
    [generalTextLabel setFrame:generalTextLabelFrame];
    generalTextLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height * 0.5);
    [bdView addSubview:generalTextLabel];
    
    UILabel *connectAction1Label = [UILabel new];
    connectAction1Label.font = [HAppUIModel normalFont6];
    connectAction1Label.textColor = [HAppUIModel grayColor26];
    connectAction1Label.text = NSLocalizedString(@"mine_ConnectGuideConnectAction1", nil);
    CGSize connectAction1LabelSize = [NSLocalizedString(@"mine_ConnectGuideConnectAction1", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont6]}];
    connectAction1LabelSize = CGSizeMake(ceilf(connectAction1LabelSize.width), ceilf(connectAction1LabelSize.height));
    connectAction1Label.frame = CGRectMake(0, 0, connectAction1LabelSize.width, connectAction1LabelSize.height);
    connectAction1Label.center = CGPointMake(horizontalSpace2 + connectAction1LabelSize.width * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height * 0.5);
    [bdView addSubview:connectAction1Label];
    
    UIImageView *connectAction1ImageView = [UIImageView new];
    connectAction1ImageView.frame = CGRectMake(0, 0, horizontalSpace1, verticalSpace3);
    if ([HAppUIModel UIViewIsChinese] == YES){
        connectAction1ImageView.image = [UIImage imageNamed:@"mine_ConnectGuide1"];
    }
    else{
        connectAction1ImageView.image = [UIImage imageNamed:@"mine_ConnectGuide1Eng"];
    }
    
    connectAction1ImageView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 * 0.5);
    [bdView addSubview:connectAction1ImageView];
    
    UILabel *connectAction2Label = [UILabel new];
    connectAction2Label.font = [HAppUIModel normalFont6];
    connectAction2Label.textColor = [HAppUIModel grayColor26];
    connectAction2Label.text = NSLocalizedString(@"mine_ConnectGuideConnectAction2", nil);
    CGSize connectAction2LabelSize = [NSLocalizedString(@"mine_ConnectGuideConnectAction2", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont6]}];
    connectAction2LabelSize = CGSizeMake(ceilf(connectAction2LabelSize.width), ceilf(connectAction2LabelSize.height));
    connectAction2Label.frame = CGRectMake(0, 0, connectAction2LabelSize.width, connectAction2LabelSize.height);
    connectAction2Label.center = CGPointMake(horizontalSpace2 + connectAction2LabelSize.width * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height * 0.5);
    [bdView addSubview:connectAction2Label];
    
    UIImageView *connectAction2ImageView = [UIImageView new];
    connectAction2ImageView.frame = CGRectMake(0, 0, horizontalSpace1, verticalSpace3);
    
    if ([HAppUIModel UIViewIsChinese] == YES){
        connectAction2ImageView.image = [UIImage imageNamed:@"mine_ConnectGuide2"];
    }
    else{
        connectAction2ImageView.image = [UIImage imageNamed:@"mine_ConnectGuide2Eng"];
    }
    
    
    connectAction2ImageView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 * 0.5);
    [bdView addSubview:connectAction2ImageView];
    
    UILabel *notice0Label = [UILabel new];
    notice0Label.frame = CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpace3 * 2, 0);
    notice0Label.font = [HAppUIModel normalFont2];
    notice0Label.textColor = [HAppUIModel grayColor25];
    notice0Label.text = NSLocalizedString(@"mine_ConnectGuideNotice0", nil);
    notice0Label.numberOfLines = 0;
    CGSize notice0LabelSize = [notice0Label sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpace3 * 2, MAXFLOAT)];
    CGRect notice0LabelFrame = notice0Label.frame;
    notice0LabelFrame.size.height = notice0LabelSize.height;
    [notice0Label setFrame:notice0LabelFrame];
    notice0Label.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace6 + notice0LabelFrame.size.height * 0.5);
    [bdView addSubview:notice0Label];
    
    UILabel *notice1Label = [UILabel new];
    notice1Label.frame = CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpace3 * 2, 0);
    notice1Label.font = [HAppUIModel normalFont2];
    notice1Label.textColor = [HAppUIModel grayColor25];
    notice1Label.text = NSLocalizedString(@"mine_ConnectGuideNotice1", nil);
    notice1Label.numberOfLines = 0;
    CGSize notice1LabelSize = [notice1Label sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpace3 * 2, MAXFLOAT)];
    CGRect notice1LabelFrame = notice1Label.frame;
    notice1LabelFrame.size.height = notice1LabelSize.height;
    [notice1Label setFrame:notice1LabelFrame];
    notice1Label.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace6 + notice0LabelFrame.size.height + notice1LabelFrame.size.height * 0.5);
    [bdView addSubview:notice1Label];
    
    UILabel *notice2Label = [UILabel new];
    notice2Label.frame = CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpace3 * 2, 0);
    notice2Label.font = [HAppUIModel normalFont2];
    notice2Label.textColor = [HAppUIModel grayColor25];
    notice2Label.text = NSLocalizedString(@"mine_ConnectGuideNotice2", nil);
    notice2Label.numberOfLines = 0;
    CGSize notice2LabelSize = [notice2Label sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpace3 * 2, MAXFLOAT)];
    CGRect notice2LabelFrame = notice2Label.frame;
    notice2LabelFrame.size.height = notice2LabelSize.height;
    [notice2Label setFrame:notice2LabelFrame];
    notice2Label.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace6 + notice0LabelFrame.size.height + notice1LabelFrame.size.height + notice2LabelFrame.size.height * 0.5);
    [bdView addSubview:notice2Label];
    
    UILabel *notice3Label = [UILabel new];
    notice3Label.frame = CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpace3 * 2, 0);
    notice3Label.font = [HAppUIModel normalFont2];
    notice3Label.textColor = [HAppUIModel grayColor25];
    notice3Label.text = NSLocalizedString(@"mine_ConnectGuideNotice3", nil);
    notice3Label.numberOfLines = 0;
    CGSize notice3LabelSize = [notice3Label sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpace3 * 2, MAXFLOAT)];
    CGRect notice3LabelFrame = notice3Label.frame;
    notice3LabelFrame.size.height = notice3LabelSize.height;
    [notice3Label setFrame:notice3LabelFrame];
    notice3Label.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace6 + notice0LabelFrame.size.height + notice1LabelFrame.size.height + notice2LabelFrame.size.height + notice3LabelFrame.size.height * 0.5);
    [bdView addSubview:notice3Label];
    
    bdView.frame = CGRectMake(0, verticalSpace1, SCREEN_WIDTH, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace6 + notice0LabelFrame.size.height + notice1LabelFrame.size.height + notice2LabelFrame.size.height + notice3LabelFrame.size.height + verticalSpace7);
    
    [mine_ConnectGuideScrollView setContentSize:CGSizeMake(0, verticalSpace2 + generalTitleLabelSize.height + verticalSpace4 + generalTextLabelFrame.size.height + verticalSpace1 + connectAction1LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace5 + connectAction2LabelSize.height + verticalSpace5 + verticalSpace3 + verticalSpace6 + notice0LabelFrame.size.height + notice1LabelFrame.size.height + notice2LabelFrame.size.height + notice3LabelFrame.size.height + verticalSpace7)];
    [mine_ConnectGuideScrollView addSubview:bdView];
    
    [self.view addSubview:mine_ConnectGuideScrollView];
    
    mine_ConnectGuideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mine_ConnectGuideView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mine_ConnectGuideView];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine - ConnectGuide");
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
