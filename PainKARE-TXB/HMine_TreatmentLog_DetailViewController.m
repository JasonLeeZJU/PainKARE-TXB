//
//  HMine_TreatmentLog_DetailViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/17.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HMine_TreatmentLog_DetailViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

#import "HTreatment_DetailChartView.h"

@interface HMine_TreatmentLog_DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HMine_TreatmentLog_DetailViewController {
    UIView *treatmentTopView;
    UIView *backgroundView;
    UITableView *mine_TreatmentLog_DetailTableView;
    
    HTreatment_DetailChartView *treatment_DetailChartView;
    
    CGFloat horizontalSpace1;
    CGFloat horizontalSpace2;
    CGFloat horizontalSpace3;
    CGFloat horizontalSpace4;
    CGFloat horizontalSpace5;
    CGFloat horizontalSpace6;
    CGFloat horizontalSpace7;
    
    CGFloat verticalSpace1;
    CGFloat verticalSpace2;
    CGFloat verticalSpace3;
    CGFloat verticalSpace4;
    CGFloat verticalSpace5;
    CGFloat verticalSpace6;
    CGFloat verticalSpace7;
    CGFloat verticalSpace8;
    CGFloat verticalSpace9;
}

- (NSDictionary *)selectedTreatmentLogDictionary {
    if (!_selectedTreatmentLogDictionary) {
        _selectedTreatmentLogDictionary = [NSDictionary dictionary];
    }
    return _selectedTreatmentLogDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 设置 navigationTitle
    self.navigationItem.title = NSLocalizedString(@"mine_TreatmentLog_DetailNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮（已经是最后一个页面了，其实不用了）
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // —————————————————————————— 数据整理 ————————————————————————————————————————————————————————
//    self.selectedTreatmentLogDictionary = @{@"phase":@"6.8", @"position":@"2001", @"symptom":@"1901", @"placement":@"1p", @"duration":@"77", @"startTime":@"2017-12-4  22:10"};
    
    
    horizontalSpace1 = [HAppUIModel baseWidthChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace2 = [HAppUIModel baseWidthChangeLength:361.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace3 = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace4 = [HAppUIModel baseWidthChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace5 = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace6 = [HAppUIModel baseWidthChangeLength:135.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpace7 = [HAppUIModel baseWidthChangeLength:329.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    verticalSpace1 = [HAppUIModel baseLongChangeLength:229.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace2 = [HAppUIModel baseLongChangeLength:240.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace3 = [HAppUIModel baseLongChangeLength:79.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace4 = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace5 = [HAppUIModel baseLongChangeLength:80.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace6 = [HAppUIModel baseLongChangeLength:62.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace7 = [HAppUIModel baseLongChangeLength:98.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace8 = [HAppUIModel baseLongChangeLength:90.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpace9 = [HAppUIModel baseLongChangeLength:52.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    // ——————————————————————————————————————————————————————————————————————————————————————————————
    
    treatmentTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, verticalSpace1)];
    treatmentTopView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:treatmentTopView];
    
    [self createGraphView];
    [self createSelectedLogTableView];
}

- (void)createGraphView {
    // —————————————————————————————————— 曲线图 ————————————————————————————————————————————————————
    treatment_DetailChartView = [[HTreatment_DetailChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, verticalSpace2)];
    treatment_DetailChartView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace3 + verticalSpace2 * 0.5);
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, verticalSpace2)];
    [backgroundView.layer setCornerRadius:horizontalSpace3];
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    backgroundView.layer.shadowOpacity = 0.30;//设置阴影的透明度
    backgroundView.layer.shadowOffset = CGSizeMake(0, 0);//设置阴影的偏移量
    backgroundView.layer.shadowRadius = horizontalSpace4;//设置阴影的圆角
    backgroundView.backgroundColor = [HAppUIModel whiteColor1];
    backgroundView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace2 * 0.5);
    [treatment_DetailChartView addSubview:backgroundView];
    
    NSLog(@">>> selectedTreatmentLogDictionary %@", self.selectedTreatmentLogDictionary);
    NSMutableArray *phase = [NSMutableArray arrayWithArray:[self.selectedTreatmentLogDictionary objectForKey:@"phase"]];
    NSLog(@">>> phase %@", phase);
    
    treatment_DetailChartView.phaseArray = [NSMutableArray arrayWithArray:[self.selectedTreatmentLogDictionary objectForKey:@"phase"]];
    treatment_DetailChartView.reactanceArray = [NSMutableArray arrayWithArray:[self.selectedTreatmentLogDictionary objectForKey:@"reactance"]];
    treatment_DetailChartView.resistanceArray = [NSMutableArray arrayWithArray:[self.selectedTreatmentLogDictionary objectForKey:@"resistance"]];
    
    [treatment_DetailChartView initWithView];
    [self.view addSubview:treatment_DetailChartView];
    // ————————————————————————————————————————————————————————————————————————————————————————————
}

- (void)createSelectedLogTableView {
    mine_TreatmentLog_DetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, verticalSpace3 + verticalSpace2 + verticalSpace4, SCREEN_WIDTH, SCREEN_HEIGHT - (verticalSpace3 + verticalSpace2 + verticalSpace4))];
    mine_TreatmentLog_DetailTableView.delegate = self;
    mine_TreatmentLog_DetailTableView.dataSource = self;
    [mine_TreatmentLog_DetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   // cell 之间的横线
//    mine_TreatmentLog_DetailTableView.backgroundColor = [HAppUIModel whiteColor3];
    mine_TreatmentLog_DetailTableView.backgroundColor = [UIColor clearColor];
    [mine_TreatmentLog_DetailTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [self.view addSubview:mine_TreatmentLog_DetailTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    // 清空视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *phaseLabel = [UILabel new];
        phaseLabel.font = [HAppUIModel normalFont1];
        phaseLabel.textColor = [HAppUIModel grayColor20];
        phaseLabel.text = NSLocalizedString(@"mine_TreatmentLog_DetailPhase", nil);
        CGSize phaseLabel_Size = [NSLocalizedString(@"mine_TreatmentLog_DetailPhase", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        phaseLabel_Size = CGSizeMake(ceilf(phaseLabel_Size.width), ceilf(phaseLabel_Size.height));
        phaseLabel.frame = CGRectMake(0, 0, phaseLabel_Size.width, phaseLabel_Size.height);
        phaseLabel.center = CGPointMake(horizontalSpace5 + phaseLabel_Size.width * 0.5, verticalSpace6 * 0.5);
        [cell.contentView addSubview:phaseLabel];
        
        NSArray *phaseArray = [NSArray arrayWithArray:[self.selectedTreatmentLogDictionary objectForKey:@"phase"]];
        NSString *phaseDataString = [NSString stringWithFormat:@"%.1f", [[phaseArray valueForKeyPath:@"@avg.floatValue"] floatValue]];
        UILabel *phaseDataLabel = [UILabel new];
        phaseDataLabel.font = [HAppUIModel semiboldFont1];
        phaseDataLabel.textColor = [HAppUIModel orangeColor5];
        phaseDataLabel.text = phaseDataString;
        CGSize phaseDataLabel_Size = [phaseDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel semiboldFont1]}];
        phaseDataLabel_Size = CGSizeMake(ceilf(phaseDataLabel_Size.width), ceilf(phaseDataLabel_Size.height));
        phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabel_Size.width, phaseDataLabel_Size.height);
        phaseDataLabel.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace5 + phaseDataLabel_Size.width * 0.5), verticalSpace6 * 0.5);
        [cell.contentView addSubview:phaseDataLabel];
        
        cell.backgroundColor = [HAppUIModel whiteColor4];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        UILabel *positionLabel = [UILabel new];
        positionLabel.font = [HAppUIModel normalFont1];
        positionLabel.textColor = [HAppUIModel grayColor20];
        positionLabel.text = NSLocalizedString(@"mine_TreatmentLog_DetailPosition", nil);
        CGSize positionLabel_Size = [NSLocalizedString(@"mine_TreatmentLog_DetailPosition", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        positionLabel_Size = CGSizeMake(ceilf(positionLabel_Size.width), ceilf(positionLabel_Size.height));
        positionLabel.frame = CGRectMake(0, 0, positionLabel_Size.width, positionLabel_Size.height);
        positionLabel.center = CGPointMake(horizontalSpace5 + positionLabel_Size.width * 0.5, verticalSpace6 * 0.5);
        [cell.contentView addSubview:positionLabel];
        
        NSString *positionDataString = [NSString stringWithFormat:@"mine_TreatmentLog_Detail%@", [self.selectedTreatmentLogDictionary objectForKey:@"position"]];
        UILabel *positionDataLabel = [UILabel new];
        positionDataLabel.font = [HAppUIModel normalFont3];
        positionDataLabel.textColor = [HAppUIModel grayColor21];
        positionDataLabel.text = NSLocalizedString(positionDataString, nil);
        CGSize positionDataLabel_Size = [NSLocalizedString(positionDataString, nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont3]}];
        positionDataLabel_Size = CGSizeMake(ceilf(positionDataLabel_Size.width), ceilf(positionDataLabel_Size.height));
        positionDataLabel.frame = CGRectMake(0, 0, positionDataLabel_Size.width, positionDataLabel_Size.height);
        positionDataLabel.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace5 + positionDataLabel_Size.width * 0.5), verticalSpace6 * 0.5);
        [cell.contentView addSubview:positionDataLabel];
        
        cell.backgroundColor = [HAppUIModel whiteColor4];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        UILabel *durationLabel = [UILabel new];
        durationLabel.font = [HAppUIModel normalFont1];
        durationLabel.textColor = [HAppUIModel grayColor20];
        durationLabel.text = NSLocalizedString(@"mine_TreatmentLog_DetailDuration", nil);
        CGSize durationLabel_Size = [NSLocalizedString(@"mine_TreatmentLog_DetailDuration", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        durationLabel_Size = CGSizeMake(ceilf(durationLabel_Size.width), ceilf(durationLabel_Size.height));
        durationLabel.frame = CGRectMake(0, 0, durationLabel_Size.width, durationLabel_Size.height);
        durationLabel.center = CGPointMake(horizontalSpace5 + durationLabel_Size.width * 0.5, verticalSpace6 * 0.5);
        [cell.contentView addSubview:durationLabel];
        
        NSString *durationDataLabelString = [NSString stringWithFormat:@"%@%@", [self.selectedTreatmentLogDictionary objectForKey:@"duration"], NSLocalizedString(@"mine_TreatmentLog_DetailMinute", nil)];
        UILabel *durationDataLabel = [UILabel new];
        durationDataLabel.font = [HAppUIModel normalFont3];
        durationDataLabel.textColor = [HAppUIModel grayColor21];
        durationDataLabel.text = durationDataLabelString;
        CGSize durationDataLabel_Size = [durationDataLabelString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont3]}];
        durationDataLabel_Size = CGSizeMake(ceilf(durationDataLabel_Size.width), ceilf(durationDataLabel_Size.height));
        durationDataLabel.frame = CGRectMake(0, 0, durationDataLabel_Size.width, durationDataLabel_Size.height);
        durationDataLabel.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace5 + durationDataLabel_Size.width * 0.5), verticalSpace6 * 0.5);
        [cell.contentView addSubview:durationDataLabel];
        
        cell.backgroundColor = [HAppUIModel whiteColor4];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        UILabel *startTimeLabel = [UILabel new];
        startTimeLabel.font = [HAppUIModel normalFont1];
        startTimeLabel.textColor = [HAppUIModel grayColor20];
        startTimeLabel.text = NSLocalizedString(@"mine_TreatmentLog_DetailStartTime", nil);
        CGSize startTimeLabel_Size = [NSLocalizedString(@"mine_TreatmentLog_DetailStartTime", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        startTimeLabel_Size = CGSizeMake(ceilf(startTimeLabel_Size.width), ceilf(startTimeLabel_Size.height));
        startTimeLabel.frame = CGRectMake(0, 0, startTimeLabel_Size.width, startTimeLabel_Size.height);
        startTimeLabel.center = CGPointMake(horizontalSpace5 + startTimeLabel_Size.width * 0.5, verticalSpace6 * 0.5);
        [cell.contentView addSubview:startTimeLabel];
        
        NSString *startTimeDataLabelString = [NSString stringWithFormat:@"%@", [self.selectedTreatmentLogDictionary objectForKey:@"start_time"]];
        UILabel *startTimeDataLabel = [UILabel new];
        startTimeDataLabel.font = [HAppUIModel normalFont3];
        startTimeDataLabel.textColor = [HAppUIModel grayColor21];
        startTimeDataLabel.text = startTimeDataLabelString;
        CGSize startTimeDataLabel_Size = [startTimeDataLabelString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont3]}];
        startTimeDataLabel_Size = CGSizeMake(ceilf(startTimeDataLabel_Size.width), ceilf(startTimeDataLabel_Size.height));
        startTimeDataLabel.frame = CGRectMake(0, 0, startTimeDataLabel_Size.width, startTimeDataLabel_Size.height);
        startTimeDataLabel.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace5 + startTimeDataLabel_Size.width * 0.5), verticalSpace6 * 0.5);
        [cell.contentView addSubview:startTimeDataLabel];
        
        cell.backgroundColor = [HAppUIModel whiteColor4];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        UILabel *placementLabel = [UILabel new];
        placementLabel.font = [HAppUIModel normalFont1];
        placementLabel.textColor = [HAppUIModel grayColor20];
        placementLabel.text = NSLocalizedString(@"mine_TreatmentLog_DetailPlacement", nil);
        CGSize placementLabel_Size = [NSLocalizedString(@"mine_TreatmentLog_DetailPlacement", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        placementLabel_Size = CGSizeMake(ceilf(placementLabel_Size.width), ceilf(placementLabel_Size.height));
        placementLabel.frame = CGRectMake(0, 0, placementLabel_Size.width, placementLabel_Size.height);
        placementLabel.center = CGPointMake(horizontalSpace5 + placementLabel_Size.width * 0.5, verticalSpace7 * 0.5);
        [cell.contentView addSubview:placementLabel];
        
        NSString *position_Symptom_PlacementString = [NSString stringWithFormat:@"%@-%@-%@", [self.selectedTreatmentLogDictionary objectForKey:@"position"], [self.selectedTreatmentLogDictionary objectForKey:@"symptom"], [self.selectedTreatmentLogDictionary objectForKey:@"placement"]];
        UIImageView *positionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace6, verticalSpace8)];
        [positionImageView.layer setMasksToBounds:YES];
        [positionImageView.layer setCornerRadius:horizontalSpace3];
        
        positionImageView.center = CGPointMake(SCREEN_WIDTH - (horizontalSpace5 + horizontalSpace6 * 0.5), verticalSpace7 * 0.5);
        positionImageView.image = [UIImage imageNamed:position_Symptom_PlacementString];
        positionImageView.backgroundColor = [HAppUIModel mainColor5];
        [cell.contentView addSubview:positionImageView];
        
        cell.backgroundColor = [HAppUIModel whiteColor4];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        UIButton *treatmentAgainButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace7, verticalSpace9)];
        if ([HAppUIModel UIViewIsChinese] == YES){
            [treatmentAgainButton setImage:[UIImage imageNamed:@"treatmentAgain"] forState:UIControlStateNormal];
            [treatmentAgainButton setImage:[UIImage imageNamed:@"treatmentAgainSelected"] forState:UIControlStateSelected];
        }
        else{
            [treatmentAgainButton setImage:[UIImage imageNamed:@"treatmentAgainEng"] forState:UIControlStateNormal];
            [treatmentAgainButton setImage:[UIImage imageNamed:@"treatmentAgainSelectedEng"] forState:UIControlStateSelected];
        }

        
        treatmentAgainButton.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace5 * 0.5);
        [cell.contentView addSubview:treatmentAgainButton];
        [treatmentAgainButton addTarget:self action:@selector(treatmentAgainButtonAction) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)treatmentAgainButtonAction {
    
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        // 保持连接状态
        NSLog(@">>> Protocol Start");
        if (0 == ApplicationDelegate.deviceWorkingStutas) {
            // idel
        }
        if (1 == ApplicationDelegate.deviceWorkingStutas) {
            // run
            HBLETask *aTask;
            aTask = [[HBLETask alloc] initWithName:@"stopTreatment" andParameter:nil];
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
        if (2 == ApplicationDelegate.deviceWorkingStutas) {
            // stop
        }
        // ———————————————————————————————————— 发送协议 ————————————————————————————————————————————
        
        // 清空model
        [ApplicationDelegate reinitTreatmentingLog];
        // 开始治疗
        [self.selectedTreatmentLogDictionary valueForKey:@""];
        
        
        NSString *position_id = [NSString stringWithFormat:@"%@", [self.selectedTreatmentLogDictionary objectForKey:@"position"]];
        NSString *symptom_id = [NSString stringWithFormat:@"%@", [self.selectedTreatmentLogDictionary objectForKey:@"symptom"]];
        NSString *placement_id = [NSString stringWithFormat:@"%@", [self.selectedTreatmentLogDictionary objectForKey:@"placement"]];
        NSArray *protocolArray = [NSArray arrayWithArray:[self.selectedTreatmentLogDictionary objectForKey:@"parameters_list"]];
        NSLog(@">>> parameters_list %@",protocolArray);
        NSString *collect_feedback_period = [NSString stringWithFormat:@"5"];
        NSString *feedback_list = [NSString stringWithFormat:@"F,50000,2"];
        NSString *provider_id = [NSString stringWithFormat:@"provider_id"];
        
        //获取当前时间
        NSDate *now = [NSDate date];
        NSDateFormatter  *bufferdateformatter = [[NSDateFormatter alloc] init];
        [bufferdateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *bufferlocationString = [bufferdateformatter stringFromDate:now];            //用于设置timestamp
        NSDateFormatter  *showdateformatter = [[NSDateFormatter alloc] init];
        [showdateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *showlocationString = [bufferdateformatter stringFromDate:now];            //用于展示
        
        NSString *treatmentPosition = [NSString stringWithFormat:@"%@-%@", position_id, symptom_id];
        NSArray *treatmentArray = [NSArray arrayWithObjects:protocolArray, treatmentPosition, bufferlocationString, collect_feedback_period, feedback_list, placement_id, provider_id, nil];
        HBLETask *aTask = [[HBLETask alloc] init];
        aTask.taskName = @"requestBufferSet:";
        aTask.parameter = treatmentArray;
        [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        // —————————————————————————————————————————————————————————————————————————————————————————
        
        // ———————————————————————— 生成治疗记录（意义参考HTreatmentLog） ———————————————————————————————
        // 先清空
        ApplicationDelegate.treatmentingLog = [HtreatmentLog new];
        // 再赋值
        ApplicationDelegate.treatmentingLog.position = position_id;
        ApplicationDelegate.treatmentingLog.symptom = symptom_id;
        ApplicationDelegate.treatmentingLog.placement = placement_id;
        ApplicationDelegate.treatmentingLog.productId = ApplicationDelegate.productId;
        ApplicationDelegate.treatmentingLog.start_time = showlocationString;
        ApplicationDelegate.treatmentingLog.duration = 0;
        if (ApplicationDelegate.profile) {
            ApplicationDelegate.treatmentingLog.user_id = [NSString stringWithFormat:@"%d", [[ApplicationDelegate.profile objectForKey:@"UserId"] intValue]];
        } else {
            ApplicationDelegate.treatmentingLog.user_id = @"0";
        }
        ApplicationDelegate.treatmentingLog.log_stuta = 1;
        ApplicationDelegate.treatmentingLog.completion = 0;
        ApplicationDelegate.treatmentingLog.parameters_list = protocolArray;
        // 不做保存到治疗记录中，需要有3条或3条以上的记录才做持久化保存
        // —————————————————————————————————————————————————————————————————————————————————————————
        
        // ———————————————————————————— 跳转回护理首页 ————————————————————————————————————————————————
        // 跳回首页
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
        [self.navigationController popToRootViewControllerAnimated:YES];
        // ————————————————————————————————————————————————————————————————————————————————————————
        return;
    }
    if (0 == ApplicationDelegate.BLE_Connected_Status) {
        // 未连接状态
        [ApplicationDelegate createScanView];
        return;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return verticalSpace6;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        return verticalSpace7;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        return verticalSpace5;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return verticalSpace4;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, verticalSpace4)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Mine - TreatmentLog - Detail");
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
