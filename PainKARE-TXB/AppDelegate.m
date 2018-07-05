//
//  AppDelegate.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/22.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "AppDelegate.h"

#import "HWebViewController.h"
#import "HTreatmentViewController.h"
#import "HMineViewController.h"
#import "HAppUIModel.h"
#import "ModelToJson.h"
#import "HSelectedModel.h"
#import <AFNetworking/AFNetworking.h>

#import "HParameterButton.h"
#import <sys/utsname.h>
#import "HBLE_ScanView.h"

@interface AppDelegate () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (strong, nonatomic) UIView *clearView;

@end

@implementation AppDelegate {
    // ————————————————————————————————————————————————————————————————
    UIView *appTransparentView;
    UITableView *peripheralTableView;
    
    // 0: 初始
    int appTransparentViewEnabled;
    
    BOOL isLastConnect; // 连接的时候就是连接你 初始 no
    
    NSTimer *timer3s;
    
    UIButton *selectedLightingButton;   // 已被选中亮灯的按钮
    CBPeripheral *selectedLightingPeripheral;   // 已被选中的亮灯的设备
    UILabel *selectedLightingLabel; // 已被选中的亮灯的设备名字
    
    UIButton *selectingLightingButton;   // 正在被选中亮灯的按钮
    UIButton *witeSelectingLightingButton;  // 等待被连接的按钮
    
    
    CBPeripheral *selectingLightingPeripheral;   // 正在被选中的亮灯的设备
    UILabel *selectingLightingLabel; // 正在被选中的亮灯的设备名字
    
    BOOL needTime;  // 初始为 false
    HSelectedModel *selectedModel;
    // ————————————————————————————————————————————————————————————————
    
    // ————————————————————————————————————————————————————————————————
    UIView *appFeedBackTransparentView;
    UIView *appFeedBackBackgroundView;
    // ————————————————————————————————————————————————————————————————
    
    UIWebView *waitWebView;
    UIButton *researchButton;
    
    // ———————————————————— 初始化计时器 ——————————————————————————————————————————————
    NSTimer *scanPeripheralsTimer5s;
    
    NSTimer *getDeviceInfoTimer60s;// 发送S0101
    // ——————————————————————————————————————————————————————————————————————————————————————
    
    UIButton *star1Button;
    UIButton *star2Button;
    UIButton *star3Button;
    UIButton *star4Button;
    UIButton *star5Button;
    
    UITextView *text3TextView;
    UILabel *textViewLengthLabel;
    
    NSString *feedbackString;
    int feedVote;
    
    CGRect keyboardRect;
    
    CBPeripheral *onePeripheral;    // 就连接的时候有用
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1.0];
    //手机屏幕在打开App的时候持续亮屏（不熄屏）
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    NSLog(@">>> didFinishLaunchingWithOptions");
    // 初始化数据
    self.myAppScreenModel = [HAppUIModel gainScreenModelFromWidth:SCREEN_WIDTH andHeight:SCREEN_HEIGHT];
//    self.deviceStatusStyle = 0;
    self.BLE_isScaning = NO;
    self.BLE_Connected_Status = 0;
    self.productId = [NSString stringWithFormat:@"-"];
    self.softwareVersion = [NSString stringWithFormat:@"-"];
    self.treatmentingLog = [HtreatmentLog new];
    feedbackString = [NSString new];
    appTransparentViewEnabled = 0;
    isLastConnect = NO;
    needTime = NO;
    // ———————————————————————————— 监听 treatmentingLog ————————————————————————————
    [self.treatmentingLog addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:nil];
    // ——————————————————————————————————————————————————————————————————————————————
    self.deviceWorkingStutas = 0;
    self.needMaxIndex = 0;
    self.errorBuzzer_State = 1;
    self.workingBuzzer_State = 0;
    feedVote = 5;
//    self.profile = [NSMutableDictionary dictionary];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"profile"]) {
        self.profile = [[NSUserDefaults standardUserDefaults] valueForKey:@"profile"];
        NSLog(@">>> profile %@", self.profile);
        self.UserId = [[self.profile valueForKey:@"UserId"] intValue];
    } else {
        NSLog(@">>> profile %@", self.profile);
        self.UserId = 0;
    }
    selectedModel = [HSelectedModel new];
    
    // 获取数据
    [self gainMineList];
    [self gainPositionList];
    [self gainProtocolList];
    
    [self initTreatmentLogs];
    
    // 测试
//    self.defaultDeviceIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"deviceIdentifier"];
//    NSLog(@">>> %@", self.defaultDeviceIdentifier);

    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    [self enterView];
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.clearView.backgroundColor = [UIColor clearColor];
    [self.window addSubview:self.clearView];
    [self.clearView setHidden:YES];
    //创建手势对象
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapAction:)];
    //配置属性
    viewTap.numberOfTapsRequired = 1;
    viewTap.numberOfTouchesRequired = 1;
    [self.clearView addGestureRecognizer:viewTap];
    
    return YES;
}

// 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.treatmentingLog) {
        if ([keyPath isEqualToString:@"duration"]) {
            NSLog(@"duration 发生改变");
//            if (change == 0) {
//                updataGenerationDurationNotification
                NSNotification *notification0 = [NSNotification notificationWithName:@"updataGenerationDurationNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification0];
//                updataGenerationPhaseNotification
                NSNotification *notification1 = [NSNotification notificationWithName:@"updataGenerationPhaseNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification1];
//                updataDetailDataNotification
                NSNotification *notification2 = [NSNotification notificationWithName:@"updataDetailDataNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification2];
//                updataDetailDurationNotification
                NSNotification *notification3 = [NSNotification notificationWithName:@"updataDetailDurationNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification3];
//                updataDetailChartViewNotification
                NSNotification *notification4 = [NSNotification notificationWithName:@"updataDetailChartViewNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification4];
//            }
        }
    }
}

#pragma mark >>> 初始化蓝牙
// 将在 Treatment 页面初始化
- (void)initBLEMamager {
    // 初始化BLEManager
    self.bleCommunicationManager = [HBLECommunicationManager new];
    self.bleCommunicationManager.delegate = self;
    self.bleCommunicationManager.deviceIsConnected = NO;
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"deviceIdentifier"]) {
        // 存在保存的设备
        self.BLE_Connect_Style = 1;
        self.defaultDeviceIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"deviceIdentifier"];
    } else {
        // 不存在保存的设备
        self.BLE_Connect_Style = 0;
    }
}

