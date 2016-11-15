//
//  XQ_SubVC.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SubVC.h"
#import "XQ_SmallEditorMoreTableViewCell.h"
#import "XQ_ZeroTableViewCell.h"
#import "XQ_SmallEditorModel.h"
#import "SDImageCache.h"
#import "XQ_SubRecommendViewController.h"

@interface XQ_SubVC ()
<UITableViewDataSource, UITableViewDelegate>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**数据数组*/
@property (nonatomic, retain) NSMutableArray *dataSource;
/**弹框*/
@property(nonatomic,retain)UIAlertController *alertController;

@end

@implementation XQ_SubVC

+ (UINavigationController *)defaultSubscibeViewUINavigationController{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        XQ_SubVC *sub = [[XQ_SubVC alloc] init];
        navi = [[UINavigationController alloc] initWithRootViewController:sub];
        
    });
    return navi;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订阅";
    [self createTableView];
    [self config];
    
    
}
- (void)config {
    // 偶的推荐
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(subRecommendAction)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];


    
}
- (void)subRecommendAction {
    XQ_SubRecommendViewController *subRecommendVC = [[XQ_SubRecommendViewController alloc] init];
    [self.navigationController pushViewController:subRecommendVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)getData {
    XQ_SQLiteTool *dataTool = [XQ_SQLiteTool shareInstance];
    // 查询所有收藏
    self.dataSource = (NSMutableArray *)[dataTool selectAll];
    [_tableView reloadData];
    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    // 数组有值
    [_tableView registerClass:[XQ_SmallEditorMoreTableViewCell class] forCellReuseIdentifier:@"cell"];
    // 数组没值
    [_tableView registerClass:[XQ_ZeroTableViewCell class] forCellReuseIdentifier:@"zeroCell"];
    
    
    [self getData];
    
    // 下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
        [_tableView.mj_header endRefreshing];
        
    }];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource.count != 0) {
        return _dataSource.count;
    } else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSource.count != 0) {
        return 100 * lfheight;
    } else {
        return HEIGHTSCREEN;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 数组有值
    if (_dataSource.count != 0) {
        XQ_SmallEditorMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = _dataSource[indexPath.row];
        return cell;
    }
    // 数组没值
    else {
        XQ_ZeroTableViewCell *zeroCell = [tableView dequeueReusableCellWithIdentifier:@"zeroCell"];
        zeroCell.selectionStyle = UITableViewCellSelectionStyleNone;
        zeroCell.backimageView.image = [UIImage imageNamed:@"noData_subscription"];
        return zeroCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataSource.count != 0) {
        XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
        albumVC.model = _dataSource[indexPath.row];
        [self.navigationController pushViewController:albumVC animated:YES];
        
    }
    
}

#pragma mark - 编辑事件[1]
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    // 使tableView处于一个编辑状态
    [_tableView setEditing:editing animated:animated];
}
#pragma mark - 是否被编辑[2]
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - 返回被编辑的样式[3]
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewCellEditingStyleDelete;
}
#pragma mark - 提交编辑操作[4]
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        XQ_SQLiteTool *dataTool = [XQ_SQLiteTool shareInstance];
        XQ_SmallEditorModel *model = _dataSource[indexPath.row];
        
        [dataTool deleteDataWithModel:model.albumId];
        [_dataSource removeObjectAtIndex:indexPath.row];
        
        // 弹框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"删除订阅" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        self.alertController = alertController;
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [self.alertController addAction:defaultAction];
        
        [_tableView reloadData];
        
    }
    
}


@end
