//
//  XQ_AlbumDetailViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AlbumDetailViewController.h"
#import "XQ_SmallEditorModel.h"
// 内容简介
#import "XQ_ContentIntroTableViewCell.h"
// 主播介绍
#import "XQ_AnchorIntroduceTableViewCell.h"
#import "XQ_AnchorIntroduceModel.h"
// 节目
#import "XQ_ParticularsTableViewCell.h"

@interface XQ_AlbumDetailViewController ()
<UITableViewDataSource, UITableViewDelegate>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**头视图*/
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *coverMiddleImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *playTimesLabel;
/**订阅按钮*/
@property (nonatomic, retain) UIButton *readButton;
/**内容简介*/
@property (nonatomic, retain) NSString *contentString;
/**主播介绍数据源*/
@property (nonatomic, retain) NSMutableArray *anchorDatasource;
/**监听变量*/
@property (nonatomic, assign) BOOL isClick;
/**节目*/
@property (nonatomic, retain) NSMutableArray *programArray;
/**页数*/
@property (nonatomic, assign) NSInteger pageNumber;
/**收藏按钮监听变量*/
@property (nonatomic, assign) BOOL isCollected;
/**弹框*/
@property(nonatomic,retain)UIAlertController *alertController;

@end

@implementation XQ_AlbumDetailViewController

- (void)viewWillAppear:(BOOL)animated{

    // 数据库收藏
    XQ_SQLiteTool *dataBase = [[XQ_SQLiteTool alloc] init];
    self.isCollected = [dataBase isCollectedInTableadS:_model.albumId];
    [self getData];
    [self getDetailData];
    
    XQ_SQLiteTool *data = [[XQ_SQLiteTool alloc] init];
    BOOL YON = [data isCollectedInTableadS:_model.albumId];
    if (YON) {
        // 订阅
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
    }
    else {
        // 取消订阅
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
        
    }
    [_tableView reloadData];
    
}
- (void)didClickedRightBarButtonItem:(UIBarButtonItem *)barbutton{
    if (!self.isCollected){
        XQ_SQLiteTool *dataTool = [XQ_SQLiteTool shareInstance];
        // 插入model
        [dataTool insert:self.model];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
        
        // 弹框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"订阅成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        self.alertController = alertController;
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [self.alertController addAction:cancelAction];
        
        self.isCollected = YES;
        
    }
    else {
        XQ_SQLiteTool *dataTool = [XQ_SQLiteTool shareInstance];
        // 删除ID
        [dataTool deleteDataWithModel:self.model.albumId];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
        self.isCollected = NO;
        // 弹框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"订阅取消" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        self.alertController = alertController;
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [self.alertController addAction:defaultAction];
        
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageNumber = 1;
    self.anchorDatasource = [NSMutableArray array];
    self.programArray = [NSMutableArray array];
    
    self.navigationItem.title = @"专辑详情";
    
    [self createNavigation];
    
    [self getData];
    [self getDetailData];
    [self getData:1];

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.25)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self createHeaderView];
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    // 内容简介
    [_tableView registerClass:[XQ_ContentIntroTableViewCell class] forCellReuseIdentifier:@"cell"];
    // 主播介绍
    [_tableView registerClass:[XQ_AnchorIntroduceTableViewCell class] forCellReuseIdentifier:@"anchorCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    // 节目
    [_tableView registerClass:[XQ_ParticularsTableViewCell class] forCellReuseIdentifier:@"particularsCell"];

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
#pragma mark - 头视图
- (void)createHeaderView{
    // 封面
    self.coverMiddleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_headerView.bounds.size.width * 0.05, _headerView.bounds.size.height * 0.1, _headerView.bounds.size.width * 0.27, _headerView.bounds.size.width * 0.27)];
    [_headerView addSubview:_coverMiddleImageView];
    // 标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coverMiddleImageView.frame.origin.x * 2 + _coverMiddleImageView.frame.size.width, _coverMiddleImageView.frame.origin.y, _coverMiddleImageView.frame.size.width * 2, _coverMiddleImageView.frame.size.width * 0.3)];
    [_headerView addSubview:_titleLabel];
    // 主播
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, self.titleLabel.frame.origin.y * 1.2 + self.titleLabel.frame.size.height, _titleLabel.frame.size.width, _titleLabel.frame.size.height * 0.7)];
    _nicknameLabel.textColor = [UIColor grayColor];
    _nicknameLabel.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:_nicknameLabel];
    // 播放
    self.playTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLabel.frame.origin.x, _nicknameLabel.frame.origin.y * 1.05 + _nicknameLabel.frame.size.height, _nicknameLabel.frame.size.width, _nicknameLabel.frame.size.height)];
    _playTimesLabel.textColor = [UIColor grayColor];
    _playTimesLabel.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:_playTimesLabel];
    
    
}
#pragma mark - 自定义分区头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WIDTHSCREEN * 0.1;
}
#pragma mark - 自定义分区头标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, WIDTHSCREEN * 0.1)];
        // 详情
        UIButton *buttonDetail = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonDetail.frame = CGRectMake(0, 0, headerView.bounds.size.width * 0.5, headerView.bounds.size.height);
        [buttonDetail setTitle:@"详情" forState:UIControlStateNormal];
        buttonDetail.titleLabel.textAlignment = 1;
        buttonDetail.titleLabel.font = [UIFont systemFontOfSize:19];
        [buttonDetail addTarget:self action:@selector(didClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:buttonDetail];
        // 节目
        UIButton *buttonProgram =[UIButton buttonWithType:UIButtonTypeSystem];
        buttonProgram.frame = CGRectMake(headerView.bounds.size.width * 0.5, 0, headerView.bounds.size.width * 0.5, headerView.bounds.size.height);
        [buttonProgram setTitle:@"节目" forState:UIControlStateNormal];
        buttonProgram.titleLabel.textAlignment = 1;
        buttonProgram.titleLabel.font = [UIFont systemFontOfSize:19];
        [buttonProgram addTarget:self action:@selector(didClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:buttonProgram];
        
        
        if (self.isClick == NO) {
            
            [buttonProgram setTintColor:[UIColor redColor]];
        }
        else {
            [buttonDetail setTintColor:[UIColor redColor]];
        }
        return headerView;
        
    }
    return nil;
    
}
- (void)didClickedButton:(UIButton *)buttonOne{
    if ([buttonOne.titleLabel.text isEqualToString:@"节目"]) {
        self.isClick = NO;
    }
    else{
        self.isClick = YES;
    }
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isClick == NO) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isClick == NO) {
        return _programArray.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isClick == NO) {
        return 120 * lfheight;
    }
    if (indexPath.section == 0) {
        return 100 * lfheight;
    }
    else {
        return 150 * lfheight;
    }

    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isClick == YES) {
        // 内容简介
        if (indexPath.section == 0) {
            XQ_ContentIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.introLabel.text = _contentString;
            return cell;
        }
        // 主播介绍
        if (indexPath.section == 1) {
            XQ_AnchorIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"anchorCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_anchorDatasource.count != 0) {
                cell.model = [_anchorDatasource objectAtIndex:indexPath.row];
                
            }
            return cell;
        }
    }
    else {
        // 节目
        XQ_ParticularsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"particularsCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        if (_programArray.count != 0) {
            cell.model = [_programArray objectAtIndex:indexPath.row];
        }
        
        return cell;
        
    }
    return nil;

}
#pragma mark - 跳转播放界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isClick == NO) {
        
    XQ_AudioPlayVC *audioPlauVC = [XQ_AudioPlayVC shareDetailViewController];
    audioPlauVC.model = [_programArray objectAtIndex:indexPath.row];
    audioPlauVC.musicArr = _programArray;
    audioPlauVC.index = indexPath.row;
    [self presentViewController:audioPlauVC animated:YES completion:nil];
        
    // 通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[_programArray objectAtIndex:indexPath.row] coverMiddle]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    }
    
}
#pragma mark - 下拉刷新
- (void)getUpData {
    [_anchorDatasource removeAllObjects];
    [_programArray removeAllObjects];
    [self getData];
    [self getDetailData];
    [self getData:1];
    [_tableView reloadData];
}
#pragma mark - 上拉加载
- (void)getDownData {
    _pageNumber++;
    [self getData:_pageNumber];
}

