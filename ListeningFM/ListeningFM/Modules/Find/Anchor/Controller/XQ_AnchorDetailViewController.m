//
//  XQ_AnchorDetailViewController.m
//  ListeningFM
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AnchorDetailViewController.h"
#import "XQ_AnchorDetailTableViewCell.h"
#import "XQ_AnchorDetailModel.h"

@interface XQ_AnchorDetailViewController ()
<UITableViewDataSource, UITableViewDelegate>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**头视图*/
@property (nonatomic, retain) UIImageView *headerImageView;
/**页数*/
@property (nonatomic, assign) NSInteger page;
/**数据*/
@property (nonatomic, retain) NSMutableArray *arrDetailModel;
/**声音数*/
@property (nonatomic, retain) NSNumber *totalCount;

@end

@implementation XQ_AnchorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    self.arrDetailModel = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    [self getDataFromJson:1];

    [self createTableView];
    
    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100 * lfheight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[XQ_AnchorDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self createHeaderView];
    
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
#pragma mark - 头视图自定义布局
- (void)createHeaderView {
    // 背景图片
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.35)];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.middleLogo] placeholderImage:[UIImage imageNamed:@"me_bg2"]];
    _tableView.tableHeaderView = _headerImageView;
    // 毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.frame = _headerImageView.bounds;
    [_headerImageView addSubview:toolBar];
    // 图片
    UIImageView *imageViewLoge = [[UIImageView alloc] initWithFrame:CGRectMake(_headerImageView.bounds.size.width * 0.35, _headerImageView.bounds.size.height * 0.2, _headerImageView.bounds.size.width * 0.3, _headerImageView.bounds.size.height * 0.4)];
    [imageViewLoge sd_setImageWithURL:[NSURL URLWithString:_model.middleLogo] placeholderImage:[UIImage imageNamed:@"me"]];
    [_headerImageView addSubview:imageViewLoge];
    _headerImageView.userInteractionEnabled = YES;
    // 人物
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(_headerImageView.bounds.size.width * 0.1, _headerImageView.bounds.size.height * 0.65, _headerImageView.bounds.size.width * 0.8, _headerImageView.bounds.size.height * 0.15)];
    labelTitle.text = _model.nickname;
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:20];
    [_headerImageView addSubview:labelTitle];
    // 人物介绍
    UILabel *labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle.frame.origin.x, labelTitle.frame.size.height * 1.2 + labelTitle.frame.origin.y, labelTitle.frame.size.width, labelTitle.frame.size.height * 0.5)];
    labelSubTitle.text = _model.verifyTitle;
    labelSubTitle.textAlignment = NSTextAlignmentCenter;
    labelSubTitle.textColor = [UIColor whiteColor];
    labelSubTitle.font = [UIFont systemFontOfSize:16];
    [_headerImageView addSubview:labelSubTitle];
    // 返回按钮
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    btnBack.frame = CGRectMake(_headerImageView.bounds.size.width * 0.03, _headerImageView.bounds.size.height * 0.13, _headerImageView.bounds.size.width * 0.05, _headerImageView.bounds.size.height * 0.08);
    [_headerImageView addSubview:btnBack];
    [btnBack addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)backAction:(UIButton *)sender {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 自定义分区头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WIDTHSCREEN * 0.11;
}
#pragma mark - 自定义分区头标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, WIDTHSCREEN * 0.11)];
    view.backgroundColor = [UIColor whiteColor];
    // 分区标题
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 0.02, view.bounds.size.height * 0.2, view.bounds.size.width * 0.2, view.bounds.size.height * 0.6)];
    labelTitle.text = [NSString stringWithFormat:@"声音(%@)",_totalCount];
    [view addSubview:labelTitle];
    

    return view;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrDetailModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AnchorDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_arrDetailModel.count != 0) {
        cell.model = _arrDetailModel[indexPath.row];
    }
    
    return cell;
}
#pragma mark - 跳转播放界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AudioPlayVC *audioPlauVC = [XQ_AudioPlayVC shareDetailViewController];
    audioPlauVC.model = [_arrDetailModel objectAtIndex:indexPath.row];
    audioPlauVC.musicArr = _arrDetailModel;
    audioPlauVC.index = indexPath.row;
    [self presentViewController:audioPlauVC animated:YES completion:nil];
    // 通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[_arrDetailModel  objectAtIndex:indexPath.row] coverMiddle]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
}

#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrDetailModel removeAllObjects];
    [self getDataFromJson:1];
    [_tableView reloadData];
}
#pragma mark - 上拉加载
- (void)getDownData {
    _page++;
    [self getDataFromJson:_page];
    
}
#pragma mark - 详情数据
- (void)getDataFromJson:(NSInteger)page {
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/artist/tracks?device=android&pageId=%ld&toUid=%ld&track_base_url=http://mobile.ximalaya.com/mobile/v1/artist/tracks",_page,[_model.uid integerValue]];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"anchorDet" WithPath:@"anchorDet.plist"];
        
        
        _totalCount = dic[@"totalCount"];
        NSMutableArray *array = dic[@"list"];
        for (NSDictionary *dic in array) {
            XQ_AnchorDetailModel *model = [[XQ_AnchorDetailModel alloc] initWithDic:dic];
            [_arrDetailModel addObject:model];

        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"anchorDet" WithPath:@"anchorDet.plist"];
        
        
        _totalCount = dic[@"totalCount"];
        NSMutableArray *array = dic[@"list"];
        for (NSDictionary *dic in array) {
            XQ_AnchorDetailModel *model = [[XQ_AnchorDetailModel alloc] initWithDic:dic];
            [_arrDetailModel addObject:model];
            
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        
    }];
    
    
    
}
















@end
