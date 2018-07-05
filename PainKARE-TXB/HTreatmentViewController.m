//
//  HTreatmentViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/22.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HTreatmentViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

#import "HWhirlingView.h"

#import "HTreatment_PositionViewController.h"
#import "HTreatment_DetailViewController.h"
#import "HMine_ProfileViewController.h"

#import <AFNetworking/AFNetworking.h>

@interface HTreatmentViewController ()

@end

@implementation HTreatmentViewController {
    // All
    UIView *treatmentTopView;
    UIView *backgroundView;
    UIButton *treatmentStartButton;
    UIButton *treatmentStopButton;
    
    UILabel *connectStyleLabel;
    UILabel *batteryPowerLabel;
    UIImageView *connectStyleImageView;
    UIImageView *batteryPowerImageView;
    
    UIView *moreInformationBackgroundView;
    UILabel *moreInformationLabel;
    
    // StyleOne
    UIView *displayView;
    HWhirlingView *whirlingView;
    BOOL isStartWhirling;
    
    UILabel *phaseDataLabel;
    UILabel *durationDataLabel;
    
    
    CGFloat imageViewSideLength;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ———————————————————————————————————— 通知 —————————————————————————————————————————————————————
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectedNotificationAction) name:@"connectedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataDeviceBatteryNotificationAction) name:@"updataDeviceBatteryNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataWorkingStutaNotificationAction) name:@"updataWorkingStutaNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataGenerationPhaseNotificationAction) name:@"updataGenerationPhaseNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataGenerationDurationNotificationAction) name:@"updataGenerationDurationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(R0501NotificationAction) name:@"R0501Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataMainNotificationAction) name:@"updataMainNotification" object:nil];
    // —————————————————————————————————————————————————————————————————————————————————————————————
    self.view.backgroundColor = [HAppUIModel whiteColor1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 设置 navigationTitle
    self.navigationItem.title = NSLocalizedString(@"treatmentNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // —————————————————————————————————————— 数据 ——————————————————————————————————————————————————
    imageViewSideLength = [HAppUIModel baseWidthChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    // —————————————————————————————————————————————————————————————————————————————————————————————
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    treatmentTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.33)];
    treatmentTopView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:treatmentTopView];
    
    CGFloat radiusI = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat radiusII = [HAppUIModel baseWidthChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_HEIGHT * 0.10, SCREEN_WIDTH * 0.9, SCREEN_HEIGHT * 0.70)];
    [backgroundView.layer setCornerRadius:radiusI];
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    backgroundView.layer.shadowOpacity = 0.30;//设置阴影的透明度
    backgroundView.layer.shadowOffset = CGSizeMake(0, 0);//设置阴影的偏移量
    backgroundView.layer.shadowRadius = radiusII;//设置阴影的圆角
    backgroundView.backgroundColor = [HAppUIModel whiteColor1];
    [self.view addSubview:backgroundView];
    [self createViewStyleOne];
    
    // ———————————————————— 初始化蓝牙 ——————————————————————————————————————————————————————————
    [ApplicationDelegate initBLEMamager];
    // ——————————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————— 设备状态 ————————————————————————————————————————————————————————————
    connectStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake([HAppUIModel baseWidthChangeLength:26 baceWidthWithModel:ApplicationDelegate.myAppScreenModel], [HAppUIModel baseLongChangeLength:24 baceWidthWithModel:ApplicationDelegate.myAppScreenModel], 0, 0)];
    connectStyleLabel.font = [HAppUIModel normalFont1];
    connectStyleLabel.textColor = [HAppUIModel grayColor1];
//    connectStyleLabel.text = NSLocalizedString(@"treatmentConnectStyle-Disconnected", nil);
//    CGSize connectStyleLabelSize = [NSLocalizedString(@"treatmentConnectStyle-Disconnected", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
//    connectStyleLabelSize = CGSizeMake(ceilf(connectStyleLabelSize.width), ceilf(connectStyleLabelSize.height));
//    connectStyleLabel.frame = CGRectMake(connectStyleLabel.frame.origin.x, connectStyleLabel.frame.origin.y, connectStyleLabelSize.width, connectStyleLabelSize.height);
    [backgroundView addSubview:connectStyleLabel];
    
    CGFloat imageViewSideLength = [HAppUIModel baseWidthChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    connectStyleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewSideLength, imageViewSideLength)];
