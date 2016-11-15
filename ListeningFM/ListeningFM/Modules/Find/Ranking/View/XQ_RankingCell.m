//
//  XQ_RankingCell.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_RankingCell.h"
#import "XQ_RankingModel.h"
#import "XQ_RankingTableViewCell.h"
// 主播榜单详情
#import "XQ_RankingAnchorDetailViewController.h"
// 节目榜单详情
#import "XQ_RankingProgramDetailViewController.h"

@interface XQ_RankingCell ()
<UITableViewDataSource, UITableViewDelegate>

/**主界面视图*/
@property(nonatomic, retain) UITableView *tableView;
/**头视图图片*/
@property(nonatomic, retain) UIImageView *headerViewImage;
/**头视图详情数据*/
@property (nonatomic, retain) NSString *strHeaderViewDetailUrl;
/**节目榜单数据*/
@property(nonatomic, retain) NSMutableArray *arrProgramRanking;
/**节目榜单头标题*/
@property(nonatomic, retain) NSString *strProgramRanking;
/**主播榜单头标题*/
@property (nonatomic, retain) NSMutableArray *arrAnchorRanking;
/**主播榜单头标题*/
@property (nonatomic, retain) NSString *strAnchorRanking;

@end

@implementation XQ_RankingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrProgramRanking = [NSMutableArray array];
        self.arrAnchorRanking = [NSMutableArray array];
        [self getDataFromJsonOfRanking];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100 * lfheight;
    [self addSubview:_tableView];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;

    // 注册节目榜单cell
    [_tableView registerClass:[XQ_RankingTableViewCell class] forCellReuseIdentifier:@"programRankingCell"];
    // 注册主播榜单cell
    [_tableView registerClass:[XQ_RankingTableViewCell class] forCellReuseIdentifier:@"anchorRankingCell"];

    [self createHeaderView];
    
    
}

#pragma mark - 头视图
- (void)createHeaderView {
    self.headerViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.28)];
    _headerViewImage.backgroundColor = [UIColor whiteColor];
    _headerViewImage.image = [UIImage imageNamed:@"live_btn_image"];
    _tableView.tableHeaderView = _headerViewImage;
    
}

#pragma mark - 分区头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WIDTHSCREEN * 0.15;
}
#pragma mark - 自定义分区头标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, WIDTHSCREEN * 0.15)];
    view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    // 分界面
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, view.bounds.size.height * 0.25, WIDTHSCREEN, view.bounds.size.height * 0.75)];
    lineView.backgroundColor = [UIColor whiteColor];
    [view addSubview:lineView];
    // 三角
    UIImageView *imageViewAngle = [[UIImageView alloc] initWithFrame:CGRectMake(lineView.bounds.size.width * 0.02, lineView.bounds.size.height * 0.3, lineView.bounds.size.width * 0.04, lineView.bounds.size.height * 0.4)];
    imageViewAngle.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [lineView addSubview:imageViewAngle];
    // 分区标题
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageViewAngle.bounds.size.width * 2, lineView.bounds.size.height * 0.2, imageViewAngle.bounds.size.width * 7, lineView.bounds.size.height * 0.6)];
    [lineView addSubview:labelTitle];
    // 节目榜单
    if (section == 0) {
        labelTitle.text = _strProgramRanking;
    }
    // 主播榜单
    else if (section == 1) {
        labelTitle.text = _strAnchorRanking;
    }
    


    return view;
    
}