#pragma mark - 头视图数据
- (void)getData {
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album?albumId=%ld&device=android&isAsc=true&pageId=%ld&pageSize=20&pre_page=0&source=0&statPosition=1",_model.albumId,_pageNumber];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSDictionary *albumDic = [dataDic objectForKey:@"album"];
        [_coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:[albumDic objectForKey:@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"me"]];
        _titleLabel.text = [albumDic objectForKey:@"title"];
        if ([albumDic objectForKey:@"nickname"] != nil) {
            _nicknameLabel.text = [NSString stringWithFormat:@"主播: %@",[albumDic objectForKey:@"nickname"]];
        }
        if ([albumDic objectForKey:@"playTimes"] != nil) {
            _playTimesLabel.text = [NSString stringWithFormat:@"播放: %.2f万次",[[albumDic objectForKey:@"playTimes"] floatValue] / 100000];
        }
        
        NSDictionary *tracksDic = [dataDic objectForKey:@"tracks"];
        NSMutableArray *liArray = [tracksDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:liDic];
            [_programArray addObject:model];
            
        }
        
        [_tableView reloadData];

    } Failure:^(NSError *error) {
        
        
        
    }];
    
}

#pragma mark - 节目数据
- (void)getData:(NSInteger)pageNumber {
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album/track?albumId=%ld&device=android&isAsc=true&pageId=%ld&pageSize=20&statPosition=2",_model.albumId ,pageNumber];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"album" WithPath:@"album.plist"];
        
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSMutableArray *liArray = [dataDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:liDic];
            [_programArray addObject:model];
            
        }

        [_tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"album" WithPath:@"album.plist"];
        
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSMutableArray *liArray = [dataDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:liDic];
            [_programArray addObject:model];
            
        }
        
        [_tableView reloadData];

        
    }];
    
    
}

#pragma mark - 详情数据
- (void)getDetailData{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album/detail?albumId=%ld&device=android&statPosition=1",_model.albumId];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"albumDetail" WithPath:@"albumDetail.plist"];
        
        
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSDictionary *diction = [dict objectForKey:@"detail"];
        self.contentString = [diction objectForKey:@"intro"];
        NSDictionary *anchorDic = [dict objectForKey:@"user"];
        XQ_AnchorIntroduceModel *anchorModel = [[XQ_AnchorIntroduceModel alloc] initWithDic:anchorDic];
        [_anchorDatasource addObject:anchorModel];
        
        [_tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"albumDetail" WithPath:@"albumDetail.plist"];
        
        
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSDictionary *diction = [dict objectForKey:@"detail"];
        self.contentString = [diction objectForKey:@"intro"];
        NSDictionary *anchorDic = [dict objectForKey:@"user"];
        XQ_AnchorIntroduceModel *anchorModel = [[XQ_AnchorIntroduceModel alloc] initWithDic:anchorDic];
        [_anchorDatasource addObject:anchorModel];
        
        [_tableView reloadData];

        
    }];
    
}










@end
