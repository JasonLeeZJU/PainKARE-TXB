//
//  HTreatment_PositionViewController.m
//  PainKARE-TXB
//
//  Created by Anan on 2018/1/8.
//  Copyright © 2018年 Anan. All rights reserved.
//

#import "HTreatment_PositionViewController.h"
#import "AppDelegate.h"
#import "HAppUIModel.h"

#import "HTreatment_Position_PlacementViewController.h"

@interface HTreatment_PositionViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HTreatment_PositionViewController {
    UIView *treatment_PositionView;
    UITableView *treatment_PositionTableView;
    UILabel *treatment_PositionTipLabel;
    
    CGFloat cellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HAppUIModel whiteColor3];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = NSLocalizedString(@"treatment_PositionNavigationTitle", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[HAppUIModel titleFont2], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置返回按钮
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] init];
    backbutton.title = @"";
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // —————————————————————————— 测试（可能会用） ——————————————————————————————————
//    UIButton *leftButton = [UIButton new];
//    [leftButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -10;
//    self.navigationItem.leftBarButtonItems = @[spaceItem, leftItem];
//
//    self.navigationItem.leftBarButtonItem = leftItem;
    // ——————————————————————————————————————————————————————————————————————
    
    treatment_PositionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT + 44, SCREEN_WIDTH, SCREEN_HEIGHT - (STATUS_HEIGHT + 44))];
    treatment_PositionTableView.delegate = self;
    treatment_PositionTableView.dataSource = self;
    [treatment_PositionTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];   //取消 cell 之间的横线
    treatment_PositionTableView.backgroundColor = [UIColor clearColor];
    [treatment_PositionTableView setShowsVerticalScrollIndicator:NO]; //取消滑条
    [self.view addSubview:treatment_PositionTableView];
    
    treatment_PositionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44)];
    treatment_PositionView.backgroundColor = [HAppUIModel mainColor1];
    [self.view addSubview:treatment_PositionView];
    
    treatment_PositionTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    treatment_PositionTipLabel.textColor = [HAppUIModel grayColor1];
    treatment_PositionTipLabel.font = [HAppUIModel normalFont1];
    [treatment_PositionTipLabel setTextAlignment:NSTextAlignmentCenter];
    treatment_PositionTipLabel.text = @"一句话提示";
    treatment_PositionTipLabel.alpha = 0;
    [treatment_PositionView addSubview:treatment_PositionTipLabel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ApplicationDelegate.positionList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiter = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    // 清空视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat positionImageViewBorderWidth = [HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat positionImageViewSideLength = [HAppUIModel baseWidthChangeLength:77.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat arrowImageViewSideLength = [HAppUIModel baseWidthChangeLength:27.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat labelWidth = [HAppUIModel baseWidthChangeLength:228.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat labelheightI = [HAppUIModel baseLongChangeLength:20.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat labelheightII = [HAppUIModel baseLongChangeLength:57.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat leftSpaceI = [HAppUIModel baseWidthChangeLength:15.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat leftSpaceII = [HAppUIModel baseWidthChangeLength:16.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat rightSpace = [HAppUIModel baseWidthChangeLength:1.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceI = [HAppUIModel baseLongChangeLength:14.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceII = [HAppUIModel baseLongChangeLength:13.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceIII = [HAppUIModel baseLongChangeLength:17.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceIV = [HAppUIModel baseLongChangeLength:43.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceV = [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    CGFloat topSpaceVI = [HAppUIModel baseLongChangeLength:77.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
    
    NSDictionary *cellModel = [NSDictionary dictionaryWithDictionary:[ApplicationDelegate.positionList objectAtIndex:indexPath.section]];
    NSString *name = [NSString stringWithFormat:@"%@", [cellModel valueForKey:@"name"]];
    NSString *imageString = [NSString stringWithFormat:@"%@", [cellModel valueForKey:@"image"]];
    NSString *indications = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"treatment_PositionIndications", nil),[cellModel valueForKey:@"indications"]];
    NSString *proposal = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"treatment_PositionProposal", nil), [cellModel valueForKey:@"proposal"]];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [HAppUIModel normalFont6];
    nameLabel.textColor = [HAppUIModel grayColor5];
    nameLabel.text = name;
    CGSize nameLabelSize = [name sizeWithAttributes:@{NSFontAttributeName: [HAppUIModel normalFont6]}];
    nameLabelSize = CGSizeMake(ceilf(nameLabelSize.width), ceilf(nameLabelSize.height));
    nameLabel.frame = CGRectMake(0, 0, nameLabelSize.width, nameLabelSize.height);
    nameLabel.center = CGPointMake(leftSpaceI + nameLabelSize.width * 0.5, topSpaceI + nameLabelSize.height * 0.5);
    [cell.contentView addSubview:nameLabel];
    
    UIImageView *positionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, positionImageViewSideLength, positionImageViewSideLength)];
    positionImageView.image = [UIImage imageNamed:imageString];
    positionImageView.backgroundColor = [UIColor whiteColor];
    [positionImageView.layer setMasksToBounds:YES];
    [positionImageView.layer setCornerRadius:[HAppUIModel baseWidthChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]];
    [positionImageView.layer setBorderWidth:positionImageViewBorderWidth];
    [positionImageView.layer setBorderColor:[HAppUIModel grayColor14].CGColor];
    positionImageView.center = CGPointMake(leftSpaceI + positionImageViewSideLength * 0.5, topSpaceI + nameLabelSize.height + topSpaceII + positionImageViewSideLength * 0.5);
    [cell.contentView addSubview:positionImageView];
    
    cellHeight = topSpaceI + nameLabelSize.height + topSpaceII + positionImageViewSideLength + topSpaceIII;// cell高度
    
    UILabel *indicationsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelheightI)];
    indicationsLabel.font = [HAppUIModel mediumFont4];
    indicationsLabel.textColor = [HAppUIModel grayColor6];
    indicationsLabel.text = indications;
    [indicationsLabel setTextAlignment:NSTextAlignmentLeft];
    indicationsLabel.center = CGPointMake(leftSpaceI + positionImageViewSideLength + leftSpaceII + labelWidth * 0.5, topSpaceIV + labelheightI * 0.5);
    [cell.contentView addSubview:indicationsLabel];
    
    UILabel *proposalLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpaceI + positionImageViewSideLength + leftSpaceII, topSpaceIV + labelheightI + topSpaceV, labelWidth, labelheightII)];
    proposalLabel.font = [HAppUIModel normalFont2];
    proposalLabel.textColor = [HAppUIModel grayColor3];
    [proposalLabel setTextAlignment:NSTextAlignmentLeft];
    NSMutableParagraphStyle *proposalLabelParagraphStyle = [NSMutableParagraphStyle new];
    [proposalLabelParagraphStyle setLineSpacing:[HAppUIModel baseLongChangeLength:3.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel]];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:proposal];
    [setString addAttribute:NSParagraphStyleAttributeName value:proposalLabelParagraphStyle range:NSMakeRange(0, [proposal length])];
    [proposalLabel setAttributedText:setString];
    [proposalLabel setNumberOfLines:0];
    CGSize proposalLabelSize = [proposalLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)];
    CGRect proposalLabelFrame = proposalLabel.frame;
    proposalLabelFrame.size.height = proposalLabelSize.height;
    [proposalLabel setFrame:proposalLabelFrame];
    [cell.contentView addSubview:proposalLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrowImageViewSideLength, arrowImageViewSideLength)];
    arrowImageView.image = [UIImage imageNamed:@"rightArrow"];
    arrowImageView.center = CGPointMake(SCREEN_WIDTH - rightSpace - arrowImageViewSideLength * 0.5, topSpaceVI + arrowImageViewSideLength * 0.5);
    [cell.contentView addSubview:arrowImageView];
    
    cell.backgroundColor = [HAppUIModel whiteColor4];
