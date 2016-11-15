//
//  XQ_SubRecommendViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SubRecommendViewController.h"
#import "XQ_SmallEditorModel.h"
#import "XQ_SmallEditorMoreTableViewCell.h"

@interface XQ_SubRecommendViewController ()
<UITableViewDataSource, UITableViewDelegate>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**数据数组*/
@property (nonatomic, retain) NSMutableArray *arrData;
/**页数*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation XQ_SubRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的推荐";
    [self createNavigation];
    [self createTableView];
    


}
#pragma mark - 自定义导航栏返回按钮
- (void)createNavigation {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
}
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView {
    self.page = 1;
    self.arrData = [NSMutableArray array];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 100 * lfheight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[XQ_SmallEditorMoreTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    [self getData:1];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQ_SmallEditorMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_arrData.count != 0) {
        cell.model = _arrData[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
    albumVC.model = _arrData[indexPath.row];
    [self.navigationController pushViewController:albumVC animated:YES];
}

#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrData removeAllObjects];
    [self getData:1];
    [_tableView reloadData];
}
#pragma mark - 上拉加载
- (void)getDownData {
    _page++;
    [self getData:_page];
}

#pragma mark - 数据
- (void)getData:(NSInteger)page {
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/feed/v1/recommend/classic/unlogin?device=android&pageId=%ld&pageSize=20", _page];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"subRecom" WithPath:@"subRecom.plist"];
        
        
        NSDictionary *dicData = dic[@"data"];
        NSMutableArray *arrList = dicData[@"list"];
        for (NSDictionary *dic in arrList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrData addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"subRecom" WithPath:@"subRecom.plist"];
        
        
        NSDictionary *dicData = dic[@"data"];
        NSMutableArray *arrList = dicData[@"list"];
        for (NSDictionary *dic in arrList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrData addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        
    }];
    
    
}


@end