#pragma mark - 分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}
#pragma mark - Cell的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 节目榜单
    if (section == 0) {
        return _arrProgramRanking.count;
    }
    // 主播榜单
    return _arrAnchorRanking.count;
    
}
#pragma mark - Cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 节目榜单
    if (indexPath.section == 0) {
        XQ_RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programRankingCell"];
        
        if (_arrProgramRanking.count != 0) {
            cell.rankingModel = _arrProgramRanking[indexPath.row];
        }
        
        return cell;
    }
    // 主播榜单
    XQ_RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"anchorRankingCell"];

    if (_arrAnchorRanking.count != 0) {
        cell.rankingModel = _arrAnchorRanking[indexPath.row];
    }
    
    return cell;
    
}
#pragma mark - 跳转详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 节目
    if (indexPath.section == 0) {
        XQ_RankingProgramDetailViewController *programDetailVC = [[XQ_RankingProgramDetailViewController alloc] init];
        programDetailVC.model = _arrProgramRanking[indexPath.row];
        [[self naviController] pushViewController:programDetailVC animated:YES];
    }
    // 排行榜
    if (indexPath.section == 1) {
        XQ_RankingAnchorDetailViewController *anchorDetailVC = [[XQ_RankingAnchorDetailViewController alloc] init];
        anchorDetailVC.model = _arrAnchorRanking[indexPath.row];
        [[self naviController] pushViewController:anchorDetailVC animated:YES];
    }
    
    
    
}

#pragma mark - 榜单数据
- (void)getDataFromJsonOfRanking {
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.33";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"ranking" WithPath:@"ranking.plist"];
        
        
        //  头视图数据
        NSDictionary *dicFocusImages = dic[@"focusImages"];
        NSMutableArray *arrList = dicFocusImages[@"list"];
        NSDictionary *dicHeaderView = arrList[0];
        [_headerViewImage sd_setImageWithURL:[NSURL URLWithString:dicHeaderView[@"pic"]]];
        _strHeaderViewDetailUrl = dicHeaderView[@"url"];
        // 分区数据
        NSMutableArray *arrDatas = dic[@"datas"];
        // 头标题
        NSDictionary *dicProgramRanking = arrDatas[0];
        _strProgramRanking = dicProgramRanking[@"title"];
        NSDictionary *dicAnchorRanking = arrDatas[1];
        _strAnchorRanking = dicAnchorRanking[@"title"];
        // 节目榜单数据
        NSMutableArray *arrProgramRankingList = dicProgramRanking[@"list"];
        for (NSDictionary *dic in arrProgramRankingList) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_arrProgramRanking addObject:model];
        }
        // 主播榜单数据
        NSMutableArray *arrAnchorRankingList = dicAnchorRanking[@"list"];
        for (NSDictionary *dic in arrAnchorRankingList) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_arrAnchorRanking addObject:model];
        }
        
        [_tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"ranking" WithPath:@"ranking.plist"];
        
        
        //  头视图数据
        NSDictionary *dicFocusImages = dic[@"focusImages"];
        NSMutableArray *arrList = dicFocusImages[@"list"];
        NSDictionary *dicHeaderView = arrList[0];
        [_headerViewImage sd_setImageWithURL:[NSURL URLWithString:dicHeaderView[@"pic"]]];
        _strHeaderViewDetailUrl = dicHeaderView[@"url"];
        // 分区数据
        NSMutableArray *arrDatas = dic[@"datas"];
        // 头标题
        NSDictionary *dicProgramRanking = arrDatas[0];
        _strProgramRanking = dicProgramRanking[@"title"];
        NSDictionary *dicAnchorRanking = arrDatas[1];
        _strAnchorRanking = dicAnchorRanking[@"title"];
        // 节目榜单数据
        NSMutableArray *arrProgramRankingList = dicProgramRanking[@"list"];
        for (NSDictionary *dic in arrProgramRankingList) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_arrProgramRanking addObject:model];
        }
        // 主播榜单数据
        NSMutableArray *arrAnchorRankingList = dicAnchorRanking[@"list"];
        for (NSDictionary *dic in arrAnchorRankingList) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_arrAnchorRanking addObject:model];
        }
        
        [_tableView reloadData];

        
    }];
    
}

#pragma mark - 当前控制器的导航控制器
- (UINavigationController *)naviController {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}



@end
