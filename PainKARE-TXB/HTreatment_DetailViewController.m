//
//  HTreatment_DetailViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/15.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HTreatment_DetailViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

#import "HTreatment_DetailChartView.h"

@interface HTreatment_DetailViewController ()

@end

@implementation HTreatment_DetailViewController {
    UIView *topView;
    UIView *backgroundView;
    UILabel *durationDataLabel;
    
    UILabel *resistanceDataLabel;
    UILabel *reactanceDataLabel;
    UILabel *phaseDataLabel;
    
    HTreatment_DetailChartView *treatment_DetailChartView;
    
    CGFloat radiusI;
    CGFloat radiusII;
    
    CGFloat horizontalSpaceI;
    CGFloat horizontalSpaceII;
    CGFloat horizontalSpaceIII;
    CGFloat horizontalSpaceIV;
    CGFloat horizontalSpaceV;
    CGFloat horizontalSpaceVI;
    CGFloat horizontalSpaceVII;
    
    CGFloat verticalSpaceI;
    CGFloat verticalSpaceII;
    CGFloat verticalSpaceIII;
    CGFloat verticalSpaceIV;
    CGFloat verticalSpaceV;
    CGFloat verticalSpaceVI;
    CGFloat verticalSpaceVII;
    CGFloat verticalSpaceVIII;
    CGFloat verticalSpaceIX;
    CGFloat verticalSpaceX;
    CGFloat verticalSpaceXI;
    CGFloat verticalSpaceXII;
    CGFloat verticalSpaceXIII;
    CGFloat verticalSpaceXIV;
    
    CGSize resistanceLabel_Size;
    CGSize reactanceLabel_Size;
    
    // ———————————————————— 测试 ————————————————————————————
    NSMutableDictionary *treatment_detail_Data;
    // ————————————————————————————————————————————————————————
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ———————————————————————————————— 通知 ————————————————————————————————————————————————————
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataDetailDataNotificationAction) name:@"updataDetailDataNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataDetailDurationNotificationAction) name:@"updataDetailDurationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataDetailChartViewNotificationAction) name:@"updataDetailChartViewNotification" object:nil];
    // ————————————————————————————————————————————————————————————————————————————————————————————————
    
    radiusI = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    radiusII = [HAppUIModel baseWidthChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    horizontalSpaceI = [HAppUIModel baseWidthChangeLength:16.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceII = [HAppUIModel baseWidthChangeLength:155.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceIII = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceIV = [HAppUIModel baseWidthChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceV = [HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceVI = [HAppUIModel baseWidthChangeLength:208.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    horizontalSpaceVII = [HAppUIModel baseWidthChangeLength:244.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    verticalSpaceI = [HAppUIModel baseLongChangeLength:87.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceII = [HAppUIModel baseLongChangeLength:129.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceIII = [HAppUIModel baseLongChangeLength:206.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceIV = [HAppUIModel baseLongChangeLength:206.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceV = [HAppUIModel baseLongChangeLength:29.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceVI = [HAppUIModel baseLongChangeLength:130.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceVII = [HAppUIModel baseLongChangeLength:38.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceVIII = [HAppUIModel baseLongChangeLength:36.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceIX = [HAppUIModel baseLongChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceX = [HAppUIModel baseLongChangeLength:114.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceXI = [HAppUIModel baseLongChangeLength:31.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceXII = [HAppUIModel baseLongChangeLength:93.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceXIII = [HAppUIModel baseLongChangeLength:240.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    verticalSpaceXIV = [HAppUIModel baseLongChangeLength:368.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    self.view.backgroundColor = [HAppUIModel whiteColor1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"treatment_DetailNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:235.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    topView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:topView];
    
    // ———————————————————————————— 数据显示View ——————————————————————————————————————————————
    // line左边
    NSString *durationDataLabelString;
    if (ApplicationDelegate.treatmentingLog.duration) {
        if ((int)ApplicationDelegate.treatmentingLog.phase.count == 0) {
            durationDataLabelString = [NSString stringWithFormat:@"0%@%@", NSLocalizedString(@"treatment_DetailMinute", nil), NSLocalizedString(@"treatment_DetailMonitorData", nil)];
        } else {
            durationDataLabelString = [NSString stringWithFormat:@"%d%@%@", ((int)ApplicationDelegate.treatmentingLog.phase.count - 1) * 5, NSLocalizedString(@"treatment_DetailMinute", nil), NSLocalizedString(@"treatment_DetailMonitorData", nil)];
        }
    } else {
        durationDataLabelString = [NSString stringWithFormat:@"0%@%@", NSLocalizedString(@"treatment_DetailMinute", nil), NSLocalizedString(@"treatment_DetailMonitorData", nil)];
    }
    durationDataLabel = [UILabel new];
    durationDataLabel.font = [HAppUIModel mediumFont7];
    durationDataLabel.textColor = [UIColor whiteColor];
    durationDataLabel.text = durationDataLabelString;
    CGSize durationDataLabel_Size = [durationDataLabelString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont7]}];
    durationDataLabel_Size = CGSizeMake(ceilf(durationDataLabel_Size.width), ceilf(durationDataLabel_Size.height));
    durationDataLabel.frame = CGRectMake(0, 0, durationDataLabel_Size.width, durationDataLabel_Size.height);
    durationDataLabel.center = CGPointMake(horizontalSpaceI + durationDataLabel_Size.width * 0.5, verticalSpaceI + durationDataLabel_Size.height * 0.5);
    [topView addSubview:durationDataLabel];
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(horizontalSpaceI, verticalSpaceII, SCREEN_WIDTH - horizontalSpaceI * 2, verticalSpaceIII)];
    [backgroundView.layer setCornerRadius:radiusI];
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;    //设置阴影的颜色
    backgroundView.layer.shadowOpacity = 0.30;                          //设置阴影的透明度
    backgroundView.layer.shadowOffset = CGSizeMake(0, 0);               //设置阴影的偏移量
    backgroundView.layer.shadowRadius = radiusII;                       //设置阴影的圆角
    backgroundView.backgroundColor = [HAppUIModel whiteColor1];
    [self.view addSubview:backgroundView];
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpaceII, horizontalSpaceII)];
    circleView.backgroundColor = [HAppUIModel whiteColor1];
    [circleView.layer setMasksToBounds:YES];
    [circleView.layer setCornerRadius:horizontalSpaceII * 0.5];
    [circleView.layer setBorderColor:[HAppUIModel orangeColor2].CGColor];
    [circleView.layer setBorderWidth:horizontalSpaceIII];
    circleView.center = CGPointMake(horizontalSpaceIV + horizontalSpaceII * 0.5, verticalSpaceV + horizontalSpaceII * 0.5);
    [backgroundView addSubview:circleView];
    
    NSString *lastPhaseDataString;
    if (0 != [ApplicationDelegate.treatmentingLog.phase count]) {
        lastPhaseDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.phase lastObject]];
        
        NSArray *lastPhaseArray = [lastPhaseDataString componentsSeparatedByString:@"-"];
        NSLog(@"array:%@", lastPhaseArray);
        if (lastPhaseArray.count == 2) {
            lastPhaseDataString = lastPhaseArray[1];
        }
    } else {
        lastPhaseDataString = @"--";
    }
    phaseDataLabel = [UILabel new];
    phaseDataLabel.font = [HAppUIModel numberFont3];
    phaseDataLabel.textColor = [HAppUIModel orangeColor1];
    phaseDataLabel.text = lastPhaseDataString;
    CGSize phaseDataLabel_Size = [lastPhaseDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont3]}];
    phaseDataLabel_Size = CGSizeMake(ceilf(phaseDataLabel_Size.width), ceilf(phaseDataLabel_Size.height));
    phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabel_Size.width, phaseDataLabel_Size.height);
    phaseDataLabel.center = CGPointMake(horizontalSpaceII * 0.5, verticalSpaceXI + phaseDataLabel_Size.height * 0.5);
    [circleView addSubview:phaseDataLabel];
    
    UILabel *phaseLabel = [UILabel new];
    phaseLabel.font = [HAppUIModel normalFont2];
    phaseLabel.textColor = [HAppUIModel orangeColor2];
    phaseLabel.text = NSLocalizedString(@"treatment_DetailPhase", nil);
    CGSize phaseLabel_Size = [NSLocalizedString(@"treatment_DetailPhase", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    phaseLabel_Size = CGSizeMake(ceilf(phaseLabel_Size.width), ceilf(phaseLabel_Size.height));
    phaseLabel.frame = CGRectMake(0, 0, phaseLabel_Size.width, phaseLabel_Size.height);
    phaseLabel.center = CGPointMake(horizontalSpaceII * 0.5, verticalSpaceXII + phaseLabel_Size.height * 0.5);
    [circleView addSubview:phaseLabel];
    
    // 竖线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(horizontalSpaceVI, verticalSpaceVII, horizontalSpaceV, verticalSpaceVI)];
    lineView.backgroundColor = [HAppUIModel whiteColor5];
    [backgroundView addSubview:lineView];
    
    // line右边
    UILabel *resistanceLabel = [UILabel new];
    resistanceLabel.font = [HAppUIModel normalFont2];
    resistanceLabel.textColor = [HAppUIModel grayColor15];
    resistanceLabel.text = NSLocalizedString(@"treatment_DetailResistance", nil);
    resistanceLabel_Size = [NSLocalizedString(@"treatment_DetailResistance", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    resistanceLabel_Size = CGSizeMake(ceilf(resistanceLabel_Size.width), ceilf(resistanceLabel_Size.height));
    resistanceLabel.frame = CGRectMake(0, 0, resistanceLabel_Size.width, resistanceLabel_Size.height);
    resistanceLabel.center = CGPointMake(horizontalSpaceVII + resistanceLabel_Size.width * 0.5, verticalSpaceVIII + resistanceLabel_Size.height * 0.5);
    [backgroundView addSubview:resistanceLabel];
    
    NSString *lastResistanceDataString;
    if (0 != [ApplicationDelegate.treatmentingLog.resistance count]) {
        lastResistanceDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.resistance lastObject]];
    } else {
        lastResistanceDataString = @"--";
    }
    resistanceDataLabel = [UILabel new];
    resistanceDataLabel.font = [HAppUIModel numberFont2];
    resistanceDataLabel.textColor = [HAppUIModel purpleColor1];
    resistanceDataLabel.text = lastResistanceDataString;
    CGSize resistanceDataLabel_Size = [lastResistanceDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont2]}];
    resistanceDataLabel_Size = CGSizeMake(ceilf(resistanceDataLabel_Size.width), ceilf(resistanceDataLabel_Size.height));
    resistanceDataLabel.frame = CGRectMake(0, 0, resistanceDataLabel_Size.width, resistanceDataLabel_Size.height);
    resistanceDataLabel.center = CGPointMake(horizontalSpaceVII + resistanceDataLabel_Size.width * 0.5, verticalSpaceVIII + resistanceLabel_Size.height + verticalSpaceIX + resistanceDataLabel_Size.height * 0.5);
    [backgroundView addSubview:resistanceDataLabel];
    
    
    UILabel *reactanceLabel = [UILabel new];
    reactanceLabel.font = [HAppUIModel normalFont2];
    reactanceLabel.textColor = [HAppUIModel grayColor15];
    reactanceLabel.text = NSLocalizedString(@"treatment_DetailReactance", nil);
    reactanceLabel_Size = [NSLocalizedString(@"treatment_DetailReactance", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    reactanceLabel_Size = CGSizeMake(ceilf(reactanceLabel_Size.width), ceilf(reactanceLabel_Size.height));
    reactanceLabel.frame = CGRectMake(0, 0, reactanceLabel_Size.width, reactanceLabel_Size.height);
    reactanceLabel.center = CGPointMake(horizontalSpaceVII + reactanceLabel_Size.width * 0.5, verticalSpaceX + reactanceLabel_Size.height * 0.5);
    [backgroundView addSubview:reactanceLabel];
    
    
    NSString *lastReactanceDataString;
    if (0 != [ApplicationDelegate.treatmentingLog.reactance count]) {
        lastReactanceDataString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.reactance lastObject]];
    } else {
        lastReactanceDataString = @"--";
    }
    reactanceDataLabel = [UILabel new];
    reactanceDataLabel.font = [HAppUIModel numberFont2];
    reactanceDataLabel.textColor = [HAppUIModel greenColor1];
    reactanceDataLabel.text = lastReactanceDataString;
    CGSize reactanceDataLabel_Size = [lastReactanceDataString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont2]}];
    reactanceDataLabel_Size = CGSizeMake(ceilf(reactanceDataLabel_Size.width), ceilf(reactanceDataLabel_Size.height));
    reactanceDataLabel.frame = CGRectMake(0, 0, reactanceDataLabel_Size.width, reactanceDataLabel_Size.height);
    reactanceDataLabel.center = CGPointMake(horizontalSpaceVII + reactanceDataLabel_Size.width * 0.5, verticalSpaceX + reactanceLabel_Size.height + verticalSpaceIX + reactanceDataLabel_Size.height * 0.5);
    [backgroundView addSubview:reactanceDataLabel];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————————
    
    // —————————————————————————————————— 曲线图 ————————————————————————————————————————————————————
    treatment_DetailChartView = [[HTreatment_DetailChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, verticalSpaceXIII)];
    treatment_DetailChartView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpaceXIV + verticalSpaceXIII * 0.5);
    if (0 != [ApplicationDelegate.treatmentingLog.phase count] && 0 != [ApplicationDelegate.treatmentingLog.resistance count] && 0 != [ApplicationDelegate.treatmentingLog.reactance count]) {
        treatment_DetailChartView.phaseArray = ApplicationDelegate.treatmentingLog.phase;
        treatment_DetailChartView.resistanceArray = ApplicationDelegate.treatmentingLog.resistance;
        treatment_DetailChartView.reactanceArray = ApplicationDelegate.treatmentingLog.reactance;
        [treatment_DetailChartView initWithView];
    }
    [self.view addSubview:treatment_DetailChartView];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————————
}

// ———————————————————————————————————— 方法 ————————————————————————————————————————————————
// 更新显示的3个数据
- (void)updataDetailData {
    // phase
    NSString *phaseString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.phase lastObject]];
    NSArray *phaseArray = [phaseString componentsSeparatedByString:@"-"];
    NSLog(@"array:%@", phaseArray);
    if (phaseArray.count == 2) {
        phaseString = phaseArray[1];
    }
//    if ([phaseString intValue] < 0) {
//        int i = [phaseString intValue];
//        i = -i;
//        phaseString = [NSString stringWithFormat:@"%d", i];
//    }
    phaseDataLabel.text = [NSString stringWithFormat:@"%@", phaseString];
    CGSize phaseDataLabel_Size = [phaseString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont3]}];
    phaseDataLabel_Size = CGSizeMake(ceilf(phaseDataLabel_Size.width), ceilf(phaseDataLabel_Size.height));
    phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabel_Size.width, phaseDataLabel_Size.height);
    phaseDataLabel.center = CGPointMake(horizontalSpaceII * 0.5, verticalSpaceXI + phaseDataLabel_Size.height * 0.5);
    // resistance
    resistanceDataLabel.text = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.resistance lastObject]];
    CGSize resistanceDataLabel_Size = [[ApplicationDelegate.treatmentingLog.resistance lastObject] sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont2]}];
    resistanceDataLabel_Size = CGSizeMake(ceilf(resistanceDataLabel_Size.width), ceilf(resistanceDataLabel_Size.height));
    resistanceDataLabel.frame = CGRectMake(0, 0, resistanceDataLabel_Size.width, resistanceDataLabel_Size.height);
    resistanceDataLabel.center = CGPointMake(horizontalSpaceVII + resistanceDataLabel_Size.width * 0.5, verticalSpaceVIII + resistanceLabel_Size.height + verticalSpaceIX + resistanceDataLabel_Size.height * 0.5);
    // reactance
    reactanceDataLabel.text = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.reactance lastObject]];
    CGSize reactanceDataLabel_Size = [[ApplicationDelegate.treatmentingLog.reactance lastObject] sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont2]}];
    reactanceDataLabel_Size = CGSizeMake(ceilf(reactanceDataLabel_Size.width), ceilf(reactanceDataLabel_Size.height));
    reactanceDataLabel.frame = CGRectMake(0, 0, reactanceDataLabel_Size.width, reactanceDataLabel_Size.height);
    reactanceDataLabel.center = CGPointMake(horizontalSpaceVII + reactanceDataLabel_Size.width * 0.5, verticalSpaceX + reactanceLabel_Size.height + verticalSpaceIX + reactanceDataLabel_Size.height * 0.5);
}
// 更新 durationLabel
- (void)updataDetailDurationLabel {
//    NSString *durationDataLabelString = [NSString stringWithFormat:@"%d%@%@", ApplicationDelegate.treatmentingLog.duration, NSLocalizedString(@"treatment_DetailMinute", nil), NSLocalizedString(@"treatment_DetailMonitorData", nil)];
    NSString *durationDataLabelString;
    if ((int)ApplicationDelegate.treatmentingLog.phase.count == 0) {
        durationDataLabelString = [NSString stringWithFormat:@"0%@%@", NSLocalizedString(@"treatment_DetailMinute", nil), NSLocalizedString(@"treatment_DetailMonitorData", nil)];
    } else {
        durationDataLabelString = [NSString stringWithFormat:@"%d%@%@", ((int)ApplicationDelegate.treatmentingLog.phase.count - 1) * 5, NSLocalizedString(@"treatment_DetailMinute", nil), NSLocalizedString(@"treatment_DetailMonitorData", nil)];
    }
    
    durationDataLabel.text = durationDataLabelString;
    CGSize durationDataLabel_Size = [durationDataLabelString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont7]}];
    durationDataLabel_Size = CGSizeMake(ceilf(durationDataLabel_Size.width), ceilf(durationDataLabel_Size.height));
    durationDataLabel.frame = CGRectMake(0, 0, durationDataLabel_Size.width, durationDataLabel_Size.height);
    durationDataLabel.center = CGPointMake(horizontalSpaceI + durationDataLabel_Size.width * 0.5, verticalSpaceI + durationDataLabel_Size.height * 0.5);
}
// 更新曲线图
- (void)updataDetailChartView {
    if (0 != [ApplicationDelegate.treatmentingLog.phase count] && 0 != [ApplicationDelegate.treatmentingLog.resistance count] && 0 != [ApplicationDelegate.treatmentingLog.reactance count]) {
        // 清空视图
        [treatment_DetailChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        treatment_DetailChartView.phaseArray = ApplicationDelegate.treatmentingLog.phase;
        treatment_DetailChartView.resistanceArray = ApplicationDelegate.treatmentingLog.resistance;
        treatment_DetailChartView.reactanceArray = ApplicationDelegate.treatmentingLog.reactance;
        [treatment_DetailChartView initWithView];
    }
}
// ——————————————————————————————————————————————————————————————————————————————————————————————————————————

// —————————————————————————————————— 通知方法 ————————————————————————————————————————————
- (void)updataDetailDataNotificationAction {
    [self updataDetailData];
}
- (void)updataDetailDurationNotificationAction {
    [self updataDetailDurationLabel];
}
- (void)updataDetailChartViewNotificationAction {
    [self updataDetailChartView];
}
// ——————————————————————————————————————————————————————————————————————————————————————————————————————————

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Treatment - Detail");
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
