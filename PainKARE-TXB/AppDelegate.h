//
//  AppDelegate.h
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/22.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAppUIModel.h"
#import "HBLECommunicationManager.h"
#import "HtreatmentLog.h"
#import "HBLEConnectModel.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define TABBAR_HEIGHT [self.tabBarController.tabBar bounds].size.height

#define Profile_URL @"http://u.aceme-medical.com/user/upUserProfile"
#define TreatmentLog_URL @"http://u.aceme-medical.com/user/upTreatmentLog"
#define Feedback_URL @"http://u.aceme-medical.com/user/upVote"

#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

@interface AppDelegate : UIResponder <UIApplicationDelegate, CommunicationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

// ———————————————————— App 自定义全局变量 ————————————————————————————————————————
@property (strong, nonatomic) HBLECommunicationManager *bleCommunicationManager;    //  蓝牙管理
@property (assign, nonatomic) int myAppScreenModel;     // 手机屏幕大小 >>> 0: null   1: 4.0  2: 4.7  3: 5.5  4: 5.8
//@property (assign, nonatomic) int deviceStatusStyle;    // 设备状态 >>> 0: idel   1: run  2: stop
@property (assign, nonatomic) int deviceBatteryPower;   // 设备电量
@property (assign, nonatomic) NSString *defaultDeviceIdentifier;  // 默认设备Identifiter
@property (strong, nonatomic) NSString *productId;  // 产品ID
@property (strong, nonatomic) NSString *softwareVersion;    // 软件版本
@property (assign, nonatomic) int deviceWorkingStutas;  // 设备工作状态： 0: idle， 1: run， 2: stop
/*  needMaxIndex
    应该获取的数据个数
    作用：获取早期数据的时候不更新页面，获取完成才更新页面
    用法：初始为0，需要获取早期数据的时候赋值，在获取完早期数据的时候置0
 */
@property (assign, nonatomic) int needMaxIndex;

@property (strong, nonatomic) NSMutableArray *treatmentLogs;    //所有治疗记录
@property (strong, nonatomic) HtreatmentLog *treatmentingLog; // 正在进行护理的记录

//@property (strong, nonatomic) NSString *user_id;

/*  生理信息
    UserId      >>>     用户 Id
    UserName    >>>     姓名
    AgeGroup    >>>     年龄组
    Sex         >>>     性别
    Height      >>>     身高
    Weight      >>>     体重
    Health      >>>     健康状况
    Race        >>>     种族
    BloodType   >>>     血型
    Country     >>>     国家
    Region      >>>     地区
    Phone       >>>     电话
    Mail        >>>     邮箱
    Pacemaker   >>>     心脏起搏器（0:没有，1:有）
 
    Complete    >>>     完整
    Upload      >>>     上传
 */
@property (strong, nonatomic) NSMutableDictionary *profile;
@property (assign, nonatomic) int UserId;

// 数据
@property (strong, nonatomic) NSArray *mineList;
@property (strong, nonatomic) NSArray *positionList;
@property (strong, nonatomic) NSArray *protocolList;

// 保存治疗数据
- (void)saveTreatmentLogs;
// 创建搜索页面
- (void)createScanView;
// 创建反馈页面
- (void)createFeedBackView;

// ———————————————————————————— 蓝牙状态控制 ——————————————————————————————————————————
// 蓝牙状态
@property (assign, nonatomic) int BLE_Status;   // 手机蓝牙状态： 0: 关闭， 1: 打开， 2: 其他
@property (assign, nonatomic) int BLE_Connect_Style;   // 搜索/连接设备的方法： 0: 不存在保存的设备， 1: 存在保存的设备
@property (assign, nonatomic) BOOL BLE_isScaning;    //  是否在搜索设备
@property (assign, nonatomic) int BLE_Connected_Style;  // 连接设备的目的(连接之前设置)： 0: 保持连接状态， 1: 只为了闪灯连接设备 2: 自动连接（保持着连接）， 3: 重新连接
@property (assign, nonatomic) int BLE_Connected_Status; // 手机与设备之间的连接状态（连接之后设置）： 0: 未连接， 1: 保持着连接， 2: 为了闪灯而连接



// 蜂鸣器状态
@property (assign, nonatomic) int errorBuzzer_State; // 错误蜂鸣器状态 0: 关 1: 开 （默认：开）
@property (assign, nonatomic) int workingBuzzer_State; // 工作蜂鸣器状态 0: 关 1: 开 （默认：关）

// 初始化蓝牙
- (void)initBLEMamager;

- (void)reinitTreatmentingLog;
// ——————————————————————————————————————————————————————————————————————————————————————————

@end

