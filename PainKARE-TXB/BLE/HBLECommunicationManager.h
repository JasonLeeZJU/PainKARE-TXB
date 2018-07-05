//
//  HBLECommunicationManager.h
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/29.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBLECenterManager.h"
#import "HBLETask.h"
#import "HBLEDataProcessor.h"

@protocol CommunicationManagerDelegate <NSObject>
- (void)CommunicationManagerBLEPowerOn;                                      // BLE已开启
- (void)CommunicationManagerBLEPowerOff;                                     // BLE已关闭
- (void)CommunicationManagerScanNewPeripheral;                               // 搜索设备时发现新设备
- (void)CommunicationManagerBLEConnected;                                    // 设备已连接
- (void)CommunicationManagerBLEDisconnected;                                 // 设备连接已断开
- (void)CommunicationManagerBLEReceivedData:(NSArray*)receivedData;          // 从设备收到一条新消息
@end

@interface HBLECommunicationManager : NSObject <BLECenterManagerDelegate>
@property (weak) id <CommunicationManagerDelegate> delegate;                // Delegate
@property (strong, nonatomic) HBLECenterManager *bleManager;                // 负责BLE功能的BLE Manager
@property (strong, nonatomic) HBLEDataProcessor *dataProcessor;                 // 负责数据处理
@property (strong, nonatomic) NSMutableArray<HBLETask *> *bleTaskTable;     // 储存待处理的BLE任务
@property BOOL isProcessingBLETaskTable;                                    // 用来判断是否在处理任务的过程中
@property BOOL deviceIsConnected;// 是否已连接上设备

// 添加一个BLE任务
-(void)addAnBLETask:(HBLETask *)task;
// 清空任务
- (void)clearTasks;

@end
