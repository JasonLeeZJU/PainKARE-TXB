//
//  HBLE_ScanView.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/3/21.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HBLE_ScanView.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

@implementation HBLE_ScanView {
    UIWebView *waitWebView;
    UIButton *researchButton;
    UITableView *peripheralsTableView;
    
    // —————— 适配 ——————
    CGFloat horizontalSpace1;
    CGFloat horizontalSpace2;
    CGFloat horizontalSpace3;
    CGFloat horizontalSpace4;
    CGFloat horizontalSpace5;
    CGFloat horizontalSpace6;
    CGFloat horizontalSpace7;
    
    CGFloat verticalSpace1;
    CGFloat verticalSpace2;
    CGFloat verticalSpace3;
    CGFloat verticalSpace4;
    CGFloat verticalSpace5;
    CGFloat verticalSpace6;
    // ——————————————————
}

- (NSMutableArray *)discoverPeripheralsArray {
    if (!_discoverPeripheralsArray) {
        _discoverPeripheralsArray = [NSMutableArray array];
    }
    return _discoverPeripheralsArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        horizontalSpace1 = [HAppUIModel baseWidthChangeLength:345.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace2 = [HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace3 = [HAppUIModel baseWidthChangeLength:19.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace4 = [HAppUIModel baseWidthChangeLength:17.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace5 = [HAppUIModel baseWidthChangeLength:26.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace6 = [HAppUIModel baseWidthChangeLength:20.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        horizontalSpace7 = [HAppUIModel baseWidthChangeLength:112.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        verticalSpace1 = [HAppUIModel baseLongChangeLength:546.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace2 = [HAppUIModel baseLongChangeLength:17.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace3 = [HAppUIModel baseLongChangeLength:59.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace4 = [HAppUIModel baseLongChangeLength:25.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace5 = [HAppUIModel baseLongChangeLength:454.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        verticalSpace6 = [HAppUIModel baseLongChangeLength:92.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
        
        
        [self createView];
    }
    return self;
}

- (void)createView {
    // 透明界面
    self.backgroundColor = [HAppUIModel transparentColor1];
    
    // 展示背景
    UIView *connectViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace1, verticalSpace1)];
    [connectViewBackgroundView.layer setMasksToBounds:YES];
    [connectViewBackgroundView.layer setCornerRadius:horizontalSpace2];
    connectViewBackgroundView.backgroundColor = [HAppUIModel whiteColor4];
    connectViewBackgroundView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    [self addSubview:connectViewBackgroundView];
    
    // 关闭按钮
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace3, horizontalSpace3)];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    closeButton.center = CGPointMake(horizontalSpace4 + horizontalSpace3 * 0.5, verticalSpace2 + horizontalSpace3 * 0.5);
    [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [connectViewBackgroundView addSubview:closeButton];
    
    // 选取设备 label
    UILabel *selectTitleLabel = [UILabel new];
    selectTitleLabel.font = [HAppUIModel normalFont5];
    selectTitleLabel.textColor = [HAppUIModel grayColor1];
    selectTitleLabel.text = NSLocalizedString(@"AppDelegate_SelectTitle", nil);
    CGSize selectTitleLabel_Size = [NSLocalizedString(@"AppDelegate_SelectTitle", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont5]}];
    selectTitleLabel_Size = CGSizeMake(ceilf(selectTitleLabel_Size.width), ceilf(selectTitleLabel_Size.height));
    selectTitleLabel.frame = CGRectMake(0, 0, selectTitleLabel_Size.width, selectTitleLabel_Size.height);
    selectTitleLabel.center = CGPointMake(horizontalSpace5 + selectTitleLabel_Size.width * 0.5, verticalSpace3 + selectTitleLabel_Size.height * 0.5);
    [connectViewBackgroundView addSubview:selectTitleLabel];
    
    // 搜索时 gif
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wait" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    waitWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, horizontalSpace6, horizontalSpace6)];
    [connectViewBackgroundView addSubview:waitWebView];
    waitWebView.scalesPageToFit = YES;
    waitWebView.scrollView.scrollEnabled = NO;
    waitWebView.backgroundColor = [UIColor clearColor];
    waitWebView.opaque = 0;
    [waitWebView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
    waitWebView.center = CGPointMake(horizontalSpace7 + horizontalSpace6 * 0.5, verticalSpace3 + selectTitleLabel_Size.height * 0.5);
    
    researchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, verticalSpace4)];
    researchButton.titleLabel.font = [HAppUIModel mediumFont9];
    [researchButton setTitleColor:[HAppUIModel mainColor6] forState:UIControlStateNormal];
    [researchButton setTitle:NSLocalizedString(@"AppDelegate_Research", nil) forState:UIControlStateNormal];
    CGSize researchButton_Size = [NSLocalizedString(@"AppDelegate_Research", nil) sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel mediumFont9]}];
    researchButton_Size = CGSizeMake(ceilf(researchButton_Size.width), ceilf(researchButton_Size.height));
    researchButton.frame = CGRectMake(0, 0, researchButton_Size.width, verticalSpace4);
    researchButton.center = CGPointMake(horizontalSpace1 - horizontalSpace6 - researchButton_Size.width * 0.5, verticalSpace3 + selectTitleLabel_Size.height * 0.5);
    [researchButton addTarget:self action:@selector(researchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [connectViewBackgroundView addSubview:researchButton];
    [researchButton setHidden:YES];
    
    // 连接设备tableView
    peripheralsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, verticalSpace6, horizontalSpace1, verticalSpace5)];
    peripheralsTableView.delegate = self;
    peripheralsTableView.dataSource = self;
    [peripheralsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];   //设置 cell 之间的横线
    peripheralsTableView.backgroundColor = [UIColor clearColor];
    [peripheralsTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [connectViewBackgroundView addSubview:peripheralsTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.discoverPeripheralsArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    // 清空视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    CBPeripheral *peripheral = [self.discoverPeripheralsArray objectAtIndex:indexPath.row];
    
    return cell;
}


// 以下——————按钮
- (void)closeButtonAction:(UIButton *)sender {
    ;
}

- (void)researchButtonAction:(UIButton *)sender {
    ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
