//
//  HBLEConnectModel.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/3/21.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBLEConnectModel : NSObject
/*  BLE_Connect_Purpose 蓝牙连接的目的
    0: 初始值，未设置
    2: 保持连接
    3: 闪灯
 */
@property (nonatomic, assign) int BLE_Connect_Purpose;

/* BLE_Connect_Status 蓝牙连接的状态
 0: 初始值，未设置
 1: 未连接
 2: 保持连接
 3: 闪灯
 */
@property (nonatomic, assign) int BLE_Connect_Status;

@end
