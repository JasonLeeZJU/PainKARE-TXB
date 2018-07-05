//
//  HBLECenterManager.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/4.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "HBLEDataProcessor.h"

@protocol BLECenterManagerDelegate <NSObject>
@required
- (void)BLECenterManagerStatePowerON;
- (void)BLECenterManagerStatePowerOFF;
- (void)BLECenterManagerScanNewPeripheral;
- (void)BLECenterManagerConnected;
- (void)BLECenterManagerDisconnected;
- (void)BLECenterManagerReceivedData:(NSData*)data;
@end

@interface HBLECenterManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (weak) id <BLECenterManagerDelegate> delegate;// Delegate
@property (strong, nonatomic) HBLEDataProcessor *dataProcessor;// 负责数据处理
@property (strong, nonatomic) CBCentralManager *manager;// 系统蓝牙设备管理对象
@property (strong, nonatomic) NSMutableArray *discoverPeripherals;// 被发现的PainKARE设备
@property (strong, nonatomic) CBPeripheral *selectedPeripheral;// 选择的设备

@property (nonatomic, strong) NSString *selectedServiceUUID;                    // 选择的设备信息ServiceUUID
@property (nonatomic, strong) NSString *selectedCharacteristicUUID;             // 选择的设备信息CharacteristicUUID
@property (nonatomic, strong) CBCharacteristic *selectedCharacteristic;         // 选择的设备信息Characteristic

- (void)beginScanPeripherals;
- (void)stopScanPeripherals;
- (void)connectPeripheral:(CBPeripheral *)peripheral;
- (void)disconnectSelectedPeripheral;
- (void)writeWithoutResponceToSelectedCharacteristicWithData:(NSData *)data;

@end
