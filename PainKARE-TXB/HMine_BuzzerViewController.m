//
//  HMine_BuzzerViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/5.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_BuzzerViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@interface HMine_BuzzerViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HMine_BuzzerViewController {
    UIView *mine_BuzzerView;
    UITableView *mine_BuzzerTableView;
    UILabel *mine_BuzzerTipLabel;
    
    // ———————— 适应 ————————————————————————
    CGFloat switch_Width;
    CGFloat switch_Height;
    
    CGFloat errorTitleLabel_Size_height;
    CGFloat errorTipLabel_Size_height;
    
    CGFloat workingTitleLabel_Size_height;
    CGFloat workingTipLabel_Size_height;
    
    CGFloat horizontalSpaceI;
    CGFloat horizontalSpaceII;
    
    CGFloat verticalSpaceI;
    CGFloat verticalSpaceII;
    CGFloat verticalSpaceIII;
    CGFloat verticalSpaceIV;
    // ————————————————————————————————————————
}

- (void)viewDidLoad {
    [super viewDidLoad];
    switch_Width = [HAppUIModel baseWidthChangeLength:51.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    switch_Height = [HAppUIModel baseLongChangeLength:31.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    horizontalSpaceI = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceII = [HAppUIModel baseWidthChangeLength:16.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    verticalSpaceI = [HAppUIModel baseLongChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceII = [HAppUIModel baseLongChangeLength:32.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceIII = [HAppUIModel baseLongChangeLength:22.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceIV = [HAppUIModel baseLongChangeLength:19.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"mine_BuzzerNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    mine_BuzzerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44))];
    mine_BuzzerTableView.delegate = self;
    mine_BuzzerTableView.dataSource = self;
    [mine_BuzzerTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   //设置 cell 之间的横线
    mine_BuzzerTableView.backgroundColor = [UIColor clearColor];
    [mine_BuzzerTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [mine_BuzzerTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)]; // 设置偏移量
    [mine_BuzzerTableView setAllowsSelection:NO];
    [self.view addSubview:mine_BuzzerTableView];
    
    mine_BuzzerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    mine_BuzzerView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:mine_BuzzerView];
    
    mine_BuzzerTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    mine_BuzzerTipLabel.textColor = [HAppUIModel grayColor1];
    mine_BuzzerTipLabel.font = [HAppUIModel normalFont1];
    [mine_BuzzerTipLabel setTextAlignment:NSTextAlignmentCenter];
    mine_BuzzerTipLabel.text = @"一句话提示";
    mine_BuzzerTipLabel.alpha = 0;
    [mine_BuzzerView addSubview:mine_BuzzerTipLabel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *errorTitleLabel = [UILabel new];
        errorTitleLabel.font = [HAppUIModel mediumFont3];
        errorTitleLabel.textColor = [HAppUIModel grayColor6];
        errorTitleLabel.text = NSLocalizedString(@"mine_BuzzerErrorTitle", nil);
        CGSize errorTitleLabel_Size = [NSLocalizedString(@"mine_BuzzerErrorTitle", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont3]}];
        errorTitleLabel_Size = CGSizeMake(ceilf(errorTitleLabel_Size.width), ceilf(errorTitleLabel_Size.height));
        errorTitleLabel_Size_height = errorTitleLabel_Size.height;
        errorTitleLabel.frame = CGRectMake(0, 0, errorTitleLabel_Size.width, errorTitleLabel_Size_height);
        errorTitleLabel.center = CGPointMake(horizontalSpaceII + errorTitleLabel_Size.width * 0.5, verticalSpaceIII + errorTitleLabel_Size_height * 0.5);
        [cell.contentView addSubview:errorTitleLabel];
        
        UILabel *errorTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpaceI * 2, 0)];
        errorTipLabel.font = [HAppUIModel normalFont5];
        errorTipLabel.textColor = [HAppUIModel grayColor3];
        errorTipLabel.text = NSLocalizedString(@"mine_BuzzerErrorTip", nil);
        [errorTipLabel setNumberOfLines:0];
        CGSize errorTipLabel_Size = [errorTipLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpaceI * 2, MAXFLOAT)];
        CGRect errorTipLabel_Frame = errorTipLabel.frame;
        errorTipLabel_Size_height = errorTipLabel_Size.height;
        errorTipLabel_Frame.size.height = errorTipLabel_Size_height;
        [errorTipLabel setFrame:errorTipLabel_Frame];
        errorTipLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpaceIII + errorTitleLabel_Size_height + verticalSpaceIV + errorTipLabel_Size_height * 0.5);
        [cell.contentView addSubview:errorTipLabel];
        
        UISwitch *switchErrorButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, switch_Width, switch_Height)];
        [switchErrorButton addTarget:self action:@selector(switchErrorAction:) forControlEvents:UIControlEventValueChanged];
        /* 将来用
        if (ApplicationDelegate.errorBuzzerState) {
            [switchErrorButton setOn:YES];
        } else {
            [switchErrorButton setOn:NO];
        }
         */
        // —————————————— 测试用 ——————————————
//        [switchErrorButton setOn:YES];
        // ——————————————————————————————————————
        if (0 == ApplicationDelegate.errorBuzzer_State) {
            [switchErrorButton setOn:NO];
        }
        if (1 == ApplicationDelegate.errorBuzzer_State) {
            [switchErrorButton setOn:YES];
        }
        switchErrorButton.center = CGPointMake(SCREEN_WIDTH - horizontalSpaceI - switch_Width * 0.5, verticalSpaceIV + switch_Height * 0.5);
        [cell.contentView addSubview:switchErrorButton];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        UILabel *workingTitleLabel = [UILabel new];
        workingTitleLabel.font = [HAppUIModel mediumFont3];
        workingTitleLabel.textColor = [HAppUIModel grayColor6];
        workingTitleLabel.text = NSLocalizedString(@"mine_BuzzerWorkingTitle", nil);
        CGSize workingTitleLabel_Size = [NSLocalizedString(@"mine_BuzzerWorkingTitle", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont3]}];
        workingTitleLabel_Size = CGSizeMake(ceilf(workingTitleLabel_Size.width), ceilf(workingTitleLabel_Size.height));
        workingTitleLabel_Size_height = workingTitleLabel_Size.height;
        workingTitleLabel.frame = CGRectMake(0, 0, workingTitleLabel_Size.width, workingTitleLabel_Size_height);
        workingTitleLabel.center = CGPointMake(horizontalSpaceII + workingTitleLabel_Size.width * 0.5, verticalSpaceIII + workingTitleLabel_Size_height * 0.5);
        [cell.contentView addSubview:workingTitleLabel];
        
        UILabel *workingTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - horizontalSpaceI * 2, 0)];
        workingTipLabel.font = [HAppUIModel normalFont5];
        workingTipLabel.textColor = [HAppUIModel grayColor3];
        workingTipLabel.text = NSLocalizedString(@"mine_BuzzerWorkingTip", nil);
        [workingTipLabel setNumberOfLines:0];
        CGSize workingTipLabel_Size = [workingTipLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - horizontalSpaceI * 2, MAXFLOAT)];
        CGRect workingTipLabel_Frame = workingTipLabel.frame;
        workingTipLabel_Size_height = workingTipLabel_Size.height;
        workingTipLabel_Frame.size.height = workingTipLabel_Size_height;
        [workingTipLabel setFrame:workingTipLabel_Frame];
        workingTipLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpaceIII + workingTitleLabel_Size_height + verticalSpaceIV + workingTipLabel_Size_height * 0.5);
        [cell.contentView addSubview:workingTipLabel];
        
        UISwitch *switchWorkingButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, switch_Width, switch_Height)];
        [switchWorkingButton addTarget:self action:@selector(switchWorkingAction:) forControlEvents:UIControlEventValueChanged];
        /* 将来用
         if (ApplicationDelegate.errorBuzzerState) {
         [switchErrorButton setOn:YES];
         } else {
         [switchErrorButton setOn:NO];
         }
         */
        // —————————————— 测试用 ——————————————