#pragma mark >>> 初始化视图
- (void)enterView {
    // 初始化 tabbar
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    // 初始化视图
    HWebViewController *webVC = [[HWebViewController alloc] init];
    HTreatmentViewController *treatmentVC = [[HTreatmentViewController alloc] init];
    HMineViewController *mineVC = [[HMineViewController alloc] init];
    
    // 视图添加 navigation
    UINavigationController *navWeb = [[UINavigationController alloc] initWithRootViewController:webVC];
    UINavigationController *navTreatment = [[UINavigationController alloc] initWithRootViewController:treatmentVC];
    UINavigationController *navMine = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    // 将添加了 navigation 的视图添加到 tabbar
    NSArray *controllerArr = [NSArray arrayWithObjects:navWeb, navTreatment, navMine, nil];
    tabBarController.viewControllers = controllerArr;
    
    navWeb.title = NSLocalizedString(@"AppNavWebTabbarTitle", nil);
    navTreatment.title = NSLocalizedString(@"AppNavTreatmentTabbarTitle", nil);
    navMine.title = NSLocalizedString(@"AppNavMineTabbarTitle", nil);
    [navWeb.tabBarItem setImage:[UIImage imageNamed:@"homeGray"]];
    [navTreatment.tabBarItem setImage:[UIImage imageNamed:@"treatmentGray"]];
    [navMine.tabBarItem setImage:[UIImage imageNamed:@"mineGray"]];
    
    [navWeb.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[HAppUIModel mainColor3]} forState:UIControlStateSelected];
    [navTreatment.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[HAppUIModel mainColor3]} forState:UIControlStateSelected];
    [navMine.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[HAppUIModel mainColor3]} forState:UIControlStateSelected];
    tabBarController.tabBar.tintColor = [HAppUIModel mainColor2];
    
    // 设置透明 navigation
    navWeb.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [navWeb.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    navWeb.navigationBar.clipsToBounds = YES;
    
    navTreatment.navigationBar.translucent = YES;
    UIGraphicsBeginImageContext(rect.size);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIGraphicsEndImageContext();
    [navTreatment.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    navTreatment.navigationBar.clipsToBounds = YES;
    
    navMine.navigationBar.translucent = YES;
    UIGraphicsBeginImageContext(rect.size);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIGraphicsEndImageContext();
    [navMine.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    navMine.navigationBar.clipsToBounds = YES;
}

- (void)createScanView {
    [self.bleCommunicationManager.bleManager stopScanPeripherals];
    ApplicationDelegate.defaultDeviceIdentifier = nil;
    
    [self.bleCommunicationManager.bleManager beginScanPeripherals];
    [self createConnectView];
    [self startScanPeripheralsTimer5s];
    self.BLE_isScaning = YES;
}

# pragma mark ——————————— CommunicationManagerDelegate 代理方法 ——————————————
- (void)CommunicationManagerBLEPowerOn {
    NSLog(@"蓝牙已打开！！！提醒一下下～");
    ApplicationDelegate.BLE_Status = 1;
    // 开始连接设备（分情况）
    [self.bleCommunicationManager.bleManager beginScanPeripherals];
    if (self.BLE_Connect_Style == 0) {
        // 不存在保存设备
        [self createConnectView];
        [self startScanPeripheralsTimer5s];
        self.BLE_isScaning = YES;
    }
    if (self.BLE_Connect_Style == 1) {
        // 存在保存设备(搜索设备动作会自己处理连接过程)
    }
}
- (void)CommunicationManagerBLEPowerOff {
    NSLog(@"蓝牙没打开！！！提醒一下下～");
    ApplicationDelegate.BLE_Status = 0;
    // 提醒用户打开蓝牙
    [self createAlertControllerForBLEPower];
}
- (void)CommunicationManagerScanNewPeripheral {
    NSLog(@"发现新设备！！！ 更新一下下～");
    [peripheralTableView reloadData];
}
- (void)CommunicationManagerBLEConnected {
    NSLog(@"连接上设备！！！庆祝一下下～");
    [self.bleCommunicationManager clearTasks];
    // —————————————————————————————— 连接方式 ——————————————————————————————————————————————
    // 保持连接的连接方式
    if (0 == self.BLE_Connected_Style) {
        NSLog(@"进入保持连接的连接方式");
        // 改变连接状态
        self.BLE_Connected_Status = 1;
        
        HBLETask *aTask1 = [[HBLETask alloc] init];
        aTask1.taskName = @"getErrorStateBuzzer";
        [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask1];
        HBLETask *aTask2 = [[HBLETask alloc] init];
        aTask2.taskName = @"getWorkingStateBuzzer";
        [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask2];
        // 以连接设备为目的的之后连接上设备清除连接设备页面
        // 清空视图
        [appTransparentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [appTransparentView removeFromSuperview];
        [ApplicationDelegate.bleCommunicationManager.bleManager.discoverPeripherals removeAllObjects];
        // 保存设备 （做为自动连接使用）
        NSLog(@"保存设备 Identifier %@", self.bleCommunicationManager.bleManager.selectedPeripheral.identifier);
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", self.bleCommunicationManager.bleManager.selectedPeripheral.identifier] forKey:@"deviceIdentifier"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 更改连接状态的显示(通知 HTreatmentViewController )
        NSNotification *notification = [NSNotification notificationWithName:@"connectedNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        // 发送状态获取
        // 1.设备运行状态： idel run stop？ 2.产品ID 3.设备软件版本 4.电池电量 （发送2条协议来获取）
        HBLETask *getDeviceInfoTask;
        getDeviceInfoTask = [[HBLETask alloc] initWithName:@"getDeviceInfo" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:getDeviceInfoTask];
        // (开启定时器)
        [self startGetDeviceInfoTimer60s];
        
        HBLETask *getSoftwareVersionTask;
        getSoftwareVersionTask = [[HBLETask alloc] initWithName:@"getSoftwareVersion" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:getSoftwareVersionTask];
    }
    // 只为了闪灯的连接方式
    if (1 == self.BLE_Connected_Style) {
        NSLog(@"进入只为了闪灯的连接方式");
        // 改变连接状态
        self.BLE_Connected_Status = 2;
        // 发送闪灯
        [self.bleCommunicationManager clearTasks];
        HBLETask *aTask;
        aTask = [[HBLETask alloc] initWithName:@"startLEDVerification" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:aTask];
    }
    // 自动连接（保持着连接）
    if (2 == self.BLE_Connected_Style) {
        NSLog(@"进入自动连接（保持着连接）的连接方式");
        // 改变连接状态
        self.BLE_Connected_Status = 1;
        
        HBLETask *aTask1 = [[HBLETask alloc] init];
        aTask1.taskName = @"getErrorStateBuzzer";
        [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask1];
        HBLETask *aTask2 = [[HBLETask alloc] init];
        aTask2.taskName = @"getWorkingStateBuzzer";
        [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask2];
        // 更改连接状态的显示(通知 HTreatmentViewController )
        NSNotification *notification = [NSNotification notificationWithName:@"connectedNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        // 发送状态获取
        // 1.设备运行状态： idel run stop？ 2.产品ID 3.设备软件版本 4.电池电量 （发送2条协议来获取）
        HBLETask *getDeviceInfoTask;
        getDeviceInfoTask = [[HBLETask alloc] initWithName:@"getDeviceInfo" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:getDeviceInfoTask];
        
        [self startGetDeviceInfoTimer60s];
        
        HBLETask *getSoftwareVersionTask;
        getSoftwareVersionTask = [[HBLETask alloc] initWithName:@"getSoftwareVersion" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:getSoftwareVersionTask];
    }
    if (3 == self.BLE_Connected_Style) {
        NSLog(@"进入重新连接的连接方式");
        // 改变连接状态
        self.BLE_Connected_Status = 1;
        // 更改连接状态的显示(通知 HTreatmentViewController )
        NSNotification *notification = [NSNotification notificationWithName:@"connectedNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        // 发送状态获取
        HBLETask *getDeviceInfoTask;
        getDeviceInfoTask = [[HBLETask alloc] initWithName:@"getDeviceInfo" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:getDeviceInfoTask];
        // (开启定时器)
        [self startGetDeviceInfoTimer60s];
        // (只要获取电量就好了不需要获取 产品Id 和 设备软件版本)
    }
    // —————————————————————————————————————————————————————————————————————————————————————
}
- (void)CommunicationManagerBLEDisconnected {
    NSLog(@"断开连接！！！");
    if (appTransparentViewEnabled == 2) {
        [appTransparentView setUserInteractionEnabled:YES];
        [self stopTimer3s];
    }
    self.BLE_Connected_Status = 0;
    // 更改连接状态的显示(通知 HTreatmentViewController )
    NSNotification *connectedNotification = [NSNotification notificationWithName:@"connectedNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:connectedNotification];
    // 更改电池电量(通知 HTreatmentViewController )
    NSNotification *updataDeviceBatteryNotification = [NSNotification notificationWithName:@"updataDeviceBatteryNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:updataDeviceBatteryNotification];
    // 根据不同的状态来警进行操作
    if (0 == self.BLE_Connected_Style || 2 == self.BLE_Connected_Style || 3 == self.BLE_Connected_Style) {
        self.BLE_Connected_Style = 3;
        [self stopGetDeviceInfoTimer60s];
        [self.bleCommunicationManager.bleManager connectPeripheral:self.bleCommunicationManager.bleManager.selectedPeripheral];
        // 提醒护理首页进行状态变化（是否转动圆圈）（提醒 HTreatmentViewController）
        NSNotification *notification = [NSNotification notificationWithName:@"updataWorkingStutaNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    if (1 == self.BLE_Connected_Style) {
        if (witeSelectingLightingButton == nil) {
            if (appTransparentViewEnabled == 2) {
                ;
            } else {
//                self.BLE_Connected_Style = 0;   // 设置为保持连接而连接设备
//                [self.bleCommunicationManager.bleManager connectPeripheral:onePeripheral];
            }
            
        } else {
            selectingLightingButton = witeSelectingLightingButton;
            witeSelectingLightingButton = nil;
            [self.bleCommunicationManager.bleManager connectPeripheral:selectingLightingPeripheral];
        }
    }
    if (isLastConnect == YES) {
        isLastConnect = NO;
        self.BLE_Connected_Style = 0;   // 设置为保持连接而连接设备
        [self.bleCommunicationManager.bleManager connectPeripheral:onePeripheral];
    }
}
#pragma mark ———————————————— 收到信息 ————————————————————
- (void)CommunicationManagerBLEReceivedData:(NSArray*)receivedData {
    NSLog(@"收到信息！！！");
    if([receivedData count] < 1){
        return;
    }
    NSLog(@"获取到的数据：%@", receivedData[0]);
    if ([receivedData[0] isEqualToString:@"R0101"]){
        NSLog(@">>> R0101");
        // 获取到 productId 进行等待更新
        self.productId = [NSString stringWithFormat:@"%@",receivedData[2]];
        // 更改电池电量(通知 HTreatmentViewController )
        self.deviceBatteryPower = [receivedData[4] intValue];
        NSNotification *notification = [NSNotification notificationWithName:@"updataDeviceBatteryNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        if ([@"idle" isEqualToString:[NSString stringWithFormat:@"%@",receivedData[3]]]) {
            if (0 != self.deviceWorkingStutas) {
                NSLog(@"设备状态将由 %d 变成 0", self.deviceWorkingStutas);
                self.deviceWorkingStutas = 0;
                // 提醒护理首页进行状态变化（是否转动圆圈）（提醒 HTreatmentViewController）
                NSNotification *notification = [NSNotification notificationWithName:@"updataWorkingStutaNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            } else {
                NSLog(@"设备状态 %d 不变", self.deviceWorkingStutas);
            }
        }
        if ([@"run" isEqualToString:[NSString stringWithFormat:@"%@",receivedData[3]]]) {
            if (1 != self.deviceWorkingStutas) {
                NSLog(@"设备状态将由 %d 变成 1", self.deviceWorkingStutas);
                self.deviceWorkingStutas = 1;
                HBLETask *getTreatmentIndexTask;
                getTreatmentIndexTask = [[HBLETask alloc] initWithName:@"getTreatmentIndex" andParameter:nil];
                [self.bleCommunicationManager addAnBLETask:getTreatmentIndexTask];
                // 提醒护理首页进行状态变化（是否转动圆圈）（提醒 HTreatmentViewController）
                NSNotification *notification = [NSNotification notificationWithName:@"updataWorkingStutaNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            } else {
                NSLog(@"设备状态 %d 不变", self.deviceWorkingStutas);
            }
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"impedanceGetResistanceAndReactanceb:";
            aTask.parameter = @"60";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
        if ([@"stop" isEqualToString:[NSString stringWithFormat:@"%@",receivedData[3]]]) {
            if (2 != self.deviceWorkingStutas) {
                if (self.deviceWorkingStutas == 1) {
                    // 如果 run 变成 stop 就准备上传数据
                    [self uploadTreatmentLog];
                    if (self.treatmentingLog.duration > 10) {
                        [self createFeedBackView];
                    }
                }
                NSLog(@"设备状态将由 %d 变成 2", self.deviceWorkingStutas);
                self.deviceWorkingStutas = 2;
                // 提醒护理首页进行状态变化（是否转动圆圈）（提醒 HTreatmentViewController）
                NSNotification *notification = [NSNotification notificationWithName:@"updataWorkingStutaNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            } else {
                NSLog(@"设备状态 %d 不变", self.deviceWorkingStutas);
            }
        }
        return;
    }
    if ([receivedData[0] isEqualToString:@"R0106"]){
        NSLog(@">>> R0105");
        self.softwareVersion = [NSString stringWithFormat:@"%@",receivedData[2]];
        return;
    }
    if ([receivedData[0] isEqualToString:@"R0204"]) {
        NSLog(@">>> R0204");
        self.deviceWorkingStutas = 2;
        [self uploadTreatmentLog];
        NSNotification *notification = [NSNotification notificationWithName:@"updataWorkingStutaNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [MBProgressHUD showSuccess:@"已停止"];
        if (ApplicationDelegate.treatmentingLog.duration > 10) {
            [ApplicationDelegate createFeedBackView];
        }
        return;
    }
    if ([receivedData[0] isEqualToString:@"R0501"]) {
        NSLog(@"是否提示电极片松动 %@", receivedData[4]);
        if ([receivedData[4] isEqualToString:@"1"] || [receivedData[4] isEqualToString:@"6"]) {
            NSLog(@"提示电极片松动");
            NSNotification *notification = [NSNotification notificationWithName:@"R0501Notification" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        return;
    }
    if ([receivedData[0] isEqualToString:@"R0510"]) {
        NSLog(@">>> R0510");
        NSLog(@">>> GetTreatmentIndex %@", receivedData[1]);
        // ———————————————————————————— 显示数据更新完毕，进行保存数据 ——————————————————————————————————————————
        /*
         目前只有2种情况会获取 treatment_Index
         1. idel/stop 变成 run
         2. 开始治疗之后
         */
        // 需要判断当前的记录是否一样，不需要判断记录里面的数据
        // 判断当前的数据，而不是最后一条数据
        if (nil == self.treatmentingLog.treatment_index) {
            // 代表： 1. 刚开始治疗 2. 刚连接上，设备正在进行治疗
            self.treatmentingLog.treatment_index = [NSString stringWithFormat:@"%@", receivedData[1]];
            self.treatmentingLog.productId = ApplicationDelegate.productId;
        } else {
            // 代表： 1. 连上设备之前有进行治疗 需要判断是否是同一个治疗
            if ([self.treatmentingLog.productId isEqualToString:ApplicationDelegate.productId] && [self.treatmentingLog.treatment_index isEqualToString:[NSString stringWithFormat:@"%@", receivedData[1]]]) {
                // 同一条记录
                NSLog(@"同一条记录position %@", self.treatmentingLog.position);
                NSLog(@"同一条记录symptom %@", self.treatmentingLog.symptom);
                NSLog(@"同一条记录placement %@", self.treatmentingLog.placement);
            } else {
                // 非同一条记录
                // 判断是否
                // 这里要改！！！这里要改！！！（这里添加）
                // 清空记录
                self.treatmentingLog = [HtreatmentLog new];
                // 重新生成记录
                self.treatmentingLog.productId = ApplicationDelegate.productId;
                self.treatmentingLog.treatment_index = [NSString stringWithFormat:@"%@", receivedData[1]];
                // user_id 先设置为 0 ，到时候需要更改
                if (ApplicationDelegate.profile) {
                    self.treatmentingLog.user_id = [NSString stringWithFormat:@"%d", [[ApplicationDelegate.profile objectForKey:@"UserId"] intValue]];
                } else {
                    self.treatmentingLog.user_id = @"0";
                }
                // 2018错误做法 需修改(这是错的做法切记)
                self.treatmentingLog.log_stuta = 1;
                self.treatmentingLog.completion = 0;
                
                HBLETask *aTask = [[HBLETask alloc] init];
                aTask.taskName = @"getRequestId";
                [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
            }
        }
        return;
        // ————————————————————————————————————————————————————————————————————————————————————————
    }
    if ([receivedData[0] isEqualToString:@"R0711"]) {
        NSLog(@">>> R0711");
        NSLog(@">>> receivedData 0711 %@", receivedData);
        
        // 测试可行性
        if (nil == self.treatmentingLog.treatment_index) {
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"getTreatmentIndex";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
        if (nil == self.treatmentingLog.position) {
            HBLETask *aTask = [[HBLETask alloc] init];
            aTask.taskName = @"getRequestId";
            [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
        }
        if (nil == self.treatmentingLog.start_time) {
            NSDate *now = [NSDate date];
            NSTimeInterval min = self.treatmentingLog.duration * 60 * 60;
            NSDate *newTime = [now dateByAddingTimeInterval:-min];
            
            NSDateFormatter  *bufferdateformatter = [[NSDateFormatter alloc] init];
            [bufferdateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSString *timeString = [bufferdateformatter stringFromDate:newTime];
            self.treatmentingLog.start_time = timeString;
            needTime = NO;
        }
        
        if ([receivedData[2] isEqualToString:@"0"] && [receivedData[3] isEqualToString:@"0"] && [receivedData[4] isEqualToString:@"0"] && [receivedData[5] isEqualToString:@"0"]) {
            // 说明还没有数据，等等再说咯～
            NSLog(@"说明还没有数据，等等再说咯～");
        } else {
            NSString *indexString = [NSString stringWithFormat:@"%@", receivedData[2]];
            if ([indexString intValue] == [self.treatmentingLog.phase count]) {
                // 添加新数据
                // 每个数据都要取正
                // resistance
                NSString *resistanceString = [self changeGainString:receivedData[3]];;
                [self.treatmentingLog.resistance addObject:resistanceString];
                // reactance
                NSString *reactanceString = [self changeGainString:receivedData[4]];
                [self.treatmentingLog.reactance addObject:reactanceString];
                // phase
                [self changeGainString:receivedData[5]];
                NSString *phaseString = [self changeGainString:receivedData[5]];
                [self.treatmentingLog.phase addObject:phaseString];
                // intensity
                float intensityF = [receivedData[6] floatValue];
                if (intensityF < 0) {
                    intensityF = -intensityF;
                }
                NSString *intensityString = [NSString stringWithFormat:@"%f", intensityF];
                [self.treatmentingLog.intensity addObject:intensityString];
                // duration
                self.treatmentingLog.duration = (int)(([self.treatmentingLog.phase count] - 1) * 5);
                // 添加数据完成，输出验证
                NSLog(@">>> 添加数据 -> 当前护理记录 resistance %@", self.treatmentingLog.resistance);
                NSLog(@">>> 添加数据 -> 当前护理记录 reactance %@", self.treatmentingLog.reactance);
                NSLog(@">>> 添加数据 -> 当前护理记录 phase %@", self.treatmentingLog.phase);
                NSLog(@">>> 添加数据 -> 当前护理记录 intensity %@", self.treatmentingLog.intensity);
                NSLog(@">>> 添加数据 -> 当前护理记录 duration %d", self.treatmentingLog.duration);
                
                // 输出验证完成，更新数据是否是上一条数据
                if ([ApplicationDelegate.treatmentLogs count] > 0) {
                    // 有治疗记录
                    NSDictionary *logDic = [NSDictionary dictionaryWithDictionary:[self.treatmentLogs lastObject]];
                    NSString *lastProductIdString = [NSString stringWithFormat:@"%@", [logDic objectForKey:@"productId"]];
                    NSString *lastTreatmentIndexString = [NSString stringWithFormat:@"%@", [logDic objectForKey:@"treatment_index"]];
                    /*
                     是否与最后一条记录是同一条记录的判断标准
                     1. 同一台设备（即 productId 相同）
                     2. 同一个治疗编号 （即 treatment_index 相同）
                     */
                    if ([lastTreatmentIndexString isEqualToString:self.treatmentingLog.treatment_index] && [lastProductIdString isEqualToString:self.treatmentingLog.productId]) {
                        // 与最后的记录同一条记录，更新最后一条记录
                        [self.treatmentLogs removeLastObject];
                        // 不能直接存，先将 HTreatmentLog 转换成 NSDictionary
                        self.treatmentingLog.log_stuta = 1;
                        NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                        [self.treatmentLogs addObject:treatmentingLogDic];
                    } else {
                        // 与最后的记录不是同一条记录，新增记录
                        NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                        [self.treatmentLogs addObject:treatmentingLogDic];
                    }
                } else {
                    // 无治疗记录，直接添加
                    NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                    [self.treatmentLogs addObject:treatmentingLogDic];
                }
                // 判断是否显示更新数据（更新页面）
                if ([indexString intValue] >= self.needMaxIndex) {
                    if (needTime == YES) {
                        NSDate *now = [NSDate date];
//                        NSTimeInterval hour8 = 8 * 60 * 60;
                        NSTimeInterval min = self.treatmentingLog.duration * 60;
//                        NSDate *CNTime = [now dateByAddingTimeInterval:hour8];
                        NSDate *newTime = [now dateByAddingTimeInterval:-min];
                        
                        NSDateFormatter  *bufferdateformatter = [[NSDateFormatter alloc] init];
                        [bufferdateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                        NSString *timeString = [bufferdateformatter stringFromDate:newTime];
                        self.treatmentingLog.start_time = timeString;
                        needTime = NO;
                    }
                    if (nil == self.treatmentingLog.start_time) {
                        NSDate *now = [NSDate date];
                        NSTimeInterval min = self.treatmentingLog.duration * 60 * 60;
                        NSDate *newTime = [now dateByAddingTimeInterval:-min];
                        
                        NSDateFormatter  *bufferdateformatter = [[NSDateFormatter alloc] init];
                        [bufferdateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                        NSString *timeString = [bufferdateformatter stringFromDate:newTime];
                        self.treatmentingLog.start_time = timeString;
                        needTime = NO;
                    }
                    // 更新护理首页 1: 疼痛指数 2: 时长
                    // 1: 疼痛指数
                    NSNotification *updataGenerationPhaseNotification = [NSNotification notificationWithName:@"updataGenerationPhaseNotification" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:updataGenerationPhaseNotification];
                    // 2: 时长
                    NSNotification *updataGenerationDurationNotification = [NSNotification notificationWithName:@"updataGenerationDurationNotification" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:updataGenerationDurationNotification];
                    // 更新护理详细信息页面 1: 疼痛3个数据 2: 时长 3: 曲线图
                    // 1: 疼痛3个数据
                    NSNotification *updataDetailDataNotification = [NSNotification notificationWithName:@"updataDetailDataNotification" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:updataDetailDataNotification];
                    // 2: 时长
                    NSNotification *updataDetailDurationNotification = [NSNotification notificationWithName:@"updataDetailDurationNotification" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:updataDetailDurationNotification];
                    // 3: 曲线图
                    NSNotification *updataDetailChartViewNotification = [NSNotification notificationWithName:@"updataDetailChartViewNotification" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:updataDetailChartViewNotification];
                    // ——————————————————————————— 显示数据更新完毕，进行保存数据 —————————————————————————————————————————
                    // 数据添加完毕 保存数据持久化
                    NSLog(@">>> 将要保存treatmentLogs %@", self.treatmentLogs);
                    NSDictionary *lastLogDic = [NSDictionary dictionaryWithDictionary:[self.treatmentLogs lastObject]];
                    NSLog(@">>> 保存数据最后一条记录为 position %@", [lastLogDic objectForKey:@"position"]);
                    NSLog(@">>> 保存数据最后一条记录为 symptom %@", [lastLogDic objectForKey:@"symptom"]);
                    NSLog(@">>> 保存数据最后一条记录为 placement %@", [lastLogDic objectForKey:@"placement"]);
                    NSLog(@">>> 保存数据最后一条记录为 productId %@", [lastLogDic objectForKey:@"productId"]);
                    NSLog(@">>> 保存数据最后一条记录为 treatment_index %@", [lastLogDic objectForKey:@"treatment_index"]);
                    NSLog(@">>> 保存数据最后一条记录为 start_time %@", [lastLogDic objectForKey:@"start_time"]);
                    NSLog(@">>> 保存数据最后一条记录为 duration %@", [lastLogDic objectForKey:@"duration"]);
                    NSLog(@">>> 保存数据最后一条记录为 user_id %@", [lastLogDic objectForKey:@"user_id"]);
                    NSLog(@">>> 保存数据最后一条记录为 log_stuta %@", [lastLogDic objectForKey:@"log_stuta"]);
                    NSLog(@">>> 保存数据最后一条记录为 completion %@", [lastLogDic objectForKey:@"completion"]);
                    NSLog(@">>> 保存数据最后一条记录为 parameters_list %@", [lastLogDic objectForKey:@"parameters_list"]);
                    NSLog(@">>> 保存数据最后一条记录为 resistance %@", [lastLogDic objectForKey:@"resistance"]);
                    NSLog(@">>> 保存数据最后一条记录为 reactance %@", [lastLogDic objectForKey:@"reactance"]);
                    NSLog(@">>> 保存数据最后一条记录为 phase %@", [lastLogDic objectForKey:@"phase"]);
                    NSLog(@">>> 保存数据最后一条记录为 intensity %@", [lastLogDic objectForKey:@"intensity"]);
                    [self saveTreatmentLogs];
                    // —————————————————————————————————————————————————————————————————————————————————————————————————
                }
            } else if ([indexString intValue] < [self.treatmentingLog.phase count]) {
                // 数据已添加不作添加数据
                // duration
                self.treatmentingLog.duration += 1;
                // 更新护理首页 1: 时长
                // 1: 时长
                NSNotification *updataGenerationDurationNotification = [NSNotification notificationWithName:@"updataGenerationDurationNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:updataGenerationDurationNotification];
                // 更新护理详细信息页面 1: 时长
                // 1: 时长
                NSNotification *updataDetailDurationNotification = [NSNotification notificationWithName:@"updataDetailDurationNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:updataDetailDurationNotification];
                
                // ———————————————————————————— 显示数据更新完毕，进行保存数据 ——————————————————————————
                if ([ApplicationDelegate.treatmentLogs count] > 0) {
                    // 有治疗记录
                    NSDictionary *logDic = [NSDictionary dictionaryWithDictionary:[self.treatmentLogs lastObject]];
                    NSString *lastProductIdString = [NSString stringWithFormat:@"%@", [logDic objectForKey:@"productId"]];
                    NSString *lastTreatmentIndexString = [NSString stringWithFormat:@"%@", [logDic objectForKey:@"treatment_index"]];
                    /*
                     是否与最后一条记录是同一条记录的判断标准
                     1. 同一台设备（即 productId 相同）
                     2. 同一个治疗编号 （即 treatment_index 相同）
                     */
                    if ([lastTreatmentIndexString isEqualToString:self.treatmentingLog.treatment_index] && [lastProductIdString isEqualToString:self.treatmentingLog.productId]) {
                        // 与最后的记录同一条记录，更新最后一条记录
                        [self.treatmentLogs removeLastObject];
                        // 不能直接存，先将 HTreatmentLog 转换成 NSDictionary
                        NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                        [self.treatmentLogs addObject:treatmentingLogDic];
                    } else {
                        // 与最后的记录不是同一条记录，新增记录
                        NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                        [self.treatmentLogs addObject:treatmentingLogDic];
                    }
                } else {
                    // 无治疗记录，直接添加
                    NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                    [self.treatmentLogs addObject:treatmentingLogDic];
                }
                
                
                // 数据添加完毕 保存数据持久化
                NSLog(@">>> 将要保存treatmentLogs %@", self.treatmentLogs);
                NSDictionary *lastLogDic = [NSDictionary dictionaryWithDictionary:[self.treatmentLogs lastObject]];
                NSLog(@">>> 保存数据最后一条记录为 position %@", [lastLogDic objectForKey:@"position"]);
                NSLog(@">>> 保存数据最后一条记录为 symptom %@", [lastLogDic objectForKey:@"symptom"]);
                NSLog(@">>> 保存数据最后一条记录为 placement %@", [lastLogDic objectForKey:@"placement"]);
                NSLog(@">>> 保存数据最后一条记录为 productId %@", [lastLogDic objectForKey:@"productId"]);
                NSLog(@">>> 保存数据最后一条记录为 treatment_index %@", [lastLogDic objectForKey:@"treatment_index"]);
                NSLog(@">>> 保存数据最后一条记录为 start_time %@", [lastLogDic objectForKey:@"start_time"]);
                NSLog(@">>> 保存数据最后一条记录为 duration %@", [lastLogDic objectForKey:@"duration"]);
                NSLog(@">>> 保存数据最后一条记录为 user_id %@", [lastLogDic objectForKey:@"user_id"]);
                NSLog(@">>> 保存数据最后一条记录为 log_stuta %@", [lastLogDic objectForKey:@"log_stuta"]);
                NSLog(@">>> 保存数据最后一条记录为 completion %@", [lastLogDic objectForKey:@"completion"]);
                NSLog(@">>> 保存数据最后一条记录为 parameters_list %@", [lastLogDic objectForKey:@"parameters_list"]);
                NSLog(@">>> 保存数据最后一条记录为 resistance %@", [lastLogDic objectForKey:@"resistance"]);
                NSLog(@">>> 保存数据最后一条记录为 reactance %@", [lastLogDic objectForKey:@"reactance"]);
                NSLog(@">>> 保存数据最后一条记录为 phase %@", [lastLogDic objectForKey:@"phase"]);
                NSLog(@">>> 保存数据最后一条记录为 intensity %@", [lastLogDic objectForKey:@"intensity"]);
                
                [self saveTreatmentLogs];
                // ————————————————————————————————————————————————————————————————————————————————————————————————————
            } else {
                // 缺少数据需要获取之前数据
                self.needMaxIndex = [indexString intValue];
                for (int i = (int)[self.treatmentingLog.phase count]; i <= [indexString intValue]; i++) {
                    HBLETask *aTask = [[HBLETask alloc] init];
                    aTask.taskName = @"impedanceGetResistanceAndReactanceb:";
                    aTask.parameter = [NSString stringWithFormat:@"%d", i];
                    [ApplicationDelegate.bleCommunicationManager addAnBLETask:aTask];
                }
            }
        }
        return;
    }
    if ([receivedData[0] isEqualToString:@"R0901"]) {
        NSLog(@">>> R0901");
        HBLETask *aTask = [[HBLETask alloc] init];
        aTask.taskName = @"getWorkingStateBuzzer";
        [self.bleCommunicationManager addAnBLETask:aTask];
    }
    if ([receivedData[0] isEqualToString:@"R0902"]) {
        NSLog(@">>> R0902");
        NSLog(@">>> workingBuzzerState %@", receivedData[2]);
        if ([receivedData[2] isEqualToString:@"0"]) {
            self.workingBuzzer_State = 0;
        } else if ([receivedData[2] isEqualToString:@"1"]) {
            self.workingBuzzer_State = 1;
        }
    }
    if ([receivedData[0] isEqualToString:@"R0903"]) {
        NSLog(@">>> R0903");
        HBLETask *aTask = [[HBLETask alloc] init];
        aTask.taskName = @"getErrorStateBuzzer";
        [self.bleCommunicationManager addAnBLETask:aTask];
    }
    if ([receivedData[0] isEqualToString:@"R0904"]) {
        NSLog(@">>> R0904");
        NSLog(@">>> errorBuzzerState %@", receivedData[2]);
        if ([receivedData[2] isEqualToString:@"0"]) {
            self.errorBuzzer_State = 0;
        } else if ([receivedData[2] isEqualToString:@"1"]) {
            self.errorBuzzer_State = 1;
        }
    }
    if ([receivedData[0] isEqualToString:@"R1003"] && [receivedData[2] isEqualToString:@"OK"]) {
        NSLog(@">>> R1003");
        // 开始护理成功
        // 开始转圈 + 按钮变化
        NSNotification *updataMainNotification = [NSNotification notificationWithName:@"updataMainNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:updataMainNotification];
        return;
    }
    if ([receivedData[0] isEqualToString:@"R1004"]) {
        NSString *getString = receivedData[1];
        NSLog(@"getString %@", getString);
        NSArray *array = [getString componentsSeparatedByString:@"-"];
        NSLog(@"array:%@", array);
        if (array.count == 2) {
            self.treatmentingLog.position = [NSString stringWithFormat:@"%@", array[0]];
            self.treatmentingLog.symptom = [NSString stringWithFormat:@"%@", array[1]];
            self.treatmentingLog.placement = [NSString stringWithFormat:@"1p"];
            needTime = YES;
        }
        
        return;
    }
    if ([receivedData[0] isEqualToString:@"R1007"]) {
        if ([receivedData[1] isEqualToString:@"pad"] && [receivedData[2] isEqualToString:@"OK"]) {
            NSLog(@">>> R1007");
//            selectingLightingLabel.textColor = [HAppUIModel orangeColor8];
            [selectingLightingButton setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateNormal];
            if (appTransparentViewEnabled == 1) {
                [appTransparentView setUserInteractionEnabled:YES];
                [self stopTimer3s];
            }
        }
        return;
    }
    if ([receivedData[0] isEqualToString:@"R1008"]) {
        if ([receivedData[1] isEqualToString:@"pad"] && [receivedData[2] isEqualToString:@"OK"]) {
            NSLog(@">>> R1008");
            // 断开连接
            [self.bleCommunicationManager.bleManager disconnectSelectedPeripheral];
            // 改变状态
//            selectedLightingLabel.textColor = [HAppUIModel grayColor23];
            [selectingLightingButton setImage:[UIImage imageNamed:@"bulbGray"] forState:UIControlStateNormal];
            selectingLightingButton = nil;
//            selectedLightingButton = nil;
//            selectedLightingLabel = nil;
//            selectedLightingPeripheral = nil;
        }
        return;
    }
}

# pragma mark >>> 初始化数据
// 获取 mineList.plist 数据
- (void)gainMineList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mineList" ofType:@"plist"];
    self.mineList = [[NSArray alloc] initWithContentsOfFile:path];
    NSLog(@">>> mineList.plist %@", self.mineList);
}
- (void)gainPositionList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"positionList" ofType:@"plist"];
    self.positionList = [[NSArray alloc] initWithContentsOfFile:path];
    NSLog(@">>> positionList.plist %@", self.positionList);
}
- (void)gainProtocolList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"protocolList" ofType:@"plist"];
    self.protocolList = [[NSArray alloc] initWithContentsOfFile:path];
    NSLog(@">>> protocolList.plist %@", self.protocolList);
}
// ———————————————————————————————————————— 治疗记录相关 —————————————————————————————————————————————
// 初始化治疗记录 或 获取治疗记录 （先获取如果为空，再创建）
- (void)initTreatmentLogs {
    // 获取
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSLog(@"path:%@",documentsPath);
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"treatmentLogs.plist"];
    //将plist文件中数据转换成数组形式输出（要预先知道plist中数据类型，否则无法读出）
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
    if (isExist) {
        NSLog(@"咱们有治疗记录，不需要创建");
        NSArray *resultArray = [NSArray arrayWithContentsOfFile:plistPath];
        self.treatmentLogs = [NSMutableArray arrayWithArray:resultArray];
    } else {
        NSLog(@"没有治疗记录创建一个！！！");
        self.treatmentLogs = [NSMutableArray array];
        [self.treatmentLogs writeToFile:plistPath atomically:YES];
    }
    SLog(@">>> 所有记录 %@", self.treatmentLogs);
}
- (void)saveTreatmentLogs {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"treatmentLogs.plist"];
    //写入文件
//    NSLog(@">>> 我要写入 %@", self.treatmentLogs);
    SLog(@">>> 我要写入 %@", self.treatmentLogs);
    
    [self.treatmentLogs writeToFile:plistPath atomically:YES];
}
// ——————————————————————————————————————————————————————————————————————————————————————————————————
# pragma mark >>> 方法
- (void)uploadTreatmentLog {
    if ([ApplicationDelegate.treatmentingLog.phase count] >= 3) {
        // 至少有3个数据才上传（10min）
        NSMutableArray *List = [NSMutableArray array];
        for (int i = 0; i < [self.treatmentingLog.phase count]; i++) {
            int SubProtocolId;
            float Frequency;
            NSString *Polarity;
            int TrueIntensity;
            NSString *Form;
            if (ApplicationDelegate.treatmentingLog.parameters_list) {
                NSLog(@">>> 显示 parameters_list %@", self.treatmentingLog.parameters_list);
                NSString *singleList = [self get:i from:self.treatmentingLog.parameters_list];
                // 获取到 SubProtocolId 准备获取别的数据
                NSArray *listArray = [singleList componentsSeparatedByString:@","];
                SubProtocolId = [listArray[0] intValue];
                Frequency = [listArray[5] floatValue];
                Polarity = listArray[2];
                TrueIntensity = [listArray[3] intValue];
                if ([listArray[4] isEqualToString:@"s"]) {
                    Form = @"square";
                }
                if ([listArray[4] isEqualToString:@"i"]) {
                    Form = @"sine";
                }
                if ([listArray[4] isEqualToString:@"p"]) {
                    Form = @"pilse";
                }
            } else {
                SubProtocolId = 0;
                Frequency = 0;
                Polarity = @"NULL";
                TrueIntensity = 0;
                Form = @"NULL";
            }
            NSString *CTime = [NSString stringWithFormat:@"0"];
            int Resistance = [self.treatmentingLog.resistance[i] intValue];
            int Reactance = [self.treatmentingLog.reactance[i] intValue];
            float Phase = [self.treatmentingLog.phase[i] floatValue];
            int Intensity = [self.treatmentingLog.intensity[i] intValue];
            int Resonance = 0;
            int DutyCycle = 0;
            
            NSDictionary *dic = @{
                                  @"SubProtocolId":@(SubProtocolId),
                                  @"CTime":CTime,
                                  @"Resistance":@(Resistance),
                                  @"Reactance":@(Reactance),
                                  @"Phase":@(Phase),
                                  @"Frequency":@(Frequency),
                                  @"Polarity":Polarity,
                                  @"Intensity":@(Intensity),
                                  @"TrueIntensity":@(TrueIntensity),
                                  @"Form":Form,
                                  @"Resonance":@(Resonance),
                                  @"DutyCycle":@(DutyCycle)
                                  };
            
            [List addObject:dic];
        }
        // 开始准备上传数据
        NSString *ProtocolNo;
        NSString *Location;
        NSString *StartTime;
        if (self.treatmentingLog.position && self.treatmentingLog.symptom && self.treatmentingLog.placement) {
            ProtocolNo = [NSString stringWithFormat:@"%@-%@",self.treatmentingLog.position, self.treatmentingLog.symptom];
            
            NSString *placement;
            for (NSDictionary *dic in self.positionList) {
                if ([self.treatmentingLog.placement isEqualToString:[dic objectForKey:@"id"]]) {
                    placement = [dic objectForKey:@"image"];
                    return;
                }
            }
            NSString *numStr = [self.treatmentingLog.placement substringToIndex:1];
            Location = [NSString stringWithFormat:@"%@%@", placement, numStr];
        } else {
            ProtocolNo = @"NULL";
            Location = @"NULL";
        }
        if (self.treatmentingLog.start_time) {
            StartTime = self.treatmentingLog.start_time;
        } else {
            StartTime = @"NULL";
        }
        NSDate *now = [NSDate date];
        NSDateFormatter  *bufferdateformatter = [[NSDateFormatter alloc] init];
        [bufferdateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *EndTime = [bufferdateformatter stringFromDate:now];
        
        NSDictionary *dic = @{@"UserId":@(self.UserId),
                              @"DeviceNo":ApplicationDelegate.productId,
                              @"ProtocolNo":ProtocolNo,
                              @"Location":Location,
                              @"StartTime":StartTime,
                              @"EndTime":EndTime,
                              @"Duration":@(self.treatmentingLog.duration),
                              @"FirmwareVersion":self.softwareVersion,
                              @"DataVersion":@"2.0.2",
                              @"DeviceType":[self iphoneType],
                              @"OsVersion":[[UIDevice currentDevice] systemVersion],
                              @"List":List
                              };
        
        // NSString *url = @"http://u.aceme-medical.com/user/upTreatmentLog";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",nil];
        [manager POST:TreatmentLog_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            ;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功 responseObject %@", responseObject);
            
            self.treatmentingLog.completion = 1;
            if ([ApplicationDelegate.treatmentLogs count] > 0) {
                // 有治疗记录
                NSDictionary *logDic = [NSDictionary dictionaryWithDictionary:[self.treatmentLogs lastObject]];
                NSString *lastProductIdString = [NSString stringWithFormat:@"%@", [logDic objectForKey:@"productId"]];
                NSString *lastTreatmentIndexString = [NSString stringWithFormat:@"%@", [logDic objectForKey:@"treatment_index"]];
                /*
                 是否与最后一条记录是同一条记录的判断标准
                 1. 同一台设备（即 productId 相同）
                 2. 同一个治疗编号 （即 treatment_index 相同）
                 */
                if ([lastTreatmentIndexString isEqualToString:self.treatmentingLog.treatment_index] && [lastProductIdString isEqualToString:self.treatmentingLog.productId]) {
                    // 与最后的记录同一条记录，更新最后一条记录
                    [self.treatmentLogs removeLastObject];
                    // 不能直接存，先将 HTreatmentLog 转换成 NSDictionary
                    NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                    [self.treatmentLogs addObject:treatmentingLogDic];
                } else {
                    // 与最后的记录不是同一条记录，新增记录
                    NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                    [self.treatmentLogs addObject:treatmentingLogDic];
                }
            } else {
                // 无治疗记录，直接添加
                NSDictionary *treatmentingLogDic = [ModelToJson getObjectData:self.treatmentingLog];
                [self.treatmentLogs addObject:treatmentingLogDic];
            }
            // 数据添加完毕 保存数据持久化
            NSLog(@">>> 将要保存treatmentLogs %@", self.treatmentLogs);
            NSDictionary *lastLogDic = [NSDictionary dictionaryWithDictionary:[self.treatmentLogs lastObject]];
            NSLog(@">>> 保存数据最后一条记录为 position %@", [lastLogDic objectForKey:@"position"]);
            NSLog(@">>> 保存数据最后一条记录为 symptom %@", [lastLogDic objectForKey:@"symptom"]);
            NSLog(@">>> 保存数据最后一条记录为 placement %@", [lastLogDic objectForKey:@"placement"]);
            NSLog(@">>> 保存数据最后一条记录为 productId %@", [lastLogDic objectForKey:@"productId"]);
            NSLog(@">>> 保存数据最后一条记录为 treatment_index %@", [lastLogDic objectForKey:@"treatment_index"]);
            NSLog(@">>> 保存数据最后一条记录为 start_time %@", [lastLogDic objectForKey:@"start_time"]);
            NSLog(@">>> 保存数据最后一条记录为 duration %@", [lastLogDic objectForKey:@"duration"]);
            NSLog(@">>> 保存数据最后一条记录为 user_id %@", [lastLogDic objectForKey:@"user_id"]);
            NSLog(@">>> 保存数据最后一条记录为 log_stuta %@", [lastLogDic objectForKey:@"log_stuta"]);
            NSLog(@">>> 保存数据最后一条记录为 completion %@", [lastLogDic objectForKey:@"completion"]);
            NSLog(@">>> 保存数据最后一条记录为 parameters_list %@", [lastLogDic objectForKey:@"parameters_list"]);
            NSLog(@">>> 保存数据最后一条记录为 resistance %@", [lastLogDic objectForKey:@"resistance"]);
            NSLog(@">>> 保存数据最后一条记录为 reactance %@", [lastLogDic objectForKey:@"reactance"]);
            NSLog(@">>> 保存数据最后一条记录为 phase %@", [lastLogDic objectForKey:@"phase"]);
            NSLog(@">>> 保存数据最后一条记录为 intensity %@", [lastLogDic objectForKey:@"intensity"]);
//            [self saveTreatmentLogs];
            // ————————————————————————————————————————————————————————————————————————————————————
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //        NSString *eeee = [[NSString alloc] initWithData:error encoding:NSUTF8StringEncoding];
            NSLog(@"失败 error: %@", error);
        }];
        [self saveTreatmentLogs];
    }
}

// 重新定义 treatingLog
- (void)reinitTreatmentingLog {
    self.treatmentingLog = [HtreatmentLog new];
    // ———————————————————————————— 监听 treatmentingLog ————————————————————————————
    [self.treatmentingLog addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:nil];
    // ——————————————————————————————————————————————————————————————————————————————
}

- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    return platform;
    
}
// 获取当前的SubProtocolId
- (NSString *)get:(int)num from:(NSArray *)List {
    int time = (num - 1) * 5;
    for (NSString *str in List) {
        NSArray *arr = [str componentsSeparatedByString:@","];
        int t = [arr[1] intValue];
        time = time - t;
        if (time < 0) {
            return str;
        }
    }
    return [List lastObject];
}
// 获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}
// 提醒用户打开手机蓝牙
- (void)createAlertControllerForBLEPower {
    UIAlertController *BLENeedPowerOnAlertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"AppDelegate_AlertControllerTitle1", nil) message:NSLocalizedString(@"AppDelegate_AlertControllerMessage1", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *left = [UIAlertAction actionWithTitle:NSLocalizedString(@"AppDelegate_AlertControllerLeftButton1", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置
        if (@available(iOS 10.0, *)) {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=General"];
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL success) {
            }];
        } else {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=General&path=Bluetooth"];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }
    }];
    UIAlertAction *right = [UIAlertAction actionWithTitle:NSLocalizedString(@"AppDelegate_AlertControllerRightButton1", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 取消
    }];
    [BLENeedPowerOnAlertController addAction:left];
    [BLENeedPowerOnAlertController addAction:right];
    UIViewController *nowController = [self getCurrentVC];
    [nowController presentViewController:BLENeedPowerOnAlertController animated:YES completion:nil];
}
// 弹出连接设备界面
- (void)createConnectView {
    
    NSLog(@">>> 创建连接界面");
//    HBLE_ScanView *scanView = [[HBLE_ScanView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [ApplicationDelegate.window addSubview:scanView];
//    return;
    
    CGFloat horizontalSpace1 = [HAppUIModel baseWidthChangeLength:19.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace2 = [HAppUIModel baseWidthChangeLength:345.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace3 = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace4 = [HAppUIModel baseWidthChangeLength:17.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace5 = [HAppUIModel baseWidthChangeLength:26.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace6 = [HAppUIModel baseWidthChangeLength:20.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace7 = [HAppUIModel baseWidthChangeLength:112.0f baceWidthWithModel:self.myAppScreenModel];
    
    CGFloat verticalSpace1 = [HAppUIModel baseLongChangeLength:59.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace2 = [HAppUIModel baseLongChangeLength:546.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace3 = [HAppUIModel baseLongChangeLength:17.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace4 = [HAppUIModel baseLongChangeLength:92.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace5 = [HAppUIModel baseLongChangeLength:454.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace6 = [HAppUIModel baseLongChangeLength:25.0f baceWidthWithModel:self.myAppScreenModel];
    
    // 透明界面
    appTransparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    appTransparentView.backgroundColor = [HAppUIModel transparentColor1];
    [ApplicationDelegate.window addSubview:appTransparentView];
    
    // 展示背景
    UIView *connectViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, verticalSpace2)];
    [connectViewBackgroundView.layer setMasksToBounds:YES];
    [connectViewBackgroundView.layer setCornerRadius:horizontalSpace3];
    connectViewBackgroundView.backgroundColor = [HAppUIModel whiteColor4];
    connectViewBackgroundView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    [appTransparentView addSubview:connectViewBackgroundView];
    
    // 关闭按钮
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace1, horizontalSpace1)];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    closeButton.center = CGPointMake(horizontalSpace4 + horizontalSpace1 * 0.5, verticalSpace3 + horizontalSpace1 * 0.5);
    [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [connectViewBackgroundView addSubview:closeButton];
    
    // 选取设备 label
    UILabel *selectTitleLabel = [UILabel new];
    selectTitleLabel.font = [HAppUIModel normalFont5];
    selectTitleLabel.textColor = [HAppUIModel grayColor1];
    selectTitleLabel.text = NSLocalizedString(@"AppDelegate_SelectTitle", nil);
    CGSize selectTitleLabel_Size = [NSLocalizedString(@"AppDelegate_SelectTitle", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
    selectTitleLabel_Size = CGSizeMake(ceilf(selectTitleLabel_Size.width), ceilf(selectTitleLabel_Size.height));
    selectTitleLabel.frame = CGRectMake(0, 0, selectTitleLabel_Size.width, selectTitleLabel_Size.height);
    selectTitleLabel.center = CGPointMake(horizontalSpace5 + selectTitleLabel_Size.width * 0.5, verticalSpace1 + selectTitleLabel_Size.height * 0.5);
    [connectViewBackgroundView addSubview:selectTitleLabel];
    
    // 搜索时 gif
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wait" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    waitWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace6, horizontalSpace6)];
    [connectViewBackgroundView addSubview:waitWebView];
    waitWebView.scalesPageToFit = YES;
    waitWebView.scrollView.scrollEnabled = NO;
    waitWebView.backgroundColor = [UIColor clearColor];
    waitWebView.opaque = 0;
    [waitWebView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
    waitWebView.center = CGPointMake(horizontalSpace7 + horizontalSpace6 * 0.5, verticalSpace1 + selectTitleLabel_Size.height * 0.5);
    
    researchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace6)];
    researchButton.titleLabel.font = [HAppUIModel mediumFont9];
    [researchButton setTitleColor:[HAppUIModel mainColor6] forState:UIControlStateNormal];
    [researchButton setTitle:NSLocalizedString(@"AppDelegate_Research", nil) forState:UIControlStateNormal];
    CGSize researchButton_Size = [NSLocalizedString(@"AppDelegate_Research", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont9]}];
    researchButton_Size = CGSizeMake(ceilf(researchButton_Size.width), ceilf(researchButton_Size.height));
    researchButton.frame = CGRectMake(0, 0, researchButton_Size.width, verticalSpace6);
    researchButton.center = CGPointMake(horizontalSpace2 - horizontalSpace6 - researchButton_Size.width * 0.5, verticalSpace1 + selectTitleLabel_Size.height * 0.5);
    [researchButton addTarget:self action:@selector(researchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [connectViewBackgroundView addSubview:researchButton];
    [researchButton setHidden:YES];
    
    // 连接设备tableView
    peripheralTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, verticalSpace4, horizontalSpace2, verticalSpace5)];
    peripheralTableView.delegate = self;
    peripheralTableView.dataSource = self;
    [peripheralTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   //设置 cell 之间的横线
    peripheralTableView.backgroundColor = [UIColor clearColor];
    [peripheralTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [connectViewBackgroundView addSubview:peripheralTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.bleCommunicationManager.bleManager.discoverPeripherals count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    // 清空视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat horizontalSpace1 = [HAppUIModel baseWidthChangeLength:26.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace2 = [HAppUIModel baseWidthChangeLength:42.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace3 = [HAppUIModel baseWidthChangeLength:345.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace4 = [HAppUIModel baseWidthChangeLength:17.0f baceWidthWithModel:self.myAppScreenModel];
    
    CGFloat verticalSpace1 = [HAppUIModel baseLongChangeLength:48.0f baceWidthWithModel:self.myAppScreenModel];
    
    CBPeripheral *peripheral = [self.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:indexPath.row];
    UILabel *peripheralNameLabel = [UILabel new];
    peripheralNameLabel.font = [HAppUIModel normalFont6];
    peripheralNameLabel.textColor = [HAppUIModel grayColor23];
    peripheralNameLabel.text = peripheral.name;
    CGSize peripheralNameLabel_Size = [peripheral.name sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont6]}];
    peripheralNameLabel_Size = CGSizeMake(ceilf(peripheralNameLabel_Size.width), ceilf(peripheralNameLabel_Size.height));
    peripheralNameLabel.frame = CGRectMake(0, 0, peripheralNameLabel_Size.width, peripheralNameLabel_Size.height);
    peripheralNameLabel.center = CGPointMake(horizontalSpace1 + peripheralNameLabel_Size.width * 0.5, verticalSpace1 * 0.5);
    [cell.contentView addSubview:peripheralNameLabel];
    
    // 需要用专门 Button 来传递参数
    HParameterButton *lightingButton = [[HParameterButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
    [lightingButton setImage:[UIImage imageNamed:@"bulbGray"] forState:UIControlStateNormal];
    lightingButton.center = CGPointMake(horizontalSpace3 - horizontalSpace4 - horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
    NSDictionary *lightingButtonDic = @{@"label":peripheralNameLabel, @"index":[NSString stringWithFormat:@"%ld", (long)indexPath.row]};
    lightingButton.parameterDic = lightingButtonDic;
    [lightingButton addTarget:self action:@selector(lightingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:lightingButton];
    
    // 需要用专门 Button 来传递参数
    HParameterButton *stopLightingButton = [[HParameterButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace2, horizontalSpace2)];
    [stopLightingButton setImage:[UIImage imageNamed:@"bulbGray"] forState:UIControlStateNormal];
    stopLightingButton.center = CGPointMake(horizontalSpace3 - horizontalSpace4 - horizontalSpace2 * 0.5, verticalSpace1 * 0.5);
    NSDictionary *stopLightingButtonDic = @{@"label":peripheralNameLabel, @"index":[NSString stringWithFormat:@"%ld", (long)indexPath.row]};
    stopLightingButton.parameterDic = stopLightingButtonDic;
    [stopLightingButton addTarget:self action:@selector(stopLightingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [stopLightingButton setHidden:YES];
    [cell.contentView addSubview:stopLightingButton];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HAppUIModel baseLongChangeLength:48.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@">>> 我要连接 %@ 设备", [self.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:indexPath.row]);
    onePeripheral = [self.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:indexPath.row];
    isLastConnect = YES;
    if (selectingLightingButton == nil) {
        self.BLE_Connected_Style = 0;   // 设置为保持连接而连接设备
        [self.bleCommunicationManager.bleManager connectPeripheral:[self.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:indexPath.row]];
        return;
    }
    if (self.BLE_Connected_Style == 1) {
        HBLETask* aTask;
        aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:aTask];
    } else {
        self.BLE_Connected_Style = 0;   // 设置为保持连接而连接设备
        [self.bleCommunicationManager.bleManager connectPeripheral:[self.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:indexPath.row]];
    }
    if ([self.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:indexPath.row] == selectingLightingPeripheral) {
        NSLog(@"连接闪灯设备");
    } else {
        NSLog(@"连接非闪灯设备");
    }
    // 取消选中效果
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

// button 方法
- (void)closeButtonAction:(UIButton *)sender {
    NSLog(@">>> closeButtonAction");
    if (2 == self.BLE_Connected_Status) {
        // 如果关闭的视图的时候状态是闪灯状态的则关闭闪灯，断开连接和改变状态（这里先关闭亮灯）
        HBLETask* aTask;
        aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:aTask];
    }
    // 清空视图
    [appTransparentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [appTransparentView removeFromSuperview];
    [ApplicationDelegate.bleCommunicationManager.bleManager.discoverPeripherals removeAllObjects];
}

- (void)lightingButtonAction:(HParameterButton *)sender {
    NSLog(@">>> lightingButtonAction");
    [self.bleCommunicationManager clearTasks];
    [appTransparentView setUserInteractionEnabled:NO];
    [self startTimer3s];
    // 先停止搜索
    [self.bleCommunicationManager.bleManager stopScanPeripherals];
    // 获取被选中的设备
    selectingLightingPeripheral = [ApplicationDelegate.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:[[sender.parameterDic valueForKey:@"index"] intValue]];
    if (selectingLightingButton == nil) {
        // 没有闪灯设备的情况
        appTransparentViewEnabled = 1;
        selectingLightingButton = sender;
        self.BLE_Connected_Style = 1;   // 设置为只为闪灯而连接设备
        [self.bleCommunicationManager.bleManager connectPeripheral:selectingLightingPeripheral];
    } else {
        // 有闪灯设备的情况
        if (selectingLightingButton == sender) {
            // 闪灯就是自己(停止闪灯，断开连接，重置闪灯设备)
            appTransparentViewEnabled = 2;
            HBLETask* aTask;
            aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
            [self.bleCommunicationManager addAnBLETask:aTask];
        } else {
            // 闪灯不是自己
            appTransparentViewEnabled = 1;
            witeSelectingLightingButton = sender;
            self.BLE_Connected_Style = 1;   // 设置为只为闪灯而连接设备
            HBLETask* aTask;
            aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
            [self.bleCommunicationManager addAnBLETask:aTask];
        }
    }
    return;
    
    //
//    if (selectingLightingButton == sender) {
//        // 点击同一个亮灯按钮
//        // 先发送停止闪灯，再断开连接，最后在收到通知之后改变状态（现在先停止闪灯）
//        selectedLightingButton = selectingLightingButton;
//        selectedLightingLabel = selectingLightingLabel;
//        selectedLightingPeripheral = selectingLightingPeripheral;
//
//        selectingLightingLabel = nil;
//        selectingLightingButton = nil;
//        selectingLightingPeripheral = nil;
//
//        HBLETask* aTask;
//        aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
//        [self.bleCommunicationManager addAnBLETask:aTask];
//    } else {
//        // 点击了不同的亮灯按钮
//        // 判断是否停止继续搜索
//        if (self.BLE_isScaning) {
//            [self.bleCommunicationManager.bleManager stopScanPeripherals];
//            self.BLE_isScaning = NO;
//        }
//        // 如果有被选择亮灯的设备，先关闭亮灯再断开连接，最后在收到通知之后改变状态
//        if (selectingLightingLabel && selectingLightingPeripheral) {
//            // 这里先停止闪灯
//            selectedLightingButton = selectingLightingButton;
//            selectedLightingLabel = selectingLightingLabel;
//            selectedLightingPeripheral = selectingLightingPeripheral;
//
//            selectingLightingLabel = nil;
//            selectingLightingButton = nil;
//            selectingLightingPeripheral = nil;
//
//            HBLETask* aTask;
//            aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
//            [self.bleCommunicationManager addAnBLETask:aTask];
//        }
//        selectingLightingButton = sender;
//        selectingLightingLabel = [sender.parameterDic valueForKey:@"label"];
//        selectingLightingPeripheral = [ApplicationDelegate.bleCommunicationManager.bleManager.discoverPeripherals objectAtIndex:[[sender.parameterDic valueForKey:@"index"] intValue]];
//        // 连接设备
//        self.BLE_Connected_Style = 1;   // 设置为只为闪灯而连接设备
//        [self.bleCommunicationManager.bleManager connectPeripheral:selectingLightingPeripheral];
//    }
}
- (void)stopLightingButtonAction:(HParameterButton *)sender {
    ;
}
// 刷新按钮动作
- (void)researchButtonAction:(UIButton *)sender {
    if (2 == self.BLE_Connected_Status) {
        // 如果关闭的视图的时候状态是闪灯状态的则关闭闪灯，断开连接和改变状态（这里先关闭亮灯）
        HBLETask* aTask;
        aTask = [[HBLETask alloc] initWithName:@"stopLEDVerification" andParameter:nil];
        [self.bleCommunicationManager addAnBLETask:aTask];
    }
    NSLog(@">>> researchButtonAction");
    [ApplicationDelegate.bleCommunicationManager.bleManager.discoverPeripherals removeAllObjects];
    [peripheralTableView reloadData];
    [ApplicationDelegate.bleCommunicationManager.bleManager beginScanPeripherals];
    [self startScanPeripheralsTimer5s];
    [researchButton setHidden:YES];
    [waitWebView setHidden:NO];
}
// 转换成正数string 带1位小数
- (NSString *)changeGainString:(NSString *)receivedData {
    float gainReceivedData = [receivedData floatValue];
    if (gainReceivedData < 0) {
        gainReceivedData = -gainReceivedData;
    }
    NSString *returnReceivedData = [NSString stringWithFormat:@"%.1f", gainReceivedData];
    NSLog(@"转换好了>>> %@", returnReceivedData);
    return returnReceivedData;
}
#pragma mark >>> 初始化定时器
// ———————————————————————————————— 搜索设备 5s ————————————————————————————————————————————————
// 开始
- (void)startScanPeripheralsTimer5s {
    scanPeripheralsTimer5s = [NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(scanPeripheralsTimer5sAction) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:scanPeripheralsTimer5s forMode:NSDefaultRunLoopMode];
}
// 停止
- (void)stopScanPeripheralsTimer5s {
    if (YES == scanPeripheralsTimer5s.isValid) {
        [scanPeripheralsTimer5s invalidate];
    }
    scanPeripheralsTimer5s = nil;
}
// 动作
- (void)scanPeripheralsTimer5sAction {
    // 搜索5s之后，停止搜索
    [self.bleCommunicationManager.bleManager stopScanPeripherals];
    [waitWebView setHidden:YES];
    [researchButton setHidden:NO];
    self.BLE_isScaning = NO;
}
// ———————————————————————————————————————————————————————————————————————————————————————————————

// —————————————————————————— 3s定时器 ——————————————————————————
// 开始
- (void)startTimer3s {
    timer3s = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(timer3sAction) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer3s forMode:NSDefaultRunLoopMode];
}
// 停止
- (void)stopTimer3s {
    if (YES == timer3s.isValid) {
        [timer3s invalidate];
    }
    timer3s = nil;
    appTransparentViewEnabled = 0;
}
// 动作
- (void)timer3sAction {
    // 搜索5s之后，停止搜索
    [appTransparentView setUserInteractionEnabled:YES];
}
// ————————————————————————————————————————————————————————————————

// ————————————————————————————— 获取设备信息（S0101）————————————————————————————————————————————
// 开始
- (void)startGetDeviceInfoTimer60s {
    getDeviceInfoTimer60s = [NSTimer timerWithTimeInterval:60.0f target:self selector:@selector(getDeviceInfoTimer60sAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:getDeviceInfoTimer60s forMode:NSDefaultRunLoopMode];
}
// 停止
- (void)stopGetDeviceInfoTimer60s {
    if (YES == getDeviceInfoTimer60s.isValid) {
        [getDeviceInfoTimer60s invalidate];
    }
    getDeviceInfoTimer60s = nil;
}
// 动作
- (void)getDeviceInfoTimer60sAction {
    HBLETask *getDeviceInfoTask;
    getDeviceInfoTask = [[HBLETask alloc] initWithName:@"getDeviceInfo" andParameter:nil];
    [self.bleCommunicationManager addAnBLETask:getDeviceInfoTask];
    HBLETask *getTreatmentStatusNewTask;
    getTreatmentStatusNewTask = [[HBLETask alloc] initWithName:@"getTreatmentStatusNew" andParameter:nil];
    [self.bleCommunicationManager addAnBLETask:getTreatmentStatusNewTask];
}
// ———————————————————————————————————————————————————————————————————————————————————————————————


/**
 创建反馈页面
 
 -什么时候出现 治疗结束（治疗时间大于等于10分钟）
 */
- (void)createFeedBackView {
    // ————————————————————————————————————————————————
    CGFloat horizontalSpace1 = [HAppUIModel baseWidthChangeLength:345.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace2 = [HAppUIModel baseWidthChangeLength:80.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace3 = [HAppUIModel baseWidthChangeLength:25.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace4 = [HAppUIModel baseWidthChangeLength:32.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace5 = [HAppUIModel baseWidthChangeLength:315.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace6 = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace7 = [HAppUIModel baseWidthChangeLength:329.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace8 = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace9 = [HAppUIModel baseWidthChangeLength:35.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace10 = [HAppUIModel baseWidthChangeLength:26.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat horizontalSpace11 = [HAppUIModel baseWidthChangeLength:226.0f baceWidthWithModel:self.myAppScreenModel];
    
    CGFloat verticalSpace1 = [HAppUIModel baseLongChangeLength:500.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace2 = [HAppUIModel baseLongChangeLength:100.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace3 = [HAppUIModel baseLongChangeLength:215.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace4 = [HAppUIModel baseLongChangeLength:58.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace5 = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace6 = [HAppUIModel baseLongChangeLength:52.0f baceWidthWithModel:self.myAppScreenModel];
    CGFloat verticalSpace7 = [HAppUIModel baseLongChangeLength:30.0f baceWidthWithModel:self.myAppScreenModel];
     CGFloat verticalSpace8 = [HAppUIModel baseLongChangeLength:425.0f baceWidthWithModel:self.myAppScreenModel];
     CGFloat verticalSpace9 = [HAppUIModel baseLongChangeLength:20.0f baceWidthWithModel:self.myAppScreenModel];
    // ————————————————————————————————————————————————
    
    // 透明界面
    appFeedBackBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    appFeedBackBackgroundView.backgroundColor = [HAppUIModel transparentColor1];
    [ApplicationDelegate.window addSubview:appFeedBackBackgroundView];
    
    // 展示背景
    UIView *feedbackViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace1, verticalSpace1)];
    [feedbackViewBackgroundView.layer setMasksToBounds:YES];
    [feedbackViewBackgroundView.layer setCornerRadius:horizontalSpace6];
    feedbackViewBackgroundView.backgroundColor = [HAppUIModel whiteColor4];
    feedbackViewBackgroundView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace4 + verticalSpace1 * 0.5);
    [appFeedBackBackgroundView addSubview:feedbackViewBackgroundView];
    
    UIView *bluebackgroundView = [UIView new];
    bluebackgroundView.frame = CGRectMake(0, 0, horizontalSpace1, verticalSpace2);
    bluebackgroundView.backgroundColor = [HAppUIModel transparentColor2];
    [feedbackViewBackgroundView addSubview:bluebackgroundView];
    
    UIImageView *smileyImageView = [UIImageView new];
    smileyImageView.frame = CGRectMake(0, 0, horizontalSpace2, horizontalSpace2);
    smileyImageView.image = [UIImage imageNamed:@"Smiley"];
    smileyImageView.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace4);
    [appFeedBackBackgroundView addSubview:smileyImageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [HAppUIModel mediumFont10];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = NSLocalizedString(@"AppDelegate_EndSuccess", nil);
    CGSize titleLabelSize = [NSLocalizedString(@"AppDelegate_EndSuccess", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont10]}];
    titleLabelSize = CGSizeMake(ceilf(titleLabelSize.width), ceilf(titleLabelSize.height));
    titleLabel.frame = CGRectMake(0, 0, titleLabelSize.width, titleLabelSize.height);
    titleLabel.center = CGPointMake(horizontalSpace1 * 0.5, horizontalSpace2 * 0.5 + verticalSpace5 + titleLabelSize.height * 0.5);
    [bluebackgroundView addSubview:titleLabel];
    
    // 关闭按钮
    UIButton *feedbackCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace3, horizontalSpace3)];
    [feedbackCloseButton setImage:[UIImage imageNamed:@"whiteClose"] forState:UIControlStateNormal];
    feedbackCloseButton.center = CGPointMake(horizontalSpace6 + horizontalSpace3 * 0.5, verticalSpace5 + horizontalSpace3 * 0.5);
    [feedbackCloseButton addTarget:self action:@selector(feedbackCloseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [feedbackViewBackgroundView addSubview:feedbackCloseButton];
    
    UILabel *text1Label = [UILabel new];
    text1Label.font = [HAppUIModel normalFont2];
    text1Label.textColor = [HAppUIModel grayColor25];
    text1Label.text = NSLocalizedString(@"AppDelegate_EndText1", nil);
    CGSize text1LabelSize = [NSLocalizedString(@"AppDelegate_EndText1", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    text1LabelSize = CGSizeMake(ceilf(text1LabelSize.width), ceilf(titleLabelSize.height));
    text1Label.frame = CGRectMake(0, 0, text1LabelSize.width, text1LabelSize.height);
    text1Label.center = CGPointMake(horizontalSpace8 + text1LabelSize.width * 0.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height * 0.5);
    [feedbackViewBackgroundView addSubview:text1Label];
    
    // ————————————————————————————————————————
    star1Button = [UIButton new];
    star1Button.frame = CGRectMake(0, 0, horizontalSpace4, horizontalSpace4);
    [star1Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    star1Button.center = CGPointMake(horizontalSpace9 + horizontalSpace4 * 0.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 * 0.5);
    [feedbackViewBackgroundView addSubview:star1Button];
    [star1Button addTarget:self action:@selector(star1ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    star2Button = [UIButton new];
    star2Button.frame = CGRectMake(0, 0, horizontalSpace4, horizontalSpace4);
    [star2Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    star2Button.center = CGPointMake(horizontalSpace9 + horizontalSpace10 + horizontalSpace4 * 1.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 * 0.5);
    [feedbackViewBackgroundView addSubview:star2Button];
    [star2Button addTarget:self action:@selector(star2ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    star3Button = [UIButton new];
    star3Button.frame = CGRectMake(0, 0, horizontalSpace4, horizontalSpace4);
    [star3Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    star3Button.center = CGPointMake(horizontalSpace9 + horizontalSpace10 * 2 + horizontalSpace4 * 2.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 * 0.5);
    [feedbackViewBackgroundView addSubview:star3Button];
    [star3Button addTarget:self action:@selector(star3ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    star4Button = [UIButton new];
    star4Button.frame = CGRectMake(0, 0, horizontalSpace4, horizontalSpace4);
    [star4Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    star4Button.center = CGPointMake(horizontalSpace9 + horizontalSpace10 * 3 + horizontalSpace4 * 3.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 * 0.5);
    [feedbackViewBackgroundView addSubview:star4Button];
    [star4Button addTarget:self action:@selector(star4ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    star5Button = [UIButton new];
    star5Button.frame = CGRectMake(0, 0, horizontalSpace4, horizontalSpace4);
    [star5Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    star5Button.center = CGPointMake(horizontalSpace9 + horizontalSpace10 * 4 + horizontalSpace4 * 4.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 * 0.5);
    [feedbackViewBackgroundView addSubview:star5Button];
    [star5Button addTarget:self action:@selector(star5ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // ————————————————————————————————————————
    
    UILabel *text2Label = [UILabel new];
    text2Label.font = [HAppUIModel normalFont2];
    text2Label.textColor = [HAppUIModel grayColor25];
    text2Label.text = NSLocalizedString(@"AppDelegate_EndText2", nil);
    CGSize text2LabelSize = [NSLocalizedString(@"AppDelegate_EndText2", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont2]}];
    text2LabelSize = CGSizeMake(ceilf(text2LabelSize.width), ceilf(text2LabelSize.height));
    text2Label.frame = CGRectMake(0, 0, text2LabelSize.width, text2LabelSize.height);
    text2Label.center = CGPointMake(horizontalSpace8 + text2LabelSize.width * 0.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 + verticalSpace5 * 2 + text2LabelSize.height * 0.5);
    [feedbackViewBackgroundView addSubview:text2Label];
    
    text3TextView = [UITextView new];
    text3TextView.frame = CGRectMake(0, 0, horizontalSpace5, verticalSpace3);
    text3TextView.font = [HAppUIModel normalFont5];
    text3TextView.textColor = [HAppUIModel grayColor27];
    text3TextView.text = NSLocalizedString(@"AppDelegate_EndText3", nil);
    text3TextView.backgroundColor = [HAppUIModel whiteColor7];
    [text3TextView.layer setMasksToBounds:YES];
    [text3TextView.layer setCornerRadius:horizontalSpace6];
    [text3TextView.layer setBorderColor:[HAppUIModel grayColor24].CGColor];
    [text3TextView.layer setBorderWidth:1.0f];
    text3TextView.center = CGPointMake(horizontalSpace1 * 0.5, verticalSpace2 + verticalSpace5 * 2 + text1LabelSize.height + verticalSpace5 + horizontalSpace4 + verticalSpace5 * 2 + text2LabelSize.height + verticalSpace5 * 2 + verticalSpace3 * 0.5);
    text3TextView.delegate = self;
    text3TextView.keyboardType = UIKeyboardTypeDefault;
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [feedbackViewBackgroundView addSubview:text3TextView];
    
    UIButton *feedbackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace7, verticalSpace6)];
    feedbackButton.center = CGPointMake(SCREEN_WIDTH * 0.5, verticalSpace4 + verticalSpace1 + verticalSpace7 + verticalSpace6 * 0.5);
    [feedbackButton setImage:[UIImage imageNamed:@"feedback"] forState:UIControlStateNormal];
    [feedbackButton setImage:[UIImage imageNamed:@"feedbackSelected"] forState:UIControlStateSelected];
    [feedbackButton addTarget:self action:@selector(feedbackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [appFeedBackBackgroundView addSubview:feedbackButton];
    
    textViewLengthLabel = [UILabel new];
    textViewLengthLabel.frame = CGRectMake(0, 0, horizontalSpace2, verticalSpace9);
    textViewLengthLabel.font = [HAppUIModel normalFont5];
    textViewLengthLabel.textColor = [HAppUIModel grayColor27];
    [textViewLengthLabel setTextAlignment:NSTextAlignmentRight];
    textViewLengthLabel.text = @"0/200";
    textViewLengthLabel.center = CGPointMake(horizontalSpace11 + horizontalSpace2 * 0.5, verticalSpace8 + verticalSpace9 * 0.5);
    [feedbackViewBackgroundView addSubview:textViewLengthLabel];
}

- (void)feedbackCloseButtonAction:(UIButton *)sender {
    NSLog(@"feedbackCloseButtonAction");
    feedbackString = [NSString new];
    [appFeedBackBackgroundView removeFromSuperview];
    [appFeedBackBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)feedbackButtonAction:(UIButton *)sender {
    NSLog(@"feedbackButtonAction");
    
    NSMutableDictionary *uploadDic = [NSMutableDictionary dictionary];
    int user_id = 0;
    if ([ApplicationDelegate.profile valueForKey:@"UserId"]) {
        user_id = [[ApplicationDelegate.profile valueForKey:@"UserId"] intValue];
    }
    [uploadDic setObject:@(user_id) forKey:@"UserId"];
    [uploadDic setObject:@(feedVote) forKey:@"Vote"];
    [uploadDic setObject:self.productId forKey:@"DeviceNo"];
    [uploadDic setObject:feedbackString forKey:@"ResultInfo"];
    NSLog(@"uploadDic %@", uploadDic);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",nil];
    [manager POST:Feedback_URL parameters:uploadDic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"*_*");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 responseObject %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 error: %@", error);
    }];
    [appFeedBackBackgroundView removeFromSuperview];
    [appFeedBackBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)star1ButtonAction:(UIButton *)sender {
    [star1Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star2Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    [star3Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    [star4Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    [star5Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    feedVote = 1;
}
- (void)star2ButtonAction:(UIButton *)sender {
    [star1Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star2Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star3Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    [star4Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    [star5Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    feedVote = 2;
}
- (void)star3ButtonAction:(UIButton *)sender {
    [star1Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star2Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star3Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star4Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    [star5Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    feedVote = 3;
}
- (void)star4ButtonAction:(UIButton *)sender {
    [star1Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star2Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star3Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star4Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star5Button setImage:[UIImage imageNamed:@"hollowStar"] forState:UIControlStateNormal];
    feedVote = 4;
}
- (void)star5ButtonAction:(UIButton *)sender {
    [star1Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star2Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star3Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star4Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [star5Button setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    feedVote = 5;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (feedbackString == nil || [feedbackString isEqualToString:@""]) {
        feedbackString = [NSString new];
        text3TextView.text = feedbackString;
    }
    text3TextView.textColor = [HAppUIModel grayColor28];
}
- (void)textViewDidChange:(UITextView *)textView
{
    //实时显示字数
    textViewLengthLabel.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
    feedbackString = textView.text;
    //字数限制操作
    if (textView.text.length >= 200) {
        textView.text = [textView.text substringToIndex:200];
        textViewLengthLabel.text = @"200/200";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        text3TextView.text = NSLocalizedString(@"AppDelegate_EndText3", nil);
        text3TextView.textColor = [HAppUIModel grayColor27];
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    /* 获取键盘的高度 */
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardRect = aValue.CGRectValue;
    NSLog(@"%f", keyboardRect.size.height);
    [self.clearView setHidden:NO];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview : self.clearView];
    
}
- (void)viewTapAction:(UITapGestureRecognizer *)tap {
    NSLog(@">>> profile - viewTapAction");
    [text3TextView resignFirstResponder];
//    [appTransparentView2 removeFromSuperview];
}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [self.clearView setHidden:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@">>> applicationWillResignActive");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@">>> applicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@">>> applicationWillEnterForeground");
    
    if (self.BLE_Connected_Status == 1) {
        if (NO == getDeviceInfoTimer60s.isValid) {
            [self startGetDeviceInfoTimer60s];
        }
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@">>> applicationDidBecomeActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@">>> applicationWillTerminate");
}


@end
