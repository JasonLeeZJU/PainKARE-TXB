//
//  HBLE_ScanView.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/3/21.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBLE_ScanView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *discoverPeripheralsArray;

@end
