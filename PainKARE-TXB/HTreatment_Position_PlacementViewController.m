//
//  HTreatment_Position_PlacementViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/8.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HTreatment_Position_PlacementViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@interface HTreatment_Position_PlacementViewController () <UIScrollViewDelegate>

@end

@implementation HTreatment_Position_PlacementViewController {
    UIView *treatment_Position_PlacementView;
    UIScrollView *treatment_Position_PlacementScrollview;
    UILabel *treatment_Position_PlacementTipLabel;
    
    CGFloat scrollViewBackgroundHeight;
    
    NSMutableArray *imageViewList;
    
    UIButton *protocolStartButton;
    
    NSMutableDictionary *selectedProtocol;
}

- (NSArray *)protocolList {
    if (!_protocolList) {
        _protocolList = [NSArray array];
    }
    return _protocolList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageViewList = [NSMutableArray array];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = self.navigationTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSLog(@">>> self.protocolList %@", self.protocolList);
    
    [self createScrollView];
    
    treatment_Position_PlacementView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    treatment_Position_PlacementView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:treatment_Position_PlacementView];
    
    treatment_Position_PlacementTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    treatment_Position_PlacementTipLabel.textColor = [HAppUIModel grayColor1];
    treatment_Position_PlacementTipLabel.font = [HAppUIModel normalFont1];
    [treatment_Position_PlacementTipLabel setTextAlignment:NSTextAlignmentCenter];
    treatment_Position_PlacementTipLabel.text = @"一句话提示";
    treatment_Position_PlacementTipLabel.alpha = 0;
    [treatment_Position_PlacementView addSubview:treatment_Position_PlacementTipLabel];
    
    // —————————————————————————————————— 数据处理 ————————————————————————————————————————————————————
    selectedProtocol = [NSMutableDictionary dictionary];
    // ————————————————————————————————————————————————————————————————————————————————————————————————————————
}

