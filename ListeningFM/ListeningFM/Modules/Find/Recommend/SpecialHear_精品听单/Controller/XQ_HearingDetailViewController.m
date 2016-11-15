//
//  XQ_HearingDetailViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HearingDetailViewController.h"
#import "XQ_SmallEditorModel.h"
#import "XQ_HeaderDetailView.h"
#import "XQ_HeaderDetailTableViewCell.h"
#import "XQ_SmallEditorMoreTableViewCell.h"

@interface XQ_HearingDetailViewController ()
<UITableViewDelegate,UITableViewDataSource>
/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**头视图*/
@property (nonatomic, retain) XQ_HeaderDetailView *headerView;
/**头视图字典*/
@property (nonatomic, retain) NSDictionary *headDic;
/**数据源数组*/
@property (nonatomic, retain) NSMutableArray *dataSource;

@end

@implementation XQ_HearingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"听单详情";
    self.dataSource  =[NSMutableArray array];
    self.headDic = [NSDictionary dictionary];
    
    [self createNavigation];
    
    [self getDataFromJson];
    [self createTableView];

    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    _tableView.rowHeight = 100;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headerView = [[XQ_HeaderDetailView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.35)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];

    [self.tableView registerClass:[XQ_SmallEditorMoreTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQ_SmallEditorMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - 跳转播放界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
    albumVC.model = _dataSource[indexPath.row];
    [self.navigationController pushViewController:albumVC animated:YES];
    
}
- (void)getDataFromJson {
    [_dataSource removeAllObjects];
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_detail?device=android&id=%@&statPosition=1", _model.specialId];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"speciaDetail" WithPath:@"speciaDetail.plist"];
        
        
        self.headDic = [dic objectForKey:@"info"];
        _headerView.ditionary = _headDic;
        
        NSArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dic in listarray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_dataSource addObject:model];
        }

        [_tableView reloadData];
        
 
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"speciaDetail" WithPath:@"speciaDetail.plist"];
        
        
        self.headDic = [dic objectForKey:@"info"];
        _headerView.ditionary = _headDic;
        
        NSArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dic in listarray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_dataSource addObject:model];
        }
        
        [_tableView reloadData];

        
    }];
    
    
    
}








@end
