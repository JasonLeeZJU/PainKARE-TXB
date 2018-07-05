//
//  HTreatmentLogChartView.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/10.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HTreatmentLogChartView.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@implementation HTreatmentLogChartView {
    NSMutableArray *pointsArray;
    
    CAShapeLayer *shapeGraph;
    
    CGFloat point_SideLength;
    CGFloat point_BorderWidth;
    
    CGFloat X_Axis_Length;
    CGFloat Y_Axis_Length;
    
    CGFloat lineWidthI;
    CGFloat lineWidthII;
    CGFloat lineOffset_Y;
    CGFloat lineShadowOpacity;
    
    CGFloat chartWidth;
    CGFloat chartHeight;
    
    CGFloat label_Y_Width;
    CGFloat label_Y_Height;
    CGFloat label_X_Width;
    CGFloat label_X_Height;
    
    CGFloat horizontalSpaceI;
    CGFloat horizontalSpaceII;
    CGFloat horizontalSpaceIII;
    
    CGFloat verticalSpaceI;
    CGFloat verticalSpaceII;
    CGFloat verticalSpaceIII;
    
    CGFloat MAX_Y;
    CGFloat MIN_Y;
    CGFloat oneParagraph_Y;
    
    CGFloat MAX_X;
    CGFloat MIN_X;
    CGFloat oneParagraph_X;
    CGFloat magnification_X;
}