//        [switchWorkingButton setOn:NO];
        // ——————————————————————————————————————
        if (0 == ApplicationDelegate.workingBuzzer_State) {
            [switchWorkingButton setOn:NO];
        }
        if (1 == ApplicationDelegate.workingBuzzer_State) {
            [switchWorkingButton setOn:YES];
        }
        switchWorkingButton.center = CGPointMake(SCREEN_WIDTH - horizontalSpaceI - switch_Width * 0.5, verticalSpaceIV + switch_Height * 0.5);
        [cell.contentView addSubview:switchWorkingButton];
    }
    cell.backgroundColor = [HAppUIModel whiteColor4];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return verticalSpaceIII + errorTitleLabel_Size_height + verticalSpaceIV + errorTipLabel_Size_height + verticalSpaceIII;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        return verticalSpaceIII + workingTitleLabel_Size_height + verticalSpaceIV + workingTipLabel_Size_height + verticalSpaceIII;
    }
    return [HAppUIModel baseLongChangeLength:44.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:32.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:32.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(horizontalSpaceI, verticalSpaceI, SCREEN_WIDTH - 2 * horizontalSpaceI, verticalSpaceII)];
    noticeLabel.font = [HAppUIModel normalFont4];
    noticeLabel.textColor = [HAppUIModel grayColor5];
    noticeLabel.text = NSLocalizedString(@"mine_BuzzerNotice", nil);
    [footerView addSubview:noticeLabel];
    return footerView;
}

// ———————————————————— 方法 ——————————————————————————————————————————————
- (void)switchErrorAction:(UISwitch *)sender {
    NSLog(@">>> switchErrorAction");
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        if (sender.isOn) {
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"setErrorStateBuzzerON";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        } else {
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"setErrorStateBuzzerOFF";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
    } else {
        NSLog(@"未连接");
        [MBProgressHUD showError:NSLocalizedString(@"mine_BuzzerShowError", nil)];
    }
}
- (void)switchWorkingAction:(UISwitch *)sender {
    NSLog(@">>> switchWorkingAction");
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        if (sender.isOn) {
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"setWorkingStateBuzzerON";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        } else {
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"setWorkingStateBuzzerOFF";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
    } else {
        NSLog(@"未连接");
        [MBProgressHUD showError:NSLocalizedString(@"mine_BuzzerShowError", nil)];
    }
}
// ————————————————————————————————————————————————————————————————————————

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine - Buzzer");
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
