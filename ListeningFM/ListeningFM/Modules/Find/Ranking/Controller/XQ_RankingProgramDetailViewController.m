//
//  XQ_RankingProgramDetailViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_RankingProgramDetailViewController.h"
#import "XQ_RankingModel.h"
#import "XQ_TopProgramDetailCollectionViewCell.h"
#import "XQ_MainProgramDetailCollectionViewCell.h"
#import "XQ_SmallEditorModel.h"
#import "XQ_TwoProgramDetailTableViewCell.h"
#import "XQ_ThreeProgramDetailTableViewCell.h"
#import "XQ_AlbumDetailViewController.h"

@interface XQ_RankingProgramDetailViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource
>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**顶部视图*/
@property (nonatomic, retain) UICollectionView *topCollectionView;
/**切换视图*/
@property (nonatomic, retain) UICollectionView *mainCollectionView;
/**顶部数据*/
@property (nonatomic, retain) NSMutableArray *topArray;
/**主数据*/
@property (nonatomic, retain) NSMutableArray *mainArray;
/**最火节目数据源*/
@property (nonatomic, retain) NSMutableArray *hotArray;
/**联动监听变量*/
@property (nonatomic, assign) NSInteger selectedItem;

@end

@implementation XQ_RankingProgramDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topArray = [NSMutableArray array];
    self.hotArray = [NSMutableArray array];
    self.mainArray = [NSMutableArray array];

    self.navigationItem.title = _model.title;

    [self createNavigation];
    
    [self getDataFromJsonOfTop];
    [self getDataFronJsonOfMain:_model.key];
    [self getDataFromJsonOfTotalHot:_model.key];
    
    [self createTableView];
    [self createTopCollectionView];
    [self createMainCollectionView];
    
    
    
}

#pragma mark - 创建顶部的collectionview
- (void)createTopCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5, HEIGHTSCREEN * 0.06);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.06) collectionViewLayout:flowLayout];
    _topCollectionView.backgroundColor = [UIColor whiteColor];
    _topCollectionView.delegate = self;
    _topCollectionView.dataSource = self;
    _topCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_topCollectionView];
    
    [_topCollectionView registerClass:[XQ_TopProgramDetailCollectionViewCell class] forCellWithReuseIdentifier:@"topCell"];
    
}
#pragma mark - 创建大的mainCollectionView
- (void)createMainCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN, HEIGHTSCREEN - _topCollectionView.frame.size.height - _topCollectionView.frame.origin.y);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _topCollectionView.frame.size.height, WIDTHSCREEN, HEIGHTSCREEN - _topCollectionView.frame.size.height - _topCollectionView.frame.origin.y) collectionViewLayout:flowLayout];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.pagingEnabled = YES;
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainCollectionView];
    
    [_mainCollectionView registerClass:[XQ_MainProgramDetailCollectionViewCell class] forCellWithReuseIdentifier:@"mainCell"];
    
    
}

