//
//  HBLEDataProcessor.h
//  PainKARE-TXB
//
//  Created by Anan on 2017/12/29.
//  Copyright © 2017年 Anan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBLEDataProcessor : NSObject
@property NSString *completeMessage;                        //最近收到的完整的信息
@property NSArray *completeMessageComponents;               //最近收到的完整信息的Array形式

@property (strong, nonatomic) NSString* allChars;           //用于“通过short ID生成buddy ID的压缩算法”
@property NSInteger numChars;
- (id)init;
- (BOOL)decyptData:(NSData*)data;                           //BLE接受信息解码（并处理合并分段信息），首选的信息解密方法。
- (NSData*)encription:(const char *)code;                   //BLE通讯协议加密算法
- (Byte*)decryption:(Byte*)mydata size:(NSInteger)size;     //BLE通讯协议解密算法（一般不直接使用该方法，因为该解密方法不处理分段信息）。被-(BOOL)decyptData:(NSData*)data;方法使用。
-(NSString*)generateBuddyID:(NSString*)shortID;             //通过short ID生成buddy ID的压缩算法
@end