//    [cell setSelected:NO];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HAppUIModel baseLongChangeLength:8.0f baceWidthWithModel:ApplicationDelegate.myAppScreenModel])];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取相应数据
    NSString *selectedPosition = [NSString stringWithFormat:@"%@",[[ApplicationDelegate.positionList objectAtIndex:indexPath.section] valueForKey:@"id"]];
    NSMutableArray *selectedProtocolList = [NSMutableArray array];
    for (NSDictionary *protocolDic in ApplicationDelegate.protocolList) {
        if ([[protocolDic valueForKey:@"position"] isEqualToString:selectedPosition]) {
            [selectedProtocolList addObject:protocolDic];
        }
    }
    // 跳转页面
    HTreatment_Position_PlacementViewController *treatment_Position_PlacementVC = [HTreatment_Position_PlacementViewController new];
    treatment_Position_PlacementVC.protocolList = selectedProtocolList;
    treatment_Position_PlacementVC.navigationTitle = [NSString stringWithFormat:@"%@",[[ApplicationDelegate.positionList objectAtIndex:indexPath.section] valueForKey:@"name"]];
    treatment_Position_PlacementVC.indications = [NSString stringWithFormat:@"%@",[[ApplicationDelegate.positionList objectAtIndex:indexPath.section] valueForKey:@"indications"]];
    [self.navigationController pushViewController:treatment_Position_PlacementVC animated:YES];
    // 取消选中效果
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

#pragma mark >>> tableview滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // tableView 下位，根据偏移量计算出下位的高度
    CGFloat downHeight = -scrollView.contentOffset.y;
    NSLog(@"downHeight >>> %f",downHeight);
    // 根据下拉高度计算出 homeView 拉伸的高度
    CGRect homeViewframe = treatment_PositionView.frame;
    homeViewframe.size.height = STATUS_HEIGHT + 44 + downHeight;
    if (downHeight >= 0) {
        treatment_PositionView.frame = homeViewframe;
        if (downHeight > 20) {
            treatment_PositionTipLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, STATUS_HEIGHT + 20 + downHeight);
            treatment_PositionTipLabel.alpha = (downHeight - 20) * 0.015;
        }
    } else {
        treatment_PositionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + 44);
        treatment_PositionTipLabel.alpha = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@">>> 进入 Treatment - Position");
    self.tabBarController.tabBar.hidden = YES;
    // ———————————————————— 简易解决方法（以后会改成标准解决方法）————————————————————————————
    [treatment_PositionTableView reloadData];
    // ————————————————————————————————————————————————————————————————————————————————————
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
