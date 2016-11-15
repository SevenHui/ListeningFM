//
//  XQ_LiveCategoriesDetailViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveCategoriesDetailViewController.h"
#import "XQ_LiveCategoriesModel.h"
#import "XQ_LiveTableViewCell.h"
#import "XQ_LiveRadiosModel.h"


@interface XQ_LiveCategoriesDetailViewController ()
<UITableViewDataSource, UITableViewDelegate>

/**主界面视图*/
@property (nonatomic, retain) UITableView *tableView;
/**更多数据*/
@property (nonatomic, retain) NSMutableArray *arrMore;
/**页数*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation XQ_LiveCategoriesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    
    self.navigationItem.title = _model.name;
    
    [self createNavigation];
    
    self.arrMore = [NSMutableArray array];
    
    [self getDataFromJsonOfDetail:1];
    
    [self createTableView];
    

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 120;
    
    [_tableView registerClass:[XQ_LiveTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    return _arrMore.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XQ_LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_arrMore.count != 0) {
        
        cell.liveRadiosModel = _arrMore[indexPath.row];
        
    }
    
    return cell;
    
}
#pragma mark - 跳转播放界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    XQ_AudioPlayVC *audioPlauVC = [XQ_AudioPlayVC shareDetailViewController];
    audioPlauVC.model = [_arrMore objectAtIndex:indexPath.row];
    audioPlauVC.musicArr = _arrMore;
    audioPlauVC.index = indexPath.row;
    [self presentViewController:audioPlauVC animated:YES completion:nil];
    // 通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[_arrMore  objectAtIndex:indexPath.row] coverMiddle]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    
}

#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrMore removeAllObjects];
    [_tableView reloadData];
    [self getDataFromJsonOfDetail :1];
}
#pragma mark - 上拉加载
- (void)getDownData {
    _page++;
    [self getDataFromJsonOfDetail:_page];
    
}

#pragma mark - 更多数据
- (void)getDataFromJsonOfDetail:(NSInteger)page {
    NSString *string = [NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v2/radio/category?categoryId=%ld&pageNum=%ld&pageSize=20",[_model.ID integerValue],page];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"liveDetail" WithPath:@"liveDetail.plist"];
        
        
        NSDictionary *dict = dic[@"data"];
        NSMutableArray *arrData = dict[@"data"];
        for (NSDictionary *dic in arrData) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_arrMore addObject:model];
        }
        
        [_tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"liveDetail" WithPath:@"liveDetail.plist"];
        
        
        NSDictionary *dict = dic[@"data"];
        NSMutableArray *arrData = dict[@"data"];
        for (NSDictionary *dic in arrData) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_arrMore addObject:model];
        }
        
        [_tableView reloadData];

        
    }];
    
    
}


@end