//    connectStyleImageView.image = [UIImage imageNamed:@"disconnect"];
    [backgroundView addSubview:connectStyleImageView];
    
    [self changeconnectStylePutout];
    
    batteryPowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [HAppUIModel baseLongChangeLength:24 baceWidthWithModel:ApplicationDelegate.myAppScreenModel], 0, 0)];
    NSString *batteryPowerLabel_Text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"treatmentBatteryPower", nil), @"100%"];
    batteryPowerLabel.text = batteryPowerLabel_Text;
    batteryPowerLabel.font = [HAppUIModel normalFont1];
    batteryPowerLabel.textColor = [HAppUIModel grayColor1];
    CGSize batteryPowerLabelSize = [batteryPowerLabel_Text sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
    batteryPowerLabelSize = CGSizeMake(ceilf(batteryPowerLabelSize.width), ceilf(batteryPowerLabelSize.height));
    batteryPowerLabel.frame = CGRectMake(SCREEN_WIDTH * 0.9 - [HAppUIModel baseWidthChangeLength:26 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] - imageViewSideLength - [HAppUIModel baseWidthChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel] - batteryPowerLabelSize.width, batteryPowerLabel.frame.origin.y, batteryPowerLabelSize.width, batteryPowerLabelSize.height);
    [backgroundView addSubview:batteryPowerLabel];
    [batteryPowerLabel setHidden:YES];
    
    batteryPowerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewSideLength, imageViewSideLength)];
    batteryPowerImageView.center = CGPointMake(SCREEN_WIDTH * 0.9 - [HAppUIModel baseWidthChangeLength:26.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel] - imageViewSideLength * 0.5, connectStyleLabel.frame.origin.y + batteryPowerLabelSize.height * 0.5);
