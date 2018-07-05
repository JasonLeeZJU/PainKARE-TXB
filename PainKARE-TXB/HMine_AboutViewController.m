//
//  HMine_AboutViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/5.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_AboutViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@interface HMine_AboutViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HMine_AboutViewController {
    UIView *mine_AboutView;
    UITableView *mine_AboutTableView;
    UILabel *mine_AboutTipLabel;
    
    CGFloat section0_row0_Height;
    CGFloat section0_row1_Height;
    CGFloat section1_row0_Height;
    CGFloat section2_row0_Height;
    CGFloat section2_row1_Height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mine_AboutNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    CGFloat mine_AboutTableViewOffsetHeight = [HAppUIModel baseLongChangeLength:116.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat groupImageViewWidth = [HAppUIModel baseWidthChangeLength:275.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    UIImageView *groupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, groupImageViewWidth, mine_AboutTableViewOffsetHeight)];
    groupImageView.image = [UIImage imageNamed:@"group"];
    groupImageView.center = CGPointMake(SCREEN_WIDTH * 0.5, STATUS_HEIGHT + 44 + mine_AboutTableViewOffsetHeight * 0.5);
    [self.view addSubview:groupImageView];
    
    UILabel *groupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    groupLabel.text = NSLocalizedString(@"mine_AboutGroupCopyright", nil);
    groupLabel.textColor = [HAppUIModel grayColor7];
    groupLabel.font = [HAppUIModel normalFont4];
    CGSize groupLabelSize = [NSLocalizedString(@"mine_AboutGroupCopyright", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont4]}];
    groupLabelSize = CGSizeMake(ceilf(groupLabelSize.width), ceilf(groupLabelSize.height));
    groupLabel.frame = CGRectMake(0, 0, groupLabelSize.width, groupLabelSize.height);
    groupLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - 18 - groupLabelSize.height * 0.5);
    [self.view addSubview:groupLabel];
    
    mine_AboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44))];
    mine_AboutTableView.delegate = self;
    mine_AboutTableView.dataSource = self;
    [mine_AboutTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   //设置 cell 之间的横线
    mine_AboutTableView.backgroundColor = [UIColor clearColor];
    [mine_AboutTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [mine_AboutTableView setContentInset:UIEdgeInsetsMake(mine_AboutTableViewOffsetHeight, 0, 0, 0)]; // 设置偏移量
    [self.view addSubview:mine_AboutTableView];
    
    mine_AboutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mine_AboutView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mine_AboutView];
    
    mine_AboutTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    mine_AboutTipLabel.textColor = [HAppUIModel grayColor1];
    mine_AboutTipLabel.font = [HAppUIModel normalFont1];
    [mine_AboutTipLabel setTextAlignment:NSTextAlignmentCenter];
    mine_AboutTipLabel.text = @"一句话提示";
    mine_AboutTipLabel.alpha = 0;
    [mine_AboutView addSubview:mine_AboutTipLabel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    // 清空视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat leftSpace = [HAppUIModel baseWidthChangeLength:15 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSapceI = [HAppUIModel baseWidthChangeLength:16 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSapceII = [HAppUIModel baseWidthChangeLength:10 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSapceIII = [HAppUIModel baseWidthChangeLength:14 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSapceIV = [HAppUIModel baseWidthChangeLength:18 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSapceV = [HAppUIModel baseWidthChangeLength:5 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *contactLabel = [UILabel new];
        contactLabel.font = [HAppUIModel mediumFont3];
        contactLabel.textColor = [HAppUIModel grayColor6];
        contactLabel.text = NSLocalizedString(@"mine_AboutContact", nil);
        CGSize contactLabelSize = [NSLocalizedString(@"mine_AboutContact", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont3]}];
        contactLabelSize = CGSizeMake(ceilf(contactLabelSize.width), ceilf(contactLabelSize.height));
        contactLabel.frame = CGRectMake(0, 0, contactLabelSize.width, contactLabelSize.height);
        contactLabel.center = CGPointMake(leftSpace + contactLabelSize.width * 0.5, topSapceI + contactLabelSize.height * 0.5);
        [cell.contentView addSubview:contactLabel];
        
        UILabel *emailLabel = [UILabel new];
        emailLabel.font = [HAppUIModel normalFont2];
        emailLabel.textColor = [HAppUIModel grayColor3];
        NSString *emailLabelContent = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"mine_AboutEmail-Left", nil), NSLocalizedString(@"mine_AboutEmail-Right", nil)];
        emailLabel.text = emailLabelContent;
        CGSize emailLabelSize = [emailLabelContent sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
        emailLabelSize = CGSizeMake(ceilf(emailLabelSize.width), ceilf(emailLabelSize.height));
        emailLabel.frame = CGRectMake(0, 0, emailLabelSize.width, emailLabelSize.height);
        emailLabel.center = CGPointMake(leftSpace + emailLabelSize.width * 0.5, topSapceI + contactLabelSize.height + topSapceII + emailLabelSize.height * 0.5);
        [cell.contentView addSubview:emailLabel];
        section0_row0_Height = topSapceI + contactLabelSize.height + topSapceII + emailLabelSize.height + topSapceIII;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        UILabel *websiteLabel = [UILabel new];
        websiteLabel.font = [HAppUIModel normalFont2];
        websiteLabel.textColor = [HAppUIModel grayColor3];
        NSString *websiteLabelContent = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"mine_AboutWebsite-Left", nil), NSLocalizedString(@"mine_AboutWebsite-Right", nil)];
        websiteLabel.text = websiteLabelContent;
        CGSize websiteLabelSize = [websiteLabelContent sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
        websiteLabelSize = CGSizeMake(ceilf(websiteLabelSize.width), ceilf(websiteLabelSize.height));
        websiteLabel.frame = CGRectMake(0, 0, websiteLabelSize.width, websiteLabelSize.height);
        websiteLabel.center = CGPointMake(leftSpace + websiteLabelSize.width * 0.5, topSapceIII + websiteLabelSize.height * 0.5);
        [cell.contentView addSubview:websiteLabel];
        section0_row1_Height = topSapceIII + websiteLabelSize.height + topSapceI;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        UILabel *appVersionLabel = [UILabel new];
        appVersionLabel.font = [HAppUIModel mediumFont3];
        appVersionLabel.textColor = [HAppUIModel grayColor6];
        appVersionLabel.text = NSLocalizedString(@"mine_AboutAppVersion", nil);
        CGSize appVersionLabelSize = [NSLocalizedString(@"mine_AboutAppVersion", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont3]}];
        appVersionLabelSize = CGSizeMake(ceilf(appVersionLabelSize.width), ceilf(appVersionLabelSize.height));
        appVersionLabel.frame = CGRectMake(0, 0, appVersionLabelSize.width, appVersionLabelSize.height);
        appVersionLabel.center = CGPointMake(leftSpace + appVersionLabelSize.width * 0.5, topSapceIV + appVersionLabelSize.height * 0.5);
        [cell.contentView addSubview:appVersionLabel];
        
        UILabel *appVersionDataLabel = [UILabel new];
        appVersionDataLabel.font = [HAppUIModel normalFont2];
        appVersionDataLabel.textColor = [HAppUIModel grayColor3];
        NSString *appVersionData = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        appVersionDataLabel.text = appVersionData;
        CGSize appVersionDataLabelSize = [appVersionData sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
        appVersionDataLabelSize = CGSizeMake(ceilf(appVersionDataLabelSize.width), ceilf(appVersionDataLabelSize.height));
        appVersionDataLabel.frame = CGRectMake(0, 0, appVersionDataLabelSize.width, appVersionDataLabelSize.height);
        appVersionDataLabel.center = CGPointMake(leftSpace + appVersionDataLabelSize.width * 0.5, topSapceIV + appVersionLabelSize.height + topSapceV + appVersionDataLabelSize.height * 0.5);
        [cell.contentView addSubview:appVersionDataLabel];
        
        section1_row0_Height = topSapceIV + appVersionLabelSize.height + topSapceV + appVersionDataLabelSize.height + topSapceIV;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        UILabel *deviceVersionLabel = [UILabel new];
        deviceVersionLabel.font = [HAppUIModel mediumFont3];
        deviceVersionLabel.textColor = [HAppUIModel grayColor6];
        deviceVersionLabel.text = NSLocalizedString(@"mine_AboutDeviceVersion", nil);
        CGSize deviceVersionLabelSize = [NSLocalizedString(@"mine_AboutDeviceVersion", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont3]}];
        deviceVersionLabelSize = CGSizeMake(ceilf(deviceVersionLabelSize.width), ceilf(deviceVersionLabelSize.height));
        deviceVersionLabel.frame = CGRectMake(0, 0, deviceVersionLabelSize.width, deviceVersionLabelSize.height);
        deviceVersionLabel.center = CGPointMake(leftSpace + deviceVersionLabelSize.width * 0.5, topSapceI + deviceVersionLabelSize.height * 0.5);
        [cell.contentView addSubview:deviceVersionLabel];
        
        UILabel *deviceIDLabel = [UILabel new];
        deviceIDLabel.font = [HAppUIModel normalFont5];
        deviceIDLabel.textColor = [HAppUIModel grayColor6];
        deviceIDLabel.text = NSLocalizedString(@"mine_AboutDeviceID", nil);
        CGSize deviceIDLabelSize = [NSLocalizedString(@"mine_AboutDeviceID", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        deviceIDLabelSize = CGSizeMake(ceilf(deviceIDLabelSize.width), ceilf(deviceIDLabelSize.height));
        deviceIDLabel.frame = CGRectMake(0, 0, deviceIDLabelSize.width, deviceIDLabelSize.height);
        deviceIDLabel.center = CGPointMake(leftSpace + deviceIDLabelSize.width * 0.5, topSapceI + deviceVersionLabelSize.height + topSapceII + deviceIDLabelSize.height * 0.5);
        [cell.contentView addSubview:deviceIDLabel];
        
        UILabel *deviceIDDataLabel = [UILabel new];
        deviceIDDataLabel.font = [HAppUIModel normalFont2];
        deviceIDDataLabel.textColor = [HAppUIModel grayColor3];
        deviceIDDataLabel.text = ApplicationDelegate.productId;
        CGSize deviceIDDataLabelSize = [ApplicationDelegate.productId sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
        deviceIDDataLabelSize = CGSizeMake(ceilf(deviceIDDataLabelSize.width), ceilf(deviceIDDataLabelSize.height));
        deviceIDDataLabel.frame = CGRectMake(0, 0, deviceIDDataLabelSize.width, deviceIDDataLabelSize.height);
        deviceIDDataLabel.center = CGPointMake(leftSpace + deviceIDDataLabelSize.width * 0.5, topSapceI + deviceVersionLabelSize.height + topSapceII + deviceIDLabelSize.height + topSapceV + deviceIDDataLabelSize.height * 0.5);
        [cell.contentView addSubview:deviceIDDataLabel];
        section2_row0_Height = topSapceI + deviceVersionLabelSize.height + topSapceII + deviceIDLabelSize.height + topSapceV + deviceIDDataLabelSize.height + topSapceIII;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        UILabel *softwareVersionLabel = [UILabel new];
        softwareVersionLabel.font = [HAppUIModel normalFont5];
        softwareVersionLabel.textColor = [HAppUIModel grayColor6];
        softwareVersionLabel.text = NSLocalizedString(@"mine_AboutSoftwareVersion", nil);
        CGSize softwareVersionLabelSize = [NSLocalizedString(@"mine_AboutSoftwareVersion", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
        softwareVersionLabelSize = CGSizeMake(ceilf(softwareVersionLabelSize.width), ceilf(softwareVersionLabelSize.height));
        softwareVersionLabel.frame = CGRectMake(0, 0, softwareVersionLabelSize.width, softwareVersionLabelSize.height);
        softwareVersionLabel.center = CGPointMake(leftSpace + softwareVersionLabelSize.width * 0.5, topSapceIII + softwareVersionLabelSize.height * 0.5);
        [cell.contentView addSubview:softwareVersionLabel];
        
        UILabel *softwareVersionDataLabel = [UILabel new];
        softwareVersionDataLabel.font = [HAppUIModel normalFont2];
        softwareVersionDataLabel.textColor = [HAppUIModel grayColor3];
        softwareVersionDataLabel.text = ApplicationDelegate.softwareVersion;
        CGSize softwareVersionDataLabelSize = [ApplicationDelegate.softwareVersion sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
        softwareVersionDataLabelSize = CGSizeMake(ceilf(softwareVersionDataLabelSize.width), ceilf(softwareVersionDataLabelSize.height));
        softwareVersionDataLabel.frame = CGRectMake(0, 0, softwareVersionDataLabelSize.width, softwareVersionDataLabelSize.height);
        softwareVersionDataLabel.center = CGPointMake(leftSpace + softwareVersionDataLabelSize.width * 0.5, topSapceIII + softwareVersionLabelSize.height + topSapceV + softwareVersionDataLabelSize.height * 0.5);
        [cell.contentView addSubview:softwareVersionDataLabel];
        section2_row1_Height = topSapceIII + softwareVersionLabelSize.height + topSapceV + softwareVersionDataLabelSize.height + topSapceI;
    }
    cell.backgroundColor = [HAppUIModel whiteColor4];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return section0_row0_Height;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        return section0_row1_Height;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return section1_row0_Height;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        return section2_row0_Height;
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        return section2_row1_Height;
    } else {
        return [HAppUIModel baseLongChangeLength:64.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中效果
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine - About");
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