- (void)createScrollView {
    CGFloat treatmentButtonWidth = [HAppUIModel baseWidthChangeLength:329 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat methodImageViewHeight = [HAppUIModel baseLongChangeLength:225.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat radius = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat leftSpaceI = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat leftSpaceII = [HAppUIModel baseWidthChangeLength:19.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceI = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceII = [HAppUIModel baseLongChangeLength:18.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceIII = [HAppUIModel baseLongChangeLength:10.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceIV = [HAppUIModel baseLongChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceV = [HAppUIModel baseLongChangeLength:14.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceVI = [HAppUIModel baseLongChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    NSString *indications = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"treatment_Position_PlacementIndications", nil), self.indications];
    
    treatment_Position_PlacementScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44 + topSpaceI, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - 44 - topSpaceI)];
    //设置代理
    treatment_Position_PlacementScrollview.delegate = self;
    //设置背景颜色
    treatment_Position_PlacementScrollview.backgroundColor = [HAppUIModel whiteColor4];
    //取消滑条
    [treatment_Position_PlacementScrollview setShowsVerticalScrollIndicator:NO];
    [treatment_Position_PlacementScrollview setShowsHorizontalScrollIndicator:NO];
    //是否自动裁剪超出部分
    treatment_Position_PlacementScrollview.clipsToBounds = YES;
    //设置是否可以缩放
    treatment_Position_PlacementScrollview.scrollEnabled = YES;
    //设置是否可以进行页面切换
    treatment_Position_PlacementScrollview.pagingEnabled = NO;
    //设置在拖拽的时候是否锁定其在水平或垂直的方向
    treatment_Position_PlacementScrollview.directionalLockEnabled = YES;
    
    UILabel *indicationsLabel = [UILabel new];
    indicationsLabel.font = [HAppUIModel mediumFont1];
    indicationsLabel.textColor = [HAppUIModel grayColor8];
    indicationsLabel.text = indications;
    CGSize indicationsLabelSize = [indications sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont1]}];
    indicationsLabelSize = CGSizeMake(ceilf(indicationsLabelSize.width), ceilf(indicationsLabelSize.height));
    indicationsLabel.frame = CGRectMake(0, 0, indicationsLabelSize.width, indicationsLabelSize.height);
    indicationsLabel.center = CGPointMake(leftSpaceI + indicationsLabelSize.width * 0.5, topSpaceII + indicationsLabelSize.height * 0.5);
    
    UILabel *tipLabelI = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - leftSpaceI * 2, 0)];
    tipLabelI.font = [HAppUIModel normalFont2];
    tipLabelI.textColor = [HAppUIModel grayColor3];
    tipLabelI.text = NSLocalizedString(@"treatment_Position_PlacementTipI", nil);
    tipLabelI.numberOfLines = 0;
    CGSize tipLabelISize = [tipLabelI sizeThatFits:CGSizeMake(SCREEN_WIDTH - leftSpaceI * 2, MAXFLOAT)];
    CGRect tipLabelIFrame = tipLabelI.frame;
    tipLabelIFrame.size.height = tipLabelISize.height;
    [tipLabelI setFrame:tipLabelIFrame];
    tipLabelI.center = CGPointMake(SCREEN_WIDTH * 0.5, topSpaceII + indicationsLabelSize.height + topSpaceIII + tipLabelISize.height * 0.5);
    
    scrollViewBackgroundHeight = topSpaceII + indicationsLabelSize.height + topSpaceIII + tipLabelISize.height + topSpaceIII;// 先计算一次
    
    for (int i = 0; i < [self.protocolList count]; i++) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
        numberFormatter.locale = locale;
        NSString *numString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:(i + 1)]];
        NSString *methodNum = [NSString stringWithFormat:@"%@%@：", NSLocalizedString(@"treatment_Position_PlacementMethod", nil), numString];
        
        UILabel *methodNumLabel = [UILabel new];
        methodNumLabel.font = [HAppUIModel normalFont6];
        methodNumLabel.textColor = [HAppUIModel grayColor5];
        methodNumLabel.text = methodNum;
        CGSize methodNumLabelSize = [methodNum sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont6]}];
        methodNumLabelSize = CGSizeMake(ceilf(methodNumLabelSize.width), ceilf(methodNumLabelSize.height));
        methodNumLabel.frame = CGRectMake(0, 0, methodNumLabelSize.width, methodNumLabelSize.height);
        methodNumLabel.center = CGPointMake(leftSpaceI + methodNumLabelSize.width * 0.5, topSpaceIII + methodNumLabelSize.height * 0.5);
        
        UIImageView *methodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - leftSpaceII * 2, methodImageViewHeight)];
        NSDictionary *nowProtocol = [self.protocolList objectAtIndex:i];
        NSString *imageNameString = [NSString stringWithFormat:@"%@-%@-%@", [nowProtocol valueForKey:@"position"], [nowProtocol valueForKey:@"symptom"], [nowProtocol valueForKey:@"placement"]];
        methodImageView.image = [UIImage imageNamed:imageNameString];
        methodImageView.backgroundColor = [UIColor whiteColor];
        methodImageView.center = CGPointMake(SCREEN_WIDTH * 0.5, topSpaceIII + methodNumLabelSize.height + topSpaceIV + methodImageViewHeight * 0.5);
        [methodImageView.layer setMasksToBounds:YES];
        [methodImageView.layer setCornerRadius:radius];
        [methodImageView.layer setBorderColor:[HAppUIModel grayColor14].CGColor];
        [methodImageView.layer setBorderWidth:[HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]];
        
        methodImageView.userInteractionEnabled = YES;
        
        //创建手势对象
        UITapGestureRecognizer *methodImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(methodImageViewTapAction:)];
        methodImageViewTap.numberOfTapsRequired = 1;
        methodImageViewTap.numberOfTouchesRequired = 1;
        [methodImageView addGestureRecognizer:methodImageViewTap];
        [imageViewList addObject:methodImageView];
        
        UIView *methodView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollViewBackgroundHeight, SCREEN_WIDTH, topSpaceIII + methodNumLabelSize.height + topSpaceIV + methodImageViewHeight + topSpaceV)];
        methodView.backgroundColor = [UIColor clearColor];
        [methodView addSubview:methodNumLabel];
        [methodView addSubview:methodImageView];
        [treatment_Position_PlacementScrollview addSubview:methodView];
        
        scrollViewBackgroundHeight += topSpaceIII + methodNumLabelSize.height + topSpaceIV + methodImageViewHeight + topSpaceV;
    }
    
    UILabel *tipLabelII = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - leftSpaceI * 2, 0)];
    tipLabelII.font = [HAppUIModel normalFont2];
    tipLabelII.textColor = [HAppUIModel grayColor3];
    tipLabelII.text = NSLocalizedString(@"treatment_Position_PlacementTipII", nil);
    tipLabelII.numberOfLines = 0;
    CGSize tipLabelIISize = [tipLabelII sizeThatFits:CGSizeMake(SCREEN_WIDTH - leftSpaceI * 2, MAXFLOAT)];
    CGRect tipLabelIIFrame = tipLabelII.frame;
    tipLabelIIFrame.size.height = tipLabelIISize.height;
    [tipLabelII setFrame:tipLabelIIFrame];
    tipLabelII.center = CGPointMake(SCREEN_WIDTH * 0.5, scrollViewBackgroundHeight + topSpaceVI + tipLabelIISize.height * 0.5);
    
    scrollViewBackgroundHeight += topSpaceVI + tipLabelIISize.height;
    
    protocolStartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, treatmentButtonWidth, treatmentButtonWidth * 52 / 329)];
    protocolStartButton.center = CGPointMake(SCREEN_WIDTH * 0.5, scrollViewBackgroundHeight + topSpaceIV + (treatmentButtonWidth * 52 / 329) * 0.5);
    if ([HAppUIModel UIViewIsChinese] == YES){
        [protocolStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStart"] forState:UIControlStateNormal];
        [protocolStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStartSelected"] forState:UIControlStateHighlighted];
        [protocolStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentDisable"] forState:UIControlStateDisabled];
    }
    else{
        [protocolStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStartEng"] forState:UIControlStateNormal];
        [protocolStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStartSelectedEng"] forState:UIControlStateHighlighted];
        [protocolStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentDisableEng"] forState:UIControlStateDisabled];
    }

    
    [protocolStartButton addTarget:self action:@selector(protocolStartButton:) forControlEvents:UIControlEventTouchUpInside];
    [protocolStartButton setEnabled:NO];
    
    scrollViewBackgroundHeight += topSpaceIV + (treatmentButtonWidth * 52 / 329) + topSpaceIV;
    
    [treatment_Position_PlacementScrollview addSubview:indicationsLabel];
    [treatment_Position_PlacementScrollview addSubview:tipLabelI];
    [treatment_Position_PlacementScrollview addSubview:tipLabelII];
    [treatment_Position_PlacementScrollview addSubview:protocolStartButton];
    [treatment_Position_PlacementScrollview setContentSize:CGSizeMake(0, scrollViewBackgroundHeight)];
    [self.view addSubview:treatment_Position_PlacementScrollview];
}

// 开始治疗按钮
- (void)protocolStartButton:(UIButton *)sender {
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        // 保持连接状态
        NSLog(@">>> Protocol Start");
        if (0 == ApplicationDelegate.deviceWorkingStutas) {
            // idel
        }
        if (1 == ApplicationDelegate.deviceWorkingStutas) {
            // run
//            HBLETask *aTask;
//            aTask = [[HBLETask alloc] initWithName:@"stopTreatment" andParameter:nil];
//            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
        if (2 == ApplicationDelegate.deviceWorkingStutas) {
            // stop
        }
        // ———————————————————————————————————— 发送协议 ————————————————————————————————————————————
        
        // 清空model
        [ApplicationDelegate reinitTreatmentingLog];
        // 开始治疗
        NSString *position_id = [NSString stringWithFormat:@"%@", [selectedProtocol objectForKey:@"position"]];
        NSString *symptom_id = [NSString stringWithFormat:@"%@", [selectedProtocol objectForKey:@"symptom"]];
        NSString *placement_id = [NSString stringWithFormat:@"%@", [selectedProtocol objectForKey:@"placement"]];
        NSArray *protocolArray = [NSArray arrayWithArray:[selectedProtocol objectForKey:@"parameters_list"]];
        NSLog(@">>> parameters_list %@",protocolArray);
        NSString *collect_feedback_period = [NSString stringWithFormat:@"%@", [selectedProtocol objectForKey:@"collect_feedback_period"]];
        NSString *feedback_list = [NSString stringWithFormat:@"%@", [selectedProtocol objectForKey:@"feedback_list"]];
        NSString *provider_id = [NSString stringWithFormat:@"%@", [selectedProtocol objectForKey:@"provider_id"]];
        
        [ApplicationDelegate.bleCommunicationManager clearTasks];
        
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
        // ———————————————————————————————————————————————————————————————————————————————————————
        
        // ————————————————————————————— 生成治疗记录（意义参考HTreatmentLog） ————————————————————————
        // 先清空
        [ApplicationDelegate reinitTreatmentingLog];
        // 再赋值
        ApplicationDelegate.treatmentingLog.position = [selectedProtocol objectForKey:@"position"];
        ApplicationDelegate.treatmentingLog.symptom = [selectedProtocol objectForKey:@"symptom"];
        ApplicationDelegate.treatmentingLog.placement = [selectedProtocol objectForKey:@"placement"];
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
        ApplicationDelegate.treatmentingLog.parameters_list = [selectedProtocol objectForKey:@"parameters_list"];
        // 不做保存到治疗记录中，需要有3条或3条以上的记录才做持久化保存
        // ——————————————————————————————————————————————————————————————————————————————————————
        
        // ———————————————————————————— 跳转回护理首页 —————————————————————————————————————————————
        // 跳回首页
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
        [self.navigationController popToRootViewControllerAnimated:YES];
        // ———————————————————————————————————————————————————————————————————————————————————————
        return;
    }
    if (0 == ApplicationDelegate.BLE_Connected_Status) {
        // 未连接状态
        [ApplicationDelegate createScanView];
        return;
    }
}

- (void)methodImageViewTapAction:(UIGestureRecognizer *)tap {
    NSLog(@">>> TapAction");
    UIView *selectImageView = tap.view;
    CGFloat radiusI = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat radiusII = [HAppUIModel baseWidthChangeLength:14.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    for (int i = 0; i < [imageViewList count]; i++) {
        UIView *view = [imageViewList objectAtIndex:i];
        if (view == selectImageView) {
            NSLog(@"%d", i);
            [view.layer setCornerRadius:radiusII];
            [view.layer setBorderColor:[HAppUIModel mainColor1].CGColor];
            [view.layer setBorderWidth:[HAppUIModel baseWidthChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]];
            [self changeProtocolStartButtonStutas];
            selectedProtocol = [self.protocolList objectAtIndex:i];
            NSLog(@">>> selectedProtocol %@", selectedProtocol);
        } else {
            [view.layer setCornerRadius:radiusI];
            [view.layer setBorderColor:[HAppUIModel grayColor14].CGColor];
            [view.layer setBorderWidth:[HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]];
        }
    }
}

// ———————————————————————————————— 方法 ————————————————————————————————————————————————————
// 更改启动护理的按钮状态
- (void)changeProtocolStartButtonStutas {
    if (![protocolStartButton isEnabled]) {
        [protocolStartButton setEnabled:YES];
    }
}
// ——————————————————————————————————————————————————————————————————————————————————————————————————

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Treatment - Position - Placement");
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