//    batteryPowerImageView.image = [UIImage imageNamed:@"batteryThree"];
    [backgroundView addSubview:batteryPowerImageView];
    [batteryPowerImageView setHidden:YES];
    // ————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————— 查看详细信息 ————————————————————————————————————————————————————————————
    
    moreInformationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    moreInformationLabel.text = NSLocalizedString(@"treatmentMoreInformation", nil);
    moreInformationLabel.textColor = [HAppUIModel orangeColor2];
    moreInformationLabel.font = [HAppUIModel mediumFont2];
    CGSize moreInformationLabelSize = [NSLocalizedString(@"treatmentMoreInformation", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
    moreInformationLabelSize = CGSizeMake(ceilf(moreInformationLabelSize.width), ceilf(moreInformationLabelSize.height));
    moreInformationLabel.frame = CGRectMake(0, 0, moreInformationLabelSize.width, moreInformationLabelSize.height);
    NSLog(@"width --> %fl",moreInformationLabelSize.width);
    NSLog(@"height --> %fl",moreInformationLabelSize.height);
    
    
    CGFloat moreInformationImageViewSideLength = [HAppUIModel baseWidthChangeLength:20.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    UIImageView *moreInformationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, moreInformationImageViewSideLength, moreInformationImageViewSideLength)];
    moreInformationImageView.image = [UIImage imageNamed:@"more"];
    
    CGFloat moreInformationBackgroundWidth = moreInformationLabelSize.width + [HAppUIModel baseWidthChangeLength:12.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + moreInformationImageViewSideLength;
    CGFloat moreInformationBackgroundHeight = [HAppUIModel baseWidthChangeLength:44.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    moreInformationBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, moreInformationBackgroundWidth, moreInformationBackgroundHeight)];
    moreInformationBackgroundView.center = CGPointMake(SCREEN_WIDTH * 0.45, SCREEN_HEIGHT * 0.70 - [HAppUIModel baseWidthChangeLength:64.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]);
//    moreInformationBackgroundView.backgroundColor = [UIColor redColor];
    
    moreInformationLabel.center = CGPointMake(moreInformationLabelSize.width * 0.5, moreInformationBackgroundHeight * 0.5);
    moreInformationImageView.center = CGPointMake(moreInformationBackgroundWidth - moreInformationImageViewSideLength * 0.5, moreInformationBackgroundHeight * 0.5);
    
    [moreInformationBackgroundView addSubview:moreInformationLabel];
    [moreInformationBackgroundView addSubview:moreInformationImageView];
    UITapGestureRecognizer *moreInformationBackgroundViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreInformationBackgroundViewTap:)];
    moreInformationBackgroundViewTap.numberOfTapsRequired = 1;
    moreInformationBackgroundViewTap.numberOfTouchesRequired = 1;
    [moreInformationBackgroundView addGestureRecognizer:moreInformationBackgroundViewTap];
    
    [backgroundView addSubview:moreInformationBackgroundView];
    
    // —————————————————————————————————————————————————————————————————————————————————————————————
    
    // ———————————————————— 启动/停止按钮 ————————————————————————————————————————————————————————————
    CGFloat treatmentButtonWidth = [HAppUIModel baseWidthChangeLength:329 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    treatmentStartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, treatmentButtonWidth, treatmentButtonWidth * 52 / 329)];
    treatmentStartButton.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.80 + (SCREEN_HEIGHT * 0.20 - TABBAR_HEIGHT) * 0.5);
    if ([HAppUIModel UIViewIsChinese] == YES){
        [treatmentStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStart"] forState:UIControlStateNormal];
        [treatmentStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStartSelected"] forState:UIControlStateHighlighted];
    }
    else{
        [treatmentStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStartEng"] forState:UIControlStateNormal];
        [treatmentStartButton setBackgroundImage:[UIImage imageNamed:@"treatmentStartSelectedEng"] forState:UIControlStateHighlighted];
    }
    

    
    
    [treatmentStartButton addTarget:self action:@selector(treatmentStartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:treatmentStartButton];
    
    treatmentStopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, treatmentButtonWidth, treatmentButtonWidth * 52 / 329)];
    treatmentStopButton.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.80 + (SCREEN_HEIGHT * 0.20 - TABBAR_HEIGHT) * 0.5);
    if ([HAppUIModel UIViewIsChinese] == YES){
        [treatmentStopButton setBackgroundImage:[UIImage imageNamed:@"treatmentStop"] forState:UIControlStateNormal];
        [treatmentStopButton setBackgroundImage:[UIImage imageNamed:@"treatmentStopSelected"] forState:UIControlStateHighlighted];
    }
    else{
        [treatmentStopButton setBackgroundImage:[UIImage imageNamed:@"treatmentStopEng"] forState:UIControlStateNormal];
        [treatmentStopButton setBackgroundImage:[UIImage imageNamed:@"treatmentStopSelectedEng"] forState:UIControlStateHighlighted];
    }
    

    [treatmentStopButton addTarget:self action:@selector(treatmentStopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:treatmentStopButton];
    treatmentStopButton.hidden = YES;
    // ————————————————————————————————————————————————————————————————————————————————————————————————————
    
}

// ———————————————————————————————— 根据条件创建页面 ————————————————————————————————————————————
- (void)createViewDefault {
    ;
}

- (void)createViewStyleOne {
    CGFloat whirlingViewDiameter = [HAppUIModel baseWidthChangeLength:220 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    whirlingView = [[HWhirlingView alloc] initWithFrame:CGRectMake(0, 0, whirlingViewDiameter, whirlingViewDiameter)];
    whirlingView.center = CGPointMake(SCREEN_WIDTH * 0.45, SCREEN_HEIGHT * 0.35);
    [backgroundView addSubview:whirlingView];
    isStartWhirling = NO;
    
    CGFloat widrhAndLong = [HAppUIModel baseWidthChangeLength:190 baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widrhAndLong, widrhAndLong)];
    displayView.backgroundColor = [HAppUIModel whiteColor2];
    displayView.center = CGPointMake(SCREEN_WIDTH * 0.45, SCREEN_HEIGHT * 0.35);
    [displayView.layer setCornerRadius:widrhAndLong * 0.5];
    displayView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:displayView];
    
    phaseDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    phaseDataLabel.text = @"--";
    phaseDataLabel.textColor = [HAppUIModel orangeColor1];
    phaseDataLabel.font = [HAppUIModel numberFont1];
    CGSize phaseDataLabelSize = [@"--" sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont1]}];
    phaseDataLabelSize = CGSizeMake(ceilf(phaseDataLabelSize.width), ceilf(phaseDataLabelSize.height));
    phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabelSize.width, phaseDataLabelSize.height);
    phaseDataLabel.center = CGPointMake(widrhAndLong * 0.5, widrhAndLong / 3);
    [displayView addSubview:phaseDataLabel];
    
    UILabel *phaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    phaseLabel.text = NSLocalizedString(@"treatmentPhaseLabel", nil);
    phaseLabel.textColor = [HAppUIModel orangeColor2];
    phaseLabel.font = [HAppUIModel mediumFont11];
    CGSize phaseLabelSize = [NSLocalizedString(@"treatmentPhaseLabel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    phaseLabelSize = CGSizeMake(ceilf(phaseLabelSize.width), ceilf(phaseLabelSize.height));
    phaseLabel.frame = CGRectMake(0, 0, phaseLabelSize.width, phaseLabelSize.height);
    
    //NSLog(@"宽度: %fl  长度: %fl ", phaseLabelSize.width, phaseLabelSize.height);
    
    phaseLabel.center = CGPointMake(widrhAndLong * 0.5, (widrhAndLong + phaseDataLabelSize.height * 0.5) * 0.5);
    [displayView addSubview:phaseLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HAppUIModel baseWidthChangeLength:154 baceWidthWithModel:ApplicationDelegate.myAppScreenModel], [HAppUIModel baseLongChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    backgroundGradientLayer.colors = @[(__bridge id)[HAppUIModel changeGrayColor1].CGColor,
                                       (__bridge id)[HAppUIModel changeGrayColor2].CGColor,
                                       (__bridge id)[HAppUIModel changeGrayColor1].CGColor];
    backgroundGradientLayer.locations = @[@0.3, @0.5, @0.7];
    backgroundGradientLayer.startPoint = CGPointMake(0.0, 0);
    backgroundGradientLayer.endPoint = CGPointMake(1.0, 0.0);
    backgroundGradientLayer.frame = CGRectMake(0, 0, [HAppUIModel baseWidthChangeLength:154 baceWidthWithModel:ApplicationDelegate.myAppScreenModel], 1);
    [lineView.layer addSublayer:backgroundGradientLayer];
    lineView.center = CGPointMake(widrhAndLong * 0.5, widrhAndLong * 2 / 3);
    [displayView addSubview:lineView];
    
    UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    durationLabel.text = NSLocalizedString(@"treatmentDurationLabel", nil);
    durationLabel.textColor = [HAppUIModel mainColor4];
    durationLabel.font = [HAppUIModel normalFont2];
    CGSize durationLabelSize = [NSLocalizedString(@"treatmentDurationLabel", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    durationLabelSize = CGSizeMake(ceilf(durationLabelSize.width), ceilf(durationLabelSize.height));
    durationLabel.frame = CGRectMake(0, 0, durationLabelSize.width, durationLabelSize.height);
    durationLabel.center = CGPointMake((widrhAndLong - durationLabelSize.width) * 0.5, widrhAndLong * 2 / 3 + [HAppUIModel baseWidthChangeLength:6 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + durationLabelSize.height * 0.5);
    [displayView addSubview:durationLabel];
    
    durationDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString *durationDataLabelText = [NSString stringWithFormat:@"%@%@", @"0", NSLocalizedString(@"treatmentMinuteLabel", nil)];
    durationDataLabel.text = durationDataLabelText;
    durationDataLabel.textColor = [HAppUIModel mainColor4];
    durationDataLabel.font = [HAppUIModel normalFont2];
    CGSize durationDataLabelSize = [durationDataLabelText sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    durationDataLabelSize = CGSizeMake(ceilf(durationDataLabelSize.width), ceilf(durationDataLabelSize.height));
    durationDataLabel.frame = CGRectMake(0, 0, durationDataLabelSize.width, durationDataLabelSize.height);
    durationDataLabel.center = CGPointMake((widrhAndLong + durationDataLabelSize.width) * 0.5, widrhAndLong * 2 / 3 + [HAppUIModel baseWidthChangeLength:6 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + durationDataLabelSize.height * 0.5);
    [displayView addSubview:durationDataLabel];
}
// ——————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————— 按钮动作 ——————————————————————————————————————————————
- (void)treatmentStartButtonAction:(UIButton *)sender {
    NSLog(@">>> treatmentStartButtonAction");
    // ———————— 测试 ————————————————————————————————
//    treatmentStartButton.hidden = YES;
//    treatmentStopButton.hidden = NO;
//    [self startWhirling];
    // ————————————————————————————————————————————————
    
    // test
//    [ApplicationDelegate createFeedBackView];
//    return;
    
    if (ApplicationDelegate.profile) {
        // 有profile
        if (ApplicationDelegate.UserId == 0) {
            // 未上传 重新上传
            NSLog(@"将要上传 %@", ApplicationDelegate.profile);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",nil];
            [manager POST:Profile_URL parameters:ApplicationDelegate.profile progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"*_*");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"成功 responseObject %@", responseObject);
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                int get_user_id = [[dic valueForKey:@"UserId"] intValue];
                NSLog(@"成功 get_user_id %d", get_user_id);
                NSLog(@">>> 这里失败了 %@", ApplicationDelegate.profile);
                NSMutableDictionary *saveDic = [NSMutableDictionary dictionaryWithDictionary:ApplicationDelegate.profile];
                [saveDic setObject:@(get_user_id) forKey:@"UserId"];
                ApplicationDelegate.profile = [NSMutableDictionary dictionaryWithDictionary:saveDic];
                NSLog(@">>> profile %@", ApplicationDelegate.profile);
                [[NSUserDefaults standardUserDefaults] setObject:ApplicationDelegate.profile forKey:@"profile"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //        NSString *eeee = [[NSString alloc] initWithData:error encoding:NSUTF8StringEncoding];
                NSLog(@"失败 error: %@", error);
            }];
            
            HTreatment_PositionViewController *treatment_PositionVC = [HTreatment_PositionViewController new];
            [self.navigationController pushViewController:treatment_PositionVC animated:YES];
        } else {
            // 已上传 直接跳转
            HTreatment_PositionViewController *treatment_PositionVC = [HTreatment_PositionViewController new];
            [self.navigationController pushViewController:treatment_PositionVC animated:YES];
        }
    } else {
        // 没有 profile 跳转 profile
        HMine_ProfileViewController *Mine_ProfileVC = [HMine_ProfileViewController new];
        [self.navigationController pushViewController:Mine_ProfileVC animated:YES];
    }
//    if (ApplicationDelegate.deviceStatusStyle == 0 || ApplicationDelegate.deviceStatusStyle == 2) {
//        // idel || stop
//        NSLog(@"   |-> idel || stop");
//    } else if (ApplicationDelegate.deviceStatusStyle == 1) {
//        // run
//        NSLog(@"   |-> run");
//    }
}

- (void)treatmentStopButtonAction:(UIButton *)sender {
    NSLog(@">>> treatmentStopButtonAction");
    // ———————— 测试 ————————————————————————————————
//    treatmentStartButton.hidden = NO;
//    treatmentStopButton.hidden = YES;
//    [self stopWhirling];
    // ————————————————————————————————————————————————
    HBLETask *aTask = [[HBLETask alloc] init];
    aTask.taskName = @"stopTreatment";
    [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
    
//    if (ApplicationDelegate.deviceStatusStyle == 0 || ApplicationDelegate.deviceStatusStyle == 2) {
//        // idel || stop
//        NSLog(@"   |-> idel || stop");
//    } else if (ApplicationDelegate.deviceStatusStyle == 1) {
//        // run
//        NSLog(@"   |-> run");
//    }
}
// —————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————— 旋转方法 ——————————————————————————————————————————————
- (void)spinWithOptions: (UIViewAnimationOptions) options {
    // 1s 30度（1圈 12s）
    [UIView animateWithDuration:0.5f delay:0.0f options:options animations:^{
        whirlingView.transform = CGAffineTransformRotate(whirlingView.transform, M_PI / 12);//M_PI / 2 = 90度
    }completion:^(BOOL finished) {
        if (finished) {
            if (isStartWhirling) {
                // if flag still set, keep spinning with constant speed
                [self spinWithOptions: UIViewAnimationOptionCurveLinear];//必须项
            } else if (options !=UIViewAnimationOptionCurveEaseOut) {
                // one last spin, with deceleration
                CGAffineTransform _trans = whirlingView.transform;
                CGFloat rotate = acosf(_trans.a);
                // 旋转180度后，需要处理弧度的变化
                if (_trans.b < 0) {
                    rotate = M_PI - rotate;
                }
                // 将弧度转换为角度
                CGFloat degree = rotate / M_PI * 180;
                NSLog(@">>> degree %f ", degree);
                [self spinWithOptions: UIViewAnimationOptionCurveEaseOut];
            }
        }
    }];
}
- (void)startWhirling {
    if (!isStartWhirling) {
        isStartWhirling = YES;
        [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}
- (void)stopWhirling {
    isStartWhirling = NO;
}
// —————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————— 方法 ——————————————————————————————————————————————
- (void)moreInformationBackgroundViewTap:(UITapGestureRecognizer *)tap {
    NSLog(@">>> more information");
    HTreatment_DetailViewController *treatment_DetailVC = [HTreatment_DetailViewController new];
    [self.navigationController pushViewController:treatment_DetailVC animated:YES];
}
// 根据连接与否改变 连接的文字和图片
- (void)changeconnectStylePutout {
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        // label
        connectStyleLabel.text = NSLocalizedString(@"treatmentConnectStyle-Connected", nil);
        CGSize connectStyleLabelSize = [NSLocalizedString(@"treatmentConnectStyle-Connected", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        connectStyleLabelSize = CGSizeMake(ceilf(connectStyleLabelSize.width), ceilf(connectStyleLabelSize.height));
        connectStyleLabel.frame = CGRectMake(connectStyleLabel.frame.origin.x, connectStyleLabel.frame.origin.y, connectStyleLabelSize.width, connectStyleLabelSize.height);
        // imageview
        connectStyleImageView.center = CGPointMake(connectStyleLabel.frame.origin.x + connectStyleLabelSize.width + [HAppUIModel baseWidthChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + imageViewSideLength * 0.5, connectStyleLabel.frame.origin.y + connectStyleLabelSize.height * 0.5);
        connectStyleImageView.image = [UIImage imageNamed:@"connect"];
    }
    if (0 == ApplicationDelegate.BLE_Connected_Status) {
        // label
        connectStyleLabel.text = NSLocalizedString(@"treatmentConnectStyle-Disconnected", nil);
        CGSize connectStyleLabelSize = [NSLocalizedString(@"treatmentConnectStyle-Disconnected", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont1]}];
        connectStyleLabelSize = CGSizeMake(ceilf(connectStyleLabelSize.width), ceilf(connectStyleLabelSize.height));
        connectStyleLabel.frame = CGRectMake(connectStyleLabel.frame.origin.x, connectStyleLabel.frame.origin.y, connectStyleLabelSize.width, connectStyleLabelSize.height);
        // imageview
        connectStyleImageView.center = CGPointMake(connectStyleLabel.frame.origin.x + connectStyleLabelSize.width + [HAppUIModel baseWidthChangeLength:11.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + imageViewSideLength * 0.5, connectStyleLabel.frame.origin.y + connectStyleLabelSize.height * 0.5);
        connectStyleImageView.image = [UIImage imageNamed:@"disconnect"];
    }
}
// 根据电池电量，显示图片（显示之后不会消失，断开连接状态变灰）
- (void)changeBatteryPowerPutout {
    if (0 == ApplicationDelegate.BLE_Connected_Status) {
        if (0 <= ApplicationDelegate.deviceBatteryPower && 5 >= ApplicationDelegate.deviceBatteryPower ) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryZeroGray"];
            return;
        }
        if (5 < ApplicationDelegate.deviceBatteryPower && 20 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryOneGray"];
            return;
        }
        if (20 < ApplicationDelegate.deviceBatteryPower && 40 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryTwoGray"];
            return;
        }
        if (40 < ApplicationDelegate.deviceBatteryPower && 90 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryThreeGray"];
            return;
        }
        if (90 < ApplicationDelegate.deviceBatteryPower && 100 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryFourGray"];
            return;
        }
    }
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        if ([batteryPowerLabel isHidden] && [batteryPowerImageView isHidden]) {
            [batteryPowerLabel setHidden:NO];
            [batteryPowerImageView setHidden:NO];
        }
        NSString *batteryPowerLabel_Text = [NSString stringWithFormat:@"%@%d%@", NSLocalizedString(@"treatmentBatteryPower", nil), ApplicationDelegate.deviceBatteryPower, NSLocalizedString(@"treatmentPercentSign", nil)];
        batteryPowerLabel.text = batteryPowerLabel_Text;
        if (0 <= ApplicationDelegate.deviceBatteryPower && 5 >= ApplicationDelegate.deviceBatteryPower ) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryZero"];
            return;
        }
        if (5 < ApplicationDelegate.deviceBatteryPower && 20 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryOne"];
            return;
        }
        if (20 < ApplicationDelegate.deviceBatteryPower && 40 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryTwo"];
            return;
        }
        if (40 < ApplicationDelegate.deviceBatteryPower && 90 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryThree"];
            return;
        }
        if (90 < ApplicationDelegate.deviceBatteryPower && 100 >= ApplicationDelegate.deviceBatteryPower) {
            batteryPowerImageView.image = [UIImage imageNamed:@"batteryFour"];
            return;
        }
    }
}
// 旋转判断
- (void)whirlingStutas {
    // 旋转要求 1: 处在保持连接状态 2: 工作中
    if (1 == ApplicationDelegate.BLE_Connected_Status) {
        if (0 == ApplicationDelegate.deviceWorkingStutas || 2 == ApplicationDelegate.deviceWorkingStutas) {
            // 停止转动
            [self stopWhirling];
            return;
        }
        if (1 == ApplicationDelegate.deviceWorkingStutas) {
            // 先停止再打开
            [self stopWhirling];
            // 开始转动
            [self startWhirling];
            return;
        }
    } else {
        // 停止转动
        [self stopWhirling];
        return;
    }
}
// 按钮状态
- (void)treatmentButtonStutas {
    if (0 == ApplicationDelegate.deviceWorkingStutas || 2 == ApplicationDelegate.deviceWorkingStutas) {
        // 停止转动
        [treatmentStartButton setHidden:NO];
        [treatmentStopButton setHidden:YES];
        return;
    }
    if (1 == ApplicationDelegate.deviceWorkingStutas) {
        [treatmentStartButton setHidden:YES];
        [treatmentStopButton setHidden:NO];
        return;
    }
}
// 更新 phaseLabel
- (void)updataPhaseDataLabel {
    NSString *phaseString = [NSString new];
    if (ApplicationDelegate.treatmentingLog.phase.count == 0) {
        phaseString = @"--";
    } else {
        phaseString = [NSString stringWithFormat:@"%@", [ApplicationDelegate.treatmentingLog.phase lastObject]];
        NSArray *phaseArray = [phaseString componentsSeparatedByString:@"-"];
        NSLog(@"array:%@", phaseArray);
        if (phaseArray.count == 2) {
            phaseString = phaseArray[1];
        }
    }
    phaseDataLabel.text = [NSString stringWithFormat:@"%@", phaseString];
    CGSize phaseDataLabelSize = [phaseString sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel numberFont1]}];
    phaseDataLabelSize = CGSizeMake(ceilf(phaseDataLabelSize.width), ceilf(phaseDataLabelSize.height));
    phaseDataLabel.frame = CGRectMake(0, 0, phaseDataLabelSize.width, phaseDataLabelSize.height);
    phaseDataLabel.center = CGPointMake([HAppUIModel baseWidthChangeLength:190 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] * 0.5, [HAppUIModel baseWidthChangeLength:190 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] / 3);
}
// 更新 durationDataLabel
- (void)updataDurationDataLabel {
    NSString *durationDataLabelText = [NSString stringWithFormat:@"%d%@", ApplicationDelegate.treatmentingLog.duration, NSLocalizedString(@"treatmentMinuteLabel", nil)];
    durationDataLabel.text = durationDataLabelText;
    CGSize durationDataLabelSize = [durationDataLabelText sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    durationDataLabelSize = CGSizeMake(ceilf(durationDataLabelSize.width), ceilf(durationDataLabelSize.height));
    durationDataLabel.frame = CGRectMake(0, 0, durationDataLabelSize.width, durationDataLabelSize.height);
    durationDataLabel.center = CGPointMake(([HAppUIModel baseWidthChangeLength:190 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + durationDataLabelSize.width) * 0.5, [HAppUIModel baseWidthChangeLength:190 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] * 2 / 3 + [HAppUIModel baseWidthChangeLength:6 baceWidthWithModel:ApplicationDelegate.myAppScreenModel] + durationDataLabelSize.height * 0.5);
}
// —————————————————————————————————————————————————————————————————————————————————————————

// ———————————————————————————————— 通知方法 ————————————————————————————————————————————
- (void)connectedNotificationAction {
    NSLog(@">>> HTreatmentViewController 收到 connectedNotification");
    [self changeconnectStylePutout];
}
- (void)updataDeviceBatteryNotificationAction {
    NSLog(@">>> HTreatmentViewController 收到 updataDeviceBatteryNotification");
    [self changeBatteryPowerPutout];
    if (ApplicationDelegate.BLE_Connected_Status == 1) {
        if (ApplicationDelegate.deviceBatteryPower <= 5) {
            UIAlertController *lowbatteryNotice = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"AppDelegate_LowBatteryNoticeString", nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:NSLocalizedString(@"AppDelegate_LowBatteryNoticeOK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [lowbatteryNotice addAction:yes];
            [self presentViewController:lowbatteryNotice animated:YES completion:nil];
        }
    }
}
- (void)updataWorkingStutaNotificationAction {
    NSLog(@">>> HTreatmentViewController 收到 updataWorkingStutaNotification");
    [self whirlingStutas];
    [self treatmentButtonStutas];
}
- (void)updataGenerationPhaseNotificationAction {
    NSLog(@">>> HTreatmentViewController 收到 updataGenerationPhaseNotification");
    [self updataPhaseDataLabel];
}
- (void)updataGenerationDurationNotificationAction {
    NSLog(@">>> HTreatmentViewController 收到 updataGenerationDurationNotification");
    [self updataDurationDataLabel];
}
- (void)R0501NotificationAction {
    UIAlertController *R0501Notice = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"AppDelegate_R0501NoticeString", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:NSLocalizedString(@"AppDelegate_R0501NoticeOK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [R0501Notice addAction:yes];
    [self presentViewController:R0501Notice animated:YES completion:nil];
}
- (void)updataMainNotificationAction {
    [treatmentStartButton setHidden:YES];
    [treatmentStopButton setHidden:NO];
    [self startWhirling];
}
// ——————————————————————————————————————————————————————————————————————————————————————————————————
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Treatment");
    [self whirlingStutas];
    [self treatmentButtonStutas];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
