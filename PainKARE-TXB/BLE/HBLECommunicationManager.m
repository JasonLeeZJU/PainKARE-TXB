//
//  HBLECommunicationManager.m
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/29.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import "HBLECommunicationManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@implementation HBLECommunicationManager

- (id)init {
    if (self = [super init]) {
        self.dataProcessor = [HBLEDataProcessor new];
        self.bleTaskTable = [NSMutableArray new];
        self.bleManager = [HBLECenterManager new];
        self.bleManager.delegate = self;
        self.isProcessingBLETaskTable = NO;
        self.deviceIsConnected = NO;
    }
    return self;
}

#pragma mark >>> 清空所有BLE任务
- (void)clearTasks {
    [self.bleTaskTable removeAllObjects];
    self.bleTaskTable = [[NSMutableArray alloc] init];
    NSLog(@"清空任务列表 %@", self.bleTaskTable);
}

#pragma mark >>> 处理一个BLE任务
- (void)processAnBLETask {
    HBLETask *oneTask = [self.bleTaskTable firstObject];
    
    SEL cor_method = NSSelectorFromString(oneTask.taskName);
    NSLog(@">>> 处理BLE任务：%@", oneTask.taskName);
    NSLog(@">>> BLE参数：%@", oneTask.parameter);
    @try {
        if ([self respondsToSelector:cor_method]) {
            [self performSelector:cor_method withObject:oneTask.parameter afterDelay:0.0f];
        }
    } @catch (NSException *exception) {
        NSLog(@">>> 不存在此方法");
    } @finally {
        return;
    }
}

#pragma mark >>> 添加一个BLE任务
/*
 * 如果已经有同名任务则不加入
 */
- (void)addAnBLETask:(HBLETask *)task {
    for (HBLETask *oldTask in self.bleTaskTable) {
        if ([task.taskName isEqualToString:oldTask.taskName]&&!task.parameter) {
            NSLog(@">>> 有重复的任务：%@", task.taskName);
            return;
        }
    }
    NSLog(@">>> 添加新任务：%@", task.taskName);
    [self.bleTaskTable addObject:task];
    NSLog(@">>> 当前任务表有 %lu 个任务", (unsigned long)[self.bleTaskTable count]);
    if (!self.isProcessingBLETaskTable) {
        self.isProcessingBLETaskTable = YES;
        [self processAnBLETask];
        NSLog(@">>> 开始处理蓝牙任务");
    }
}

#pragma mark >>> BLECentralManagerDelegate代理方法
- (void)BLECenterManagerStatePowerON {
    [self.delegate CommunicationManagerBLEPowerOn];
}
- (void)BLECenterManagerStatePowerOFF {
    [self.delegate CommunicationManagerBLEPowerOff];
}
- (void)BLECenterManagerScanNewPeripheral {
    [self.delegate CommunicationManagerScanNewPeripheral];
}
- (void)BLECenterManagerConnected {
    [self.delegate CommunicationManagerBLEConnected];
}
- (void)BLECenterManagerDisconnected {
    [self.delegate CommunicationManagerBLEDisconnected];
}
- (void)BLECenterManagerReceivedData:(NSData *)data {
    if ([self.dataProcessor decyptData:data]) {
        NSLog(@">>> App解析信息为：%@", self.dataProcessor.completeMessage);
        // 将获取到的完整信息处理成Array
        for (int i = 0; i < [self.dataProcessor.completeMessageComponents count]; i++) {
            NSLog(@">>> 信息 [%d] 是 %@", i, self.dataProcessor.completeMessageComponents[i]);
        }
        //将Array交给Delegate处理
        NSArray *receivedData = [[NSArray alloc] initWithArray:self.dataProcessor.completeMessageComponents];
        [self.delegate CommunicationManagerBLEReceivedData:receivedData];
        //删除已完成的任务请求
        if([self.bleTaskTable count]>0)
        {
            [self.bleTaskTable removeObjectAtIndex:0];
        }
        //开始处理下一个请求
        if ([self.bleTaskTable count] > 0) {
            [self processAnBLETask];
        }
        else{
            self.isProcessingBLETaskTable = NO;
            NSLog(@"停止处理蓝牙任务");
        }
    }
}

#pragma mark >>> 蓝牙通讯方法

