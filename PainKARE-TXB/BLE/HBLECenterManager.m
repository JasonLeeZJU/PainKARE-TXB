//
//  HBLECenterManager.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/4.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HBLECenterManager.h"
#import "AppDelegate.h"

@implementation HBLECenterManager

#pragma mark >>> 初始化
- (instancetype)init {
    if (self = [super init]) {
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.dataProcessor = [HBLEDataProcessor new];
        self.selectedServiceUUID = [NSString new];
        self.selectedCharacteristicUUID = [NSString new];
        self.selectedCharacteristic = [CBCharacteristic new];
    }
    return self;
}
- (NSMutableArray *)discoverPeripherals {
    if (_discoverPeripherals == nil) {
        _discoverPeripherals = [NSMutableArray array];
    }
    return _discoverPeripherals;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case 4:
            NSLog(@">>> CBManagerStatePoweredOff");
            [self.delegate BLECenterManagerStatePowerOFF];
            break;
        case 5:
            NSLog(@">>> CBManagerStatePoweredOn");
            [self.delegate BLECenterManagerStatePowerON];
            break;
        default:
            [self.delegate BLECenterManagerStatePowerOFF];
            break;
    }
}

#pragma mark >>> 搜索到蓝牙（监控）
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (ApplicationDelegate.defaultDeviceIdentifier) {
        // 存在默认设备
        if ([[NSString stringWithFormat:@"%@", peripheral.identifier] isEqualToString:ApplicationDelegate.defaultDeviceIdentifier]) {
            // 发现默认设备
            ApplicationDelegate.BLE_Connected_Style = 2;
            [self stopScanPeripherals];
            self.selectedPeripheral = peripheral;
            [self connectPeripheral:self.selectedPeripheral];
        } else {
            // 非默认设备
        }
    } else {
        // 不存在默认设备
        // 定义蓝牙名字为 10 个字符，“TriD-”开头的蓝牙设备为PainKARE设备
        if (peripheral.name.length == 10) {
            if ([[peripheral.name substringToIndex:5] isEqualToString:@"TriD-"]) {
                NSLog(@"central >>> %@", central);
                NSLog(@"peripheral >>> %@", peripheral.identifier);
                NSLog(@"advertisementData >>> %@", advertisementData);
                NSLog(@"RSSI >>> %@", RSSI);
                for (int i = 0; i < self.discoverPeripherals.count; i++) {
                    CBPeripheral *discoveredPeripheral = [self.discoverPeripherals objectAtIndex:i];
                    if (discoveredPeripheral.identifier == peripheral.identifier) {
                        [self.discoverPeripherals replaceObjectAtIndex:i withObject:peripheral];
                        NSLog(@">>> 覆盖重复的PainKARE");
                        return;
                    }
                }
                [self.discoverPeripherals addObject:peripheral];
                NSLog(@">>> 发现新的PainKARE");
                [self.delegate BLECenterManagerScanNewPeripheral];
            } else {
                NSLog(@">>> 非PainKARE");
            }
        } else {
            NSLog(@">>> 非PainKARE");
        }
    }
}
#pragma mark >>> 连接上蓝牙（监控）
// 连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@">>> 正在连接到名称为（%@）的设备",peripheral.identifier);
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [peripheral discoverServices:nil];
}
// Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@">>> 外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    [self.delegate BLECenterManagerDisconnected];
}
// 扫描到services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@">>> 扫描到服务：%@", peripheral.services);
    if (error) {
        NSLog(@">>> 连接 %@ 出现错误: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services) {
        NSLog(@">>> 连接设备 UUID：%@", service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
    }
}
// 扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@">>> 发现 characteristics：%@ 出错：%@", service.UUID, [error localizedDescription]);
        return;
    }
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@">>> 发现 service：%@ 的 发现 Characteristic：%@", service.UUID, characteristic.UUID);
        self.selectedPeripheral = peripheral;
        self.selectedServiceUUID = [NSString stringWithFormat:@"%@", service.UUID];
        self.selectedCharacteristicUUID = [NSString stringWithFormat:@"%@", characteristic.UUID];
        self.selectedCharacteristic = characteristic;
    }
    NSLog(@">>> 连接 %@ 设备成功", peripheral.identifier);
    // 设置获取该设备通知
    [self notifyCharacteristic:peripheral characteristic:self.selectedCharacteristic];
    [self.delegate BLECenterManagerConnected];
}
// 获取到蓝牙信息
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Received data: %s", [characteristic.value bytes]);
    [self.delegate BLECenterManagerReceivedData:characteristic.value];
}
#pragma mark >>> 功能模块
// 开始搜索
- (void)beginScanPeripherals {
    [self.manager scanForPeripheralsWithServices:nil options:nil];
}
// 停止搜索
- (void)stopScanPeripherals {
    [self.manager stopScan];
}
// 连接设备
- (void)connectPeripheral:(CBPeripheral *)peripheral {
    [ApplicationDelegate.bleCommunicationManager clearTasks];
    [self.manager connectPeripheral:peripheral options:nil];
}
// 断开设备
- (void)disconnectSelectedPeripheral {
    [self.manager cancelPeripheralConnection:self.selectedPeripheral];
    self.selectedPeripheral.delegate = nil;
}
// 断开设备指定设备
//- (void)cancelConnectPeripheral:(CBPeripheral *)peripheral {
//    [self.manager cancelPeripheralConnection:peripheral];
//    peripheral.delegate = nil;
//}
// 设置通知
- (void)notifyCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic {
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
}
// 取消通知
- (void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic {
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}
// 发送协议
- (void)writeWithoutResponceToSelectedCharacteristicWithData:(NSData *)data {
    if (self.selectedCharacteristic) {
        [self.selectedPeripheral writeValue:data forCharacteristic:self.selectedCharacteristic type:CBCharacteristicWriteWithoutResponse];
    } else {
        NSLog(@">>> 没有选择的 Characteristic");
    }
}


@end
