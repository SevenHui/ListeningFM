//
//  XQ_RankingAnchorDetailViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_RankingAnchorDetailViewController.h"
#import "XQ_RankingModel.h"
#import "XQ_rankingAnchorDetailTableViewCell.h"
#import "XQ_AnchorDetailViewController.h"

@interface XQ_RankingAnchorDetailViewController ()
<UITableViewDataSource, UITableViewDelegate>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**数据数组*/
@property (nonatomic, retain) NSMutableArray *arrDataSource;
/**页数*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation XQ_RankingAnchorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.arrDataSource = [NSMutableArray array];

    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    self.navigationItem.title = _model.title;

    [self createNavigation];
    
    [self getDataFromJson:1];
    
    [self createTableView];
    

    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self.tableView registerClass:[XQ_rankingAnchorDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getUpData];
        [_tableView.mj_header endRefreshing];
        
    }];
    // 上拉加载
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getDownData];
        [_tableView.mj_footer endRefreshing];
        
    }];

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XQ_rankingAnchorDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _arrDataSource[indexPath.row];
    cell.number = indexPath.row + 1;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AnchorDetailViewController *anchorDetailVC = [[XQ_AnchorDetailViewController alloc] init];
    anchorDetailVC.model = [_arrDataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
    
}
#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrDataSource removeAllObjects];
    [self getDataFromJson:1];
    [_tableView reloadData];
}
#pragma mark - 上拉加载
- (void)getDownData {
    _page++;
    [self getDataFromJson:_page];
    
}

- (void)getDataFromJson:(NSInteger)page {
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/anchor?device=android&key=%@&pageId=%ld&pageSize=20&statPosition=15",_model.key,page];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"rankingAnchor" WithPath:@"rankingAnchor.plist"];
        
        
        NSMutableArray *arrList = dic[@"list"];
        for (NSDictionary *dic in arrList) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_arrDataSource addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"rankingAnchor" WithPath:@"rankingAnchor.plist"];
        
        
        NSMutableArray *arrList = dic[@"list"];
        for (NSDictionary *dic in arrList) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_arrDataSource addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        
    }];
    
    
}



@end