// 获取设备信息
- (void)getDeviceInfo {
    const char *code = "S0101\r\n";
    NSData* data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 getDeviceInfo 已发送");
}
// 获取设备固件软件版本
- (void)getSoftwareVersion {
    const char *code = "S0106\r\n";
    NSData* data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 getSoftwareVersion 已发送");
}
// 停止治疗
- (void)stopTreatment {
    const char *code = "S0204,pad,stop,0,0\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 stopTreatment 已发送");
}
// 判断电极片状态
- (void)getTreatmentStatusNew {
    const char *code = "S0501\r\n";
    NSData* data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 GetTreatmentStatusNew 已发送");
}
// 获取设备正在进行治疗的唯一治疗ID
- (void)getTreatmentIndex {
    const char *code = "S0510\r\n";
    NSData* data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 getTreatmentIndex 已发送");
}
// 获取治疗数据（可选）
- (void)impedanceGetResistanceAndReactanceb:(NSString *)index{
    NSString *sendString = [NSString stringWithFormat:@"S0711,%@\r\n",index];
    const char *code = [sendString cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 impedanceGetResistanceAndReactanceb %@ 已发送", index);
}
// ———————————————————————————————————— 开启护理流程一条龙 ——————————————————————————————————————————
// 处理治疗协议(S1000, S1002)
- (void)requestBufferSet:(NSMutableArray *)protocolArray {
    NSLog(@">>> protocolArray %@", protocolArray);
    NSArray *protocol = [NSArray arrayWithArray:protocolArray[0]];
    // 发送治疗参数0～128
    NSString *protocolInfo = [[NSString alloc] init];
    for (NSString *info in protocol) {
        protocolInfo = [protocolInfo stringByAppendingString:info];
    }
    if ([protocolInfo length] <= 64) {
        NSNumber *contentLength = [NSNumber numberWithInteger:[protocolInfo length]];
        NSNumber *startAddressNumber = [NSNumber numberWithInteger:0];
        NSString *send = [NSString stringWithFormat:@"S1000,%@,%@,%@\r\n", startAddressNumber, contentLength, protocolInfo];
        HBLETask *aTask = [[HBLETask alloc] initWithName:@"sendBuffer:" andParameter:send];
        [self addAnBLETask:aTask];
    } else {
        NSString *firstSend = [protocolInfo substringWithRange:NSMakeRange(0, 64)];
        NSNumber *firstContentLenth = [NSNumber numberWithInteger:64];
        NSNumber *firstStartAddressNumber = [NSNumber numberWithInteger:0];
        NSString *send0 = [NSString stringWithFormat:@"S1000,%@,%@,%@\r\n", firstStartAddressNumber, firstContentLenth, firstSend];
        HBLETask *firstTask = [[HBLETask alloc] initWithName:@"sendBuffer:" andParameter:send0];
        [self addAnBLETask:firstTask];
        NSString *secondSend = [protocolInfo substringFromIndex:64];
        NSNumber *secondStartAddressNumber = [NSNumber numberWithInteger:64];
        NSNumber *secondContentLength = [NSNumber numberWithInteger:[secondSend length]];
        NSString *send64 = [NSString stringWithFormat:@"S1000,%@,%@,%@\r\n", secondStartAddressNumber, secondContentLength, secondSend];
        HBLETask *secondTask = [[HBLETask alloc] initWithName:@"sendBuffer:" andParameter:send64];
        [self addAnBLETask:secondTask];
    }
    // 发送治疗参数128～256
    NSString *protocolInfo2 = [NSString stringWithFormat:@"1;%@;AAA-BBB;%@;%@;%@;AAA;%@",protocolArray[1], protocolArray[4], protocolArray[3], protocolArray[5], protocolArray[6]];
    NSLog(@">>> protocolInfo2 %@", protocolInfo2);
    if ([protocolInfo2 length] <= 64) {
        NSNumber *contentLength = [NSNumber numberWithInteger:[protocolInfo2 length]];
        NSNumber *startAddressNumber = [NSNumber numberWithInteger:128];
        NSString *send = [NSString stringWithFormat:@"S1000,%@,%@,%@\r\n", startAddressNumber, contentLength, protocolInfo2];
        NSLog(@">>> protocolInfo2 send %@", send);
        HBLETask *aTask = [[HBLETask alloc] initWithName:@"sendBuffer:" andParameter:send];
        [self addAnBLETask:aTask];
    } else {
        NSString *firstSend = [protocolInfo2 substringWithRange:NSMakeRange(0, 64)];
        NSNumber *firstContentLenth = [NSNumber numberWithInteger:64];
        NSNumber *firstStartAddressNumber = [NSNumber numberWithInteger:128];
        NSString *send128 = [NSString stringWithFormat:@"S1000,%@,%@,%@\r\n", firstStartAddressNumber, firstContentLenth, firstSend];
        HBLETask *firstTask = [[HBLETask alloc] initWithName:@"sendBuffer:" andParameter:send128];
        [self addAnBLETask:firstTask];
        NSLog(@">>> protocolInfo2 send128 %@", send128);
        NSString *secondSend = [protocolInfo2 substringFromIndex:64];
        NSNumber *secondStartAddressNumber = [NSNumber numberWithInteger:192];
        NSNumber *secondContentLength = [NSNumber numberWithInteger:[secondSend length]];
        NSString *send192 = [NSString stringWithFormat:@"S1000,%@,%@,%@\r\n", secondStartAddressNumber, secondContentLength, secondSend];
        HBLETask *secondTask = [[HBLETask alloc] initWithName:@"sendBuffer:" andParameter:send192];
        [self addAnBLETask:secondTask];
        NSLog(@">>> protocolInfo2 send192 %@", send192);
    }
    //完成写入所有parameters,开始治疗并开始处理下一个任务。
    [self.bleTaskTable removeObjectAtIndex:0];
    NSString* setTimeCode = [NSString stringWithFormat:@"S1002,%@\r\n", protocolArray[2]];
    HBLETask *setTimeStamp = [[HBLETask alloc] initWithName:@"setTimestamp:" andParameter:setTimeCode];
    [self addAnBLETask:setTimeStamp];
    HBLETask *startTask = [[HBLETask alloc] initWithName:@"startTreatment" andParameter:nil];
    [self addAnBLETask:startTask];
    [self processAnBLETask];
}
/*
 * 蜂鸣器相关处理 Begin
 */
// 关闭工作蜂鸣器
- (void)setWorkingStateBuzzerOFF {
    const char *code = "S0901,0\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 setWorkingStateBuzzerOFF 已发送");
}
// 开启工作蜂鸣器
- (void)setWorkingStateBuzzerON {
    const char *code = "S0901,1\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 setWorkingStateBuzzerON 已发送");
}
// 获取工作蜂鸣器状态
- (void)getWorkingStateBuzzer {
    const char *code = "S0902\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 getWorkingStateBuzzer 已发送");
}
// 关闭错误蜂鸣器
- (void)setErrorStateBuzzerOFF {
    const char *code = "S0903,0\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 setErrorStateBuzzerOFF 已发送");
}
// 开启错误蜂鸣器
- (void)setErrorStateBuzzerON {
    const char *code = "S0903,1\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 setErrorStateBuzzerON 已发送");
}
// 获取错误蜂鸣器状态
- (void)getErrorStateBuzzer {
    const char *code = "S0904\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 getErrorStateBuzzer 已发送");
}
/*
 * 蜂鸣器相关处理 End
 */
// 设置治疗协议(S1000)
- (void)sendBuffer:(NSString *)buffer {
    const char *code = [buffer cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 sendBuffer %@ 已发送", buffer);
}
// 设置治疗时间(S1002)
-(void)setTimestamp:(NSString *)currentTime {
    const char *code = [currentTime cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 setTimestamp %@", currentTime);
}
// 开始治疗(S1003)
-(void)startTreatment {
    const char *code = "S1003,pad,start,0,0\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 startTreatment 已发送");
}
-(void)getRequestId {
    const char *code = "S1004\r\n";
    NSData *data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 getRequestId 已发送");
}
// —————————————————————————————————————————————————————————————————————————————————————————————
// 红绿灯闪(S1007)
- (void)startLEDVerification {
    const char *code = "S1007\r\n";
    NSData* data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 startLEDVerification 已发送");
}
// 红绿灯闪停止(S1008)
- (void)stopLEDVerification {
    const char *code = "S1008\r\n";
    NSData* data = [self.dataProcessor encription:code];
    [self.bleManager writeWithoutResponceToSelectedCharacteristicWithData:data];
    NSLog(@">>> 蓝牙 stopLEDVerification 已发送");
}

@end