#pragma mark - 无导航栏视图tableView
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64 - 49) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    // 注册两个label的cell
    [_tableView registerClass:[XQ_TwoProgramDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    // 注册三个label的cell
    [_tableView registerClass:[XQ_ThreeProgramDetailTableViewCell class] forCellReuseIdentifier:@"threeCell"];
    
    
    
}
#pragma mark - tableView的协议方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * lfheight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_model.contentType isEqualToString:@"track"]) {
        return _hotArray.count;
    }
    return _mainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_model.contentType isEqualToString:@"track"]) {
        XQ_TwoProgramDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = _hotArray[indexPath.row];
        cell.labelInter = indexPath.item + 1;
        return cell;
    }
    
    XQ_ThreeProgramDetailTableViewCell *threeCell =[tableView dequeueReusableCellWithIdentifier:@"threeCell"];
    threeCell.model = _mainArray[indexPath.row];
    threeCell.labelInter = indexPath.item + 1;
    return threeCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_model.contentType isEqualToString:@"track"]) {
        XQ_AudioPlayVC *audioPlauVC = [XQ_AudioPlayVC shareDetailViewController];
        audioPlauVC.model = [_hotArray objectAtIndex:indexPath.row];
        audioPlauVC.musicArr = _hotArray;
        audioPlauVC.index = indexPath.row;
        [self presentViewController:audioPlauVC animated:YES completion:nil];
        // 通知按钮旋转,播放及按钮改变图片和状态
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"coverURL"] = [NSURL URLWithString:[[_hotArray  objectAtIndex:indexPath.row] coverMiddle]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
        
    } else {
        
    XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
    albumVC.model = _mainArray[indexPath.row];
    [self.navigationController pushViewController:albumVC animated:YES];
    }
    
}
#pragma mark - collectionView的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _topArray.count + 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _topCollectionView) {
        XQ_TopProgramDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        if (indexPath.item != 0) {
            if (_topArray.count != 0) {
                cell.model = [_topArray objectAtIndex:indexPath.item - 1];
            }
        } else {
            cell.topLabel.text = @"总榜";
        }
        
        if (_selectedItem == indexPath.row) {
            [cell setDidSelected:YES];
        } else {
            [cell setDidSelected:NO];
        }
        
        return cell;
    }
    
    XQ_MainProgramDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    if ([_model.contentType isEqualToString:@"track"]) {
        cell.firstArray = _hotArray;
    } else {
        cell.firstArray = _mainArray;
    }
    
    if ([_model.contentType isEqualToString:@"track"]) {
        cell.firstArray = _hotArray;
    } else {
        cell.firstArray = _mainArray;
    }
    
    cell.titleString = _model.contentType;
    
    return cell;
    
}
#pragma mark - 点击导航栏
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        if (indexPath.item == 0) {
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getDataFromJsonOfTotalHot:_model.key];
            } else {
                [self getDataFronJsonOfMain:_model.key];
            }
        }
        else {
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getDataFromJsonOfTotalHot:[[_topArray objectAtIndex:indexPath.item - 1] key]];
            }
            else {
                [self getDataFronJsonOfMain:[[_topArray objectAtIndex:indexPath.item - 1] key]];
            }
        }
        // 将前一个item还原
        XQ_TopProgramDetailCollectionViewCell *lastCell = (XQ_TopProgramDetailCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        // 获取当前的item
        XQ_TopProgramDetailCollectionViewCell *cell = (XQ_TopProgramDetailCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.row;
        // 点击item改变偏移量
        if (indexPath.item > 1 && indexPath.item < _topArray.count - 1) {
            [_topCollectionView setContentOffset:CGPointMake((indexPath.item - 1) * (80 + 10) - 50, 0) animated:YES];
        }
        else if (indexPath.item == 1 || indexPath.item == 0)
        {
            [_topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (indexPath.item == _topArray.count - 1 || indexPath.item == _topArray.count)
        {
            [_topCollectionView setContentOffset:CGPointMake((_topArray.count - 3) * (80 + 10) - 4, 0) animated:YES];
        }
        [_mainCollectionView setContentOffset:CGPointMake(indexPath.item * WIDTHSCREEN, 0)];
    }
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _mainCollectionView) {
        if (scrollView.contentOffset.x / WIDTHSCREEN == 0) {
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getDataFromJsonOfTotalHot:_model.key];
            }
            else {
                [self getDataFronJsonOfMain:_model.key];
            }
        }
        else {
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getDataFromJsonOfTotalHot:[[_topArray objectAtIndex:scrollView.contentOffset.x / WIDTHSCREEN - 1] key]];
            }
            else {
                [self getDataFronJsonOfMain:[[_topArray objectAtIndex:scrollView.contentOffset.x / WIDTHSCREEN - 1] key]];
            }
        }
        
        if (scrollView.contentOffset.x / WIDTHSCREEN > 1 && scrollView.contentOffset.x / WIDTHSCREEN < _topArray.count - 1) {
            [_topCollectionView setContentOffset:CGPointMake((scrollView.contentOffset.x / WIDTHSCREEN - 1) * (80 + 10) - 50, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / WIDTHSCREEN == 1 || scrollView.contentOffset.x / WIDTHSCREEN == 0)
        {
            [_topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / WIDTHSCREEN == _topArray.count - 1 || scrollView.contentOffset.x / WIDTHSCREEN == _topArray.count)
        {
            [_topCollectionView setContentOffset:CGPointMake((_topArray.count - 3) * (80 + 10) - 4, 0) animated:YES];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / WIDTHSCREEN inSection:0];
        // 将前一个item复原
        XQ_TopProgramDetailCollectionViewCell *lastCell = (XQ_TopProgramDetailCollectionViewCell *)[_topCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        // 获取当前点击的item
        XQ_TopProgramDetailCollectionViewCell *cell = (XQ_TopProgramDetailCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
    
    }
    
}


#pragma mark - 顶部数据
- (void)getDataFromJsonOfTop {
    [_topArray removeAllObjects];
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/track?device=iPhone&key=%@&pageId=1&pageSize=1&scale=2&statPosition=1",_model.key];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"rankingPro" WithPath:@"rankingPro.plist"];
        
        
        NSMutableArray *array = dic[@"categories"];
        for (NSDictionary *dic in array) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_topArray addObject:model];
        }
#pragma mark - 判断: 导航栏没值,显示tableView
        if (_topArray.count == 0) {
            [_topCollectionView removeFromSuperview];
            [_mainCollectionView removeFromSuperview];
            _tableView.hidden = NO;
        }
        
        [_tableView reloadData];
        [_topCollectionView reloadData];
        [_mainCollectionView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"rankingPro" WithPath:@"rankingPro.plist"];
        
        
        NSMutableArray *array = dic[@"categories"];
        for (NSDictionary *dic in array) {
            XQ_RankingModel *model = [[XQ_RankingModel alloc] initWithDic:dic];
            [_topArray addObject:model];
        }
        
        if (_topArray.count == 0) {
            [_topCollectionView removeFromSuperview];
            [_mainCollectionView removeFromSuperview];
            _tableView.hidden = NO;
        }
        
        [_tableView reloadData];
        [_topCollectionView reloadData];
        [_mainCollectionView reloadData];

        
    }];
    
    
}
#pragma mark - 总榜数据&最多经典榜
- (void)getDataFronJsonOfMain:(NSString *)mainStr {
    [_mainArray removeAllObjects];
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/album?device=iPhone&key=%@&pageId=1&pageSize=20&scale=2",mainStr];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"rankingLiat" WithPath:@"rankingLiat.plist"];
        
        
        NSMutableArray *array = dic[@"list"];
        for (NSDictionary *dic in array) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_mainArray addObject:model];
        }
        
        [_mainCollectionView reloadData];
        [_tableView reloadData];
        

    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"rankingLiat" WithPath:@"rankingLiat.plist"];
        
        
        NSMutableArray *array = dic[@"list"];
        for (NSDictionary *dic in array) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_mainArray addObject:model];
        }
        
        [_mainCollectionView reloadData];
        [_tableView reloadData];

        
    }];
    
    
}
#pragma mark - 总榜
- (void)getDataFromJsonOfTotalHot:(NSString *)str {
    [_hotArray removeAllObjects];
     NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/track?device=android&key=%@&pageId=1&pageSize=20&statPosition=1",str];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"hotRankingList" WithPath:@"hotRankingList.plist"];
        
        
        NSMutableArray *listArray = dic[@"list"];
        for (NSDictionary *dic in listArray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_hotArray addObject:model];
        }
        
        [_mainCollectionView reloadData];
        [_tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"hotRankingList" WithPath:@"hotRankingList.plist"];
        
        
        NSMutableArray *listArray = dic[@"list"];
        for (NSDictionary *dic in listArray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_hotArray addObject:model];
        }
        
        [_mainCollectionView reloadData];
        [_tableView reloadData];

        
    }];
    
    
}


@end
