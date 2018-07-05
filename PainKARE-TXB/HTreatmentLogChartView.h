//
//  HTreatmentLogChartView.h
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/10.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTreatmentLogChartView : UIView

@property (strong, nonatomic) NSMutableArray *selectedTreatmentLog_PhaseList;

- (void)initWithView;

- (void)reloadChartView;

@end