- (NSMutableArray *)selectedTreatmentLog_PhaseList {
    if (!_selectedTreatmentLog_PhaseList) {
        _selectedTreatmentLog_PhaseList = [NSMutableArray array];
    }
    return _selectedTreatmentLog_PhaseList;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pointsArray = [NSMutableArray array];
        
        shapeGraph = [CAShapeLayer layer];
        
        point_SideLength = [HAppUIModel baseWidthChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        point_BorderWidth = [HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        X_Axis_Length = [HAppUIModel baseWidthChangeLength:328.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        Y_Axis_Length = [HAppUIModel baseLongChangeLength:146.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        lineWidthI = [HAppUIModel baseWidthChangeLength:0.5f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineWidthII = [HAppUIModel baseWidthChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineOffset_Y = [HAppUIModel baseWidthChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        lineShadowOpacity = [HAppUIModel baseWidthChangeLength:10.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        chartWidth = [HAppUIModel baseWidthChangeLength:322.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        chartHeight = [HAppUIModel baseLongChangeLength:140.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        label_Y_Width = [HAppUIModel baseWidthChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        label_Y_Height = [HAppUIModel baseLongChangeLength:18.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        label_X_Width = [HAppUIModel baseWidthChangeLength:24.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        label_X_Height = [HAppUIModel baseLongChangeLength:18.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        horizontalSpaceI = [HAppUIModel baseWidthChangeLength:30.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpaceII = [HAppUIModel baseWidthChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpaceIII = [HAppUIModel baseWidthChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        verticalSpaceI = [HAppUIModel baseLongChangeLength:4.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpaceII = [HAppUIModel baseLongChangeLength:6.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpaceIII = [HAppUIModel baseLongChangeLength:2.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    }
    return self;
}

- (void)initWithView {
    // 处理数据
    [self dataProcessing];
    // 画图
    [self createXYAxis];
    if (0 == [self.selectedTreatmentLog_PhaseList count]) {
        return;
    }
    [self createGraph];
    [self createPoint];
}

- (void)reloadChartView {
    // 清空数据
    [shapeGraph removeFromSuperlayer];
    
    // 处理数据
    [self dataProcessing];
    // 画图
    [self createXYAxis];
    if (0 == [self.selectedTreatmentLog_PhaseList count]) {
        return;
    }
    [self createGraph];
    [self createPoint];
}

- (void)dataProcessing {
    // 获取 Y 最大值（规则：能被4整除 向上取整）
    MAX_Y = [[self.selectedTreatmentLog_PhaseList valueForKeyPath:@"@max.floatValue"] floatValue];
    oneParagraph_Y = ceil(MAX_Y / 4);
    MAX_Y = 4 * oneParagraph_Y;
    if (MAX_Y == 0) {
        MAX_Y = 4;
        oneParagraph_Y = 1;
    }
    NSLog(@">>> FIN MAX_Y %f", MAX_Y);
    
    // 获取 X 最大值（规则：以10为一个倍率，没多10个数据倍率+1）
    MAX_X = [self.selectedTreatmentLog_PhaseList count];
    magnification_X = ceil(MAX_X / 10);
    MAX_X = ceil(MAX_X / magnification_X);
    NSLog(@">>> FIN MAX_X %f", MAX_X);
    oneParagraph_X = (chartWidth - lineWidthI) / (MAX_X + 1);
    
    // 将所有的数据转换成点
    [pointsArray removeAllObjects];
    for (int i = 0; i < [self.selectedTreatmentLog_PhaseList count]; i++) {
        NSLog(@"PhaseList %@", self.selectedTreatmentLog_PhaseList);
        
        double value_Y = [[NSString stringWithFormat:@"%@",[self.selectedTreatmentLog_PhaseList objectAtIndex:i]] doubleValue];
        NSLog(@"x %f, y %f", horizontalSpaceI + lineWidthI + (i + 1) * oneParagraph_X / magnification_X, verticalSpaceI + verticalSpaceII + (chartHeight - lineWidthI) * (1 - value_Y / MAX_Y));
        
        NSLog(@"%f ,%f, %f, %f, %f, %f", verticalSpaceI, verticalSpaceII, chartHeight, lineWidthI, value_Y, MAX_Y);
        
        CGPoint point = CGPointMake(horizontalSpaceI + lineWidthI + (i + 1) * oneParagraph_X / magnification_X, verticalSpaceI + verticalSpaceII + (chartHeight - lineWidthI) * (1 - value_Y / MAX_Y));
        NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [pointsArray addObject:pointValue];
    }
}

- (void)createXYAxis {
    // ———————————————————————————— Y轴 ————————————————————————————————————————————————————
    // 直线
    UIBezierPath * pathY1 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerY1 = [CAShapeLayer layer];
    [pathY1 moveToPoint:CGPointMake(horizontalSpaceI, verticalSpaceI)];
    [pathY1 addLineToPoint:CGPointMake(horizontalSpaceI, verticalSpaceI + Y_Axis_Length)];
    shapeLayerY1.path = pathY1.CGPath;
    shapeLayerY1.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerY1.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerY1.lineWidth = lineWidthI;
    [self.layer addSublayer:shapeLayerY1];
    // 箭头
    UIBezierPath * pathY2 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerY2 = [CAShapeLayer layer];
    [pathY2 moveToPoint:CGPointMake(horizontalSpaceI - horizontalSpaceII, verticalSpaceI + verticalSpaceII)];
    [pathY2 addLineToPoint:CGPointMake(horizontalSpaceI, verticalSpaceI)];
    [pathY2 addLineToPoint:CGPointMake(horizontalSpaceI + horizontalSpaceII, verticalSpaceI + verticalSpaceII)];
    shapeLayerY2.path = pathY2.CGPath;
    shapeLayerY2.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerY2.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerY2.lineWidth = lineWidthI;
    [self.layer addSublayer:shapeLayerY2];
    // 文字
    for (int i = 0; i < 5; i++) {
        __weak NSString *Label_Y_String = [NSString stringWithFormat:@"%.f", MAX_Y - i * oneParagraph_Y];
        UILabel *Label_Y = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, label_Y_Width, label_Y_Height)];
        Label_Y.font = [HAppUIModel normalFont4];
        Label_Y.textColor = [HAppUIModel grayColor11];
        Label_Y.text = Label_Y_String;
        [Label_Y setTextAlignment:NSTextAlignmentRight];
        Label_Y.center = CGPointMake(label_Y_Width * 0.5, verticalSpaceI + verticalSpaceII + i * (chartHeight  - lineWidthI) * 0.25);
        [self addSubview:Label_Y];
    }
    // ——————————————————————————————————————————————————————————————————————————————————————
    
    //  ———————————————————————————— X轴 ————————————————————————————————————————————————————
    // 直线
    UIBezierPath * pathX1 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerX1 = [CAShapeLayer layer];
    [pathX1 moveToPoint:CGPointMake(horizontalSpaceI, verticalSpaceI + Y_Axis_Length)];
    [pathX1 addLineToPoint:CGPointMake(horizontalSpaceI + X_Axis_Length, verticalSpaceI + Y_Axis_Length)];
    shapeLayerX1.path = pathX1.CGPath;
    shapeLayerX1.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerX1.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerX1.lineWidth = lineWidthI;
    [self.layer addSublayer:shapeLayerX1];
    // 箭头
    UIBezierPath * pathX2 = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayerX2 = [CAShapeLayer layer];
    [pathX2 moveToPoint:CGPointMake(horizontalSpaceI + X_Axis_Length - horizontalSpaceIII, verticalSpaceI + Y_Axis_Length - verticalSpaceIII)];
    [pathX2 addLineToPoint:CGPointMake(horizontalSpaceI + X_Axis_Length, verticalSpaceI + Y_Axis_Length)];
    [pathX2 addLineToPoint:CGPointMake(horizontalSpaceI + X_Axis_Length - horizontalSpaceIII, verticalSpaceI + Y_Axis_Length + verticalSpaceIII)];
    shapeLayerX2.path = pathX2.CGPath;
    shapeLayerX2.strokeColor = [HAppUIModel grayColor10].CGColor;
    shapeLayerX2.fillColor = [[UIColor clearColor] CGColor];
    shapeLayerX2.lineWidth = lineWidthI;
    [self.layer addSublayer:shapeLayerX2];
    // 文字
    if (0 == [self.selectedTreatmentLog_PhaseList count]) {
        return;
    }
    for (int i = 0; i < MAX_X; i++) {
        __weak NSString *Label_X_String = [NSString stringWithFormat:@"%.f", (i + 1) * magnification_X];
        UILabel *Label_X = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, label_X_Width, label_X_Height)];
        Label_X.font = [HAppUIModel normalFont4];
        Label_X.textColor = [HAppUIModel grayColor11];
        Label_X.text = Label_X_String;
        CGSize Label_X_Size = [Label_X_String sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont4]}];
        Label_X_Size = CGSizeMake(ceilf(Label_X_Size.width), ceilf(Label_X_Size.height));
        Label_X.frame = CGRectMake(0, 0, Label_X_Size.width, Label_X_Size.height);
        Label_X.center = CGPointMake(horizontalSpaceI + lineWidthI + (i + 1) * oneParagraph_X, verticalSpaceI + Y_Axis_Length + Label_X_Size.height * 0.5);
        [self addSubview:Label_X];
    }
    UILabel *Label_X_End = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, label_X_Width, label_X_Height)];
    Label_X_End.font = [HAppUIModel normalFont4];
    Label_X_End.textColor = [HAppUIModel grayColor11];
    Label_X_End.text = NSLocalizedString(@"mine_TreatmentLogFrequency", nil);
    CGSize Label_X_End_Size = [NSLocalizedString(@"mine_TreatmentLogFrequency", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont4]}];
    Label_X_End_Size = CGSizeMake(ceilf(Label_X_End_Size.width), ceilf(Label_X_End_Size.height));
    Label_X_End.frame = CGRectMake(0, 0, Label_X_End_Size.width, Label_X_End_Size.height);
    Label_X_End.center = CGPointMake(horizontalSpaceI + lineWidthI + (MAX_X + 1) * oneParagraph_X, verticalSpaceI + Y_Axis_Length + Label_X_End_Size.height * 0.5);
    [self addSubview:Label_X_End];
    // ——————————————————————————————————————————————————————————————————————————————————————
}
- (void)createGraph {
    // ———————————— 仅作为位子测试（用完可删） ————————————————————————————
    UIView *graphbackgroundView = [[UIView alloc] initWithFrame:CGRectMake(horizontalSpaceI + lineWidthI, verticalSpaceI + verticalSpaceII, chartWidth - lineWidthI, chartHeight - lineWidthI)];
    graphbackgroundView.backgroundColor = [UIColor redColor];
//    [self addSubview:graphbackgroundView];
    // ————————————————————————————————————————————————————————————————
    
    // 画图前先为画图添加数据（为了画曲线需要添加第一个点和最后一个点）
    NSMutableArray *graphPointArray = [NSMutableArray arrayWithArray:pointsArray];
    
    NSValue *firstPointValue = [NSValue valueWithCGPoint:CGPointMake(horizontalSpaceI + lineWidthI, verticalSpaceI + verticalSpaceII + (chartHeight - lineWidthI) * 0.5)];
    [graphPointArray insertObject:firstPointValue atIndex:0];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(horizontalSpaceI + lineWidthI + chartWidth - lineWidthI, verticalSpaceI + verticalSpaceII + (chartHeight - lineWidthI) * 0.5)];
    [graphPointArray addObject:endPointValue];
    
    /** 折线路径 */
    UIBezierPath *pathGraph = [UIBezierPath bezierPath];
    shapeGraph = [CAShapeLayer layer];
    for (NSInteger i = 0; i < [graphPointArray count] - 3; i++) {
        CGPoint p1 = [[graphPointArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[graphPointArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[graphPointArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[graphPointArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [pathGraph moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:pathGraph];
    }
    /** 将折线添加到折线图层上，并设置相关的属性 */
    shapeGraph = [CAShapeLayer layer];
    shapeGraph.path = pathGraph.CGPath;
    shapeGraph.strokeColor = [HAppUIModel orangeColor3].CGColor;
    shapeGraph.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    shapeGraph.lineWidth = lineWidthII;
    shapeGraph.lineCap = kCALineCapRound;
    shapeGraph.lineJoin = kCALineJoinRound;
    [shapeGraph setShadowOffset:CGSizeMake(0, lineOffset_Y)];
    [shapeGraph setShadowColor:[HAppUIModel orangeColor3].CGColor];
    [shapeGraph setShadowOpacity:lineShadowOpacity];
    [self.layer addSublayer:shapeGraph];
}

- (void)createPoint {
    for (int i = 0; i < MAX_X; i++) {
        if ((i + 1) * magnification_X - 1 > [pointsArray count] - 1) {
            ;
        } else {
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, point_SideLength, point_SideLength)];
            [pointView setBackgroundColor:[UIColor whiteColor]];
            [pointView.layer setCornerRadius:point_SideLength * 0.5];
            [pointView.layer setBorderWidth:point_BorderWidth];
            [pointView.layer setBorderColor:[HAppUIModel orangeColor2].CGColor];
            NSLog(@">>> pointsArray %@", pointsArray);
            pointView.center = [[pointsArray objectAtIndex:(i + 1) * magnification_X - 1] CGPointValue];
            [self addSubview:pointView];
        }
    }
}

// 计算弧度
- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path {
    CGFloat smooth_value = 0.6f;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) / 2.0;
    CGFloat yc1 = (y0 + y1) / 2.0;
    CGFloat xc2 = (x1 + x2) / 2.0;
    CGFloat yc2 = (y1 + y2) / 2.0;
    CGFloat xc3 = (x2 + x3) / 2.0;
    CGFloat yc3 = (y2 + y3) / 2.0;
    CGFloat len1 = sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
    CGFloat len2 = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    CGFloat len3 = sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}

@end
