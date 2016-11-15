//
//  XQ_SmallEditorViewController.m
//  ListeningFM
//
//  Created by apple on 16/9/24.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SmallEditorViewController.h"
#import "XQ_SmallEditorModel.h"
#import "XQ_SmallEditorMoreTableViewCell.h"

@interface XQ_SmallEditorViewController ()
<UITableViewDataSource, UITableViewDelegate>

/**主界面*/
@property (nonatomic, retain) UITableView *tableView;
/**小编推荐更多数据*/
@property (nonatomic, retain) NSMutableArray *arrSmallEditorMore;
/**页数*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation XQ_SmallEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据页数默认值为一页
    self.page = 1;
    self.arrSmallEditorMore = [NSMutableArray array];
    
    [self createNavigation];
    
    self.navigationItem.title = _strTitle;
    
    [self getDataFromJsonOfMore:1];
    
    [self createTableView];
    
    

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 120;
    
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
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrSmallEditorMore.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XQ_SmallEditorMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_arrSmallEditorMore.count != 0) {
        
        cell.model = _arrSmallEditorMore[indexPath.row];
        
    }
    
    return cell;
    
}
#pragma mark - 跳转专辑详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
        albumVC.model = _arrSmallEditorMore[indexPath.row];
        [self.navigationController pushViewController:albumVC animated:YES];
}


#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrSmallEditorMore removeAllObjects];
    [self getDataFromJsonOfMore:1];
    [_tableView reloadData];
}
#pragma mark - 上拉加载
- (void)getDownData {
    _page++;
    [self getDataFromJsonOfMore:_page];
}

#pragma mark - 小编推荐更多
- (void)getDataFromJsonOfMore:(NSInteger)page {
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/recommend/editor?device=android&pageId=%ld&pageSize=20", page];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        [XQArchiverTool archiverObject:dic ByKey:@"smallEditorMore" WithPath:@"smallEditorMore.plist"];
        
        NSMutableArray *arrMoreList = dic[@"list"];
        for (NSDictionary *dic in arrMoreList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrSmallEditorMore addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"smallEditorMore" WithPath:@"smallEditorMore.plist"];

        
        NSMutableArray *arrMoreList = dic[@"list"];
        for (NSDictionary *dic in arrMoreList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrSmallEditorMore addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        
        
    }];
    
    
}




@end
