//
//  HMineViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/22.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HMineViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"
#import "HMine_TreatmentLogViewController.h"
#import "HMine_ProfileViewController.h"
#import "HMine_BuzzerViewController.h"
#import "HMine_ConnectGuideViewController.h"
#import "HMine_AboutViewController.h"
#import "MBProgressHUD+MJ.h"

@interface HMineViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HMineViewController {
    UIView *mineView;
    UITableView *mineTableView;
    UILabel *mineTipLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mineNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44))];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
//    [mineTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];   //取消 cell 之间的横线
    mineTableView.backgroundColor = [HAppUIModel whiteColor3];
    [mineTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [self.view addSubview:mineTableView];
    
    mineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mineView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mineView];
    
    mineTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    mineTipLabel.textColor = [HAppUIModel grayColor1];
    mineTipLabel.font = [HAppUIModel normalFont1];
    [mineTipLabel setTextAlignment:NSTextAlignmentCenter];
//    mineTipLabel.text = @"一句话提示";
    mineTipLabel.alpha = 0;
    [mineView addSubview:mineTipLabel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ApplicationDelegate.mineList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ApplicationDelegate.mineList objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[[ApplicationDelegate.mineList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"imageName"]]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[[ApplicationDelegate.mineList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"label_Text"]];
    cell.textLabel.font = [HAppUIModel normalFont3];
    cell.textLabel.textColor = [HAppUIModel grayColor4];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [HAppUIModel whiteColor4];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HAppUIModel baseLongChangeLength:64.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        HMine_TreatmentLogViewController *Mine_TreatmentLogVC = [HMine_TreatmentLogViewController new];
        [self.navigationController pushViewController:Mine_TreatmentLogVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        HMine_ProfileViewController *Mine_ProfileVC = [HMine_ProfileViewController new];
        [self.navigationController pushViewController:Mine_ProfileVC animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        if (1 == ApplicationDelegate.BLE_Connected_Status) {
            HMine_BuzzerViewController *Mine_BuzzerVC = [HMine_BuzzerViewController new];
            [self.navigationController pushViewController:Mine_BuzzerVC animated:YES];
        } else {
            [MBProgressHUD showError:NSLocalizedString(@"mineBuzzerShowError", nil)];
        }
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        HMine_ConnectGuideViewController *Mine_ConnectGuideVC = [HMine_ConnectGuideViewController new];
        [self.navigationController pushViewController:Mine_ConnectGuideVC animated:YES];
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        HMine_AboutViewController *Mine_AboutVC = [HMine_AboutViewController new];
        [self.navigationController pushViewController:Mine_AboutVC animated:YES];
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

#pragma mark >>> tableview滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // tableView 下位，根据偏移量计算出下位的高度
    CGFloat downHeight = -scrollView.contentOffset.y;
    NSLog(@"downHeight >>> %f",downHeight);
    // 根据下拉高度计算出 homeView 拉伸的高度
    CGRect homeViewframe = mineView.frame;
    homeViewframe.size.height = STATUS_HEIGHT + 44 + downHeight;
    if (downHeight >= 0) {
        mineView.frame = homeViewframe;
        if (downHeight > 20) {
            mineTipLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, STATUS_HEIGHT + 20 + downHeight);
            mineTipLabel.alpha = (downHeight - 20) * 0.015;
        }
    } else {
        mineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44);
        mineTipLabel.alpha = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine");
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
