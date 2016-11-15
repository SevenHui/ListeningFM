//
//  XQ_RecommendCell.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_RecommendCell.h"
// 轮播图
#import "SDCycleScrollView.h"
// 圆CollectionView
#import "XQ_DisModel.h"
#import "XQ_DisCollectionViewCell.h"
#import "XQ_HotRecommendsViewController.h"
#import "XQ_RankingProgramDetailViewController.h"
#import "XQ_WKWebViewController.h"
// 小编推荐
#import "XQ_SmallEditorModel.h"
#import "XQ_SmallEditorTableViewCell.h"
#import "XQ_SmallEditorViewController.h"
// 精品听单
#import "XQ_SpecialHearTableViewCell.h"
#import "XQ_SpecialHearViewController.h"
#import "XQ_HearingDetailViewController.h"
// 热门推荐
#import "XQ_HotRecModel.h"
#import "XQ_HotRecommendsTableViewCell.h"
#import "XQ_HotRecommendsViewController.h"

@interface XQ_RecommendCell ()
<
UITableViewDataSource, UITableViewDelegate,
SDCycleScrollViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate
>

/**主界面的视图*/
@property (nonatomic, retain) UITableView *tableView;
/**头视图*/
@property (nonatomic, retain) UIView *headerView;
/**轮播图*/
@property (nonatomic, retain) SDCycleScrollView *sdCycleScrollView;
/**轮播图数据*/
@property (nonatomic, retain) NSMutableArray *arrCycleScrollView;
/**圆collectionView*/
@property (nonatomic, retain) UICollectionView *disCollectionView;
/**圆collectionView数据*/
@property (nonatomic, retain) NSMutableArray *arrDisCollectionView;
/**小编推荐Title*/
@property (nonatomic, retain) NSString *strSmallEditor;
/**小编推荐数据*/
@property (nonatomic, retain) NSMutableArray *arrSmallEditor;
/**精品听单Title*/
@property (nonatomic, retain) NSString *strSpecialHear;
/**精品听单数据*/
@property (nonatomic, retain) NSMutableArray *arrSpecialHear;
/**热门推荐数据*/
@property (nonatomic, retain) NSMutableArray *arrHotRecommends;

@end

@implementation XQ_RecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrCycleScrollView = [NSMutableArray array];
        self.arrSmallEditor = [NSMutableArray array];
        self.arrSpecialHear = [NSMutableArray array];
        self.arrDisCollectionView = [NSMutableArray array];
        self.arrHotRecommends = [NSMutableArray array];
                
        [self getDataFromJsonOfEditorAndImagesAndSpecial];
        [self getDataFromJsonOfDiscoveryHeader];

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        // 不显示线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 头视图
        [self createTableHeaderView];

        // 小编推荐
        [_tableView registerClass:[XQ_SmallEditorTableViewCell class] forCellReuseIdentifier:@"smallEditorCell"];
        // 精品听单
        [_tableView registerClass:[XQ_SpecialHearTableViewCell class] forCellReuseIdentifier:@"specialHearCell"];
        // 热门推荐
        [_tableView registerClass:[XQ_HotRecommendsTableViewCell class] forCellReuseIdentifier:@"hotRecommendsCell"];
        
        // 下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self getUpData];
            [_tableView.mj_header endRefreshing];
            
        }];
        

        
    }
    return self;
    
}
#pragma mark - 头视图
- (void)createTableHeaderView {
    // 头视图
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.45)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _headerView;
    // 轮播图
    self.sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTHSCREEN, _headerView.frame.size.height * 0.65) delegate:self placeholderImage:[UIImage imageNamed:@"live_btn_image"]];
    [_headerView addSubview:_sdCycleScrollView];
    // 圆CollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5, (_headerView.frame.size.height - _sdCycleScrollView.frame.size.height) * 0.86);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 16 * lfheight;
    flowLayout.sectionInset = UIEdgeInsetsMake(8, 16, 8, 16);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.disCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _sdCycleScrollView.frame.size.height, WIDTHSCREEN, _headerView.frame.size.height - _sdCycleScrollView.frame.size.height) collectionViewLayout:flowLayout];
    _disCollectionView.backgroundColor = [UIColor whiteColor];
    _disCollectionView.dataSource = self;
    _disCollectionView.delegate = self;
    _disCollectionView.scrollEnabled = NO;
    [_headerView addSubview:_disCollectionView];
    
    _disCollectionView.pagingEnabled = YES;
    _disCollectionView.showsHorizontalScrollIndicator = NO;
    
    // 圆CollectionView
    [_disCollectionView registerClass:[XQ_DisCollectionViewCell class] forCellWithReuseIdentifier:@"disCell"];
    
}
#pragma mark - 圆CollectionView的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrDisCollectionView.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XQ_DisCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"disCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (_arrDisCollectionView.count != 0) {
        cell.disModel = _arrDisCollectionView[indexPath.item];
    }
    return cell;
}
#pragma mark - 圆CollectionView的点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 经典必听
    if (indexPath.item == 0) {
        XQ_RankingProgramDetailViewController *rankingProgramDetailVC = [[XQ_RankingProgramDetailViewController alloc] init];
        if (_arrDisCollectionView.count != 0) {
            rankingProgramDetailVC.model = _arrDisCollectionView[indexPath.item];
        }
        [[self naviController] pushViewController:rankingProgramDetailVC animated:YES];
    }
    // 付费精品
    if (indexPath.item == 1) {
        XQ_HotRecommendsViewController *hotVC = [[XQ_HotRecommendsViewController alloc] init];
        if (_arrHotRecommends.count != 0) {
            hotVC.model = _arrHotRecommends[indexPath.section];
        }
        [[self naviController] pushViewController:hotVC animated:YES];
    }
    // 热门推荐
    if (indexPath.item == 2) {
        XQ_RankingProgramDetailViewController *rankingProgramDetailVC = [[XQ_RankingProgramDetailViewController alloc] init];
        if (_arrDisCollectionView.count != 0) {
            rankingProgramDetailVC.model = _arrDisCollectionView[indexPath.item];
        }
        [[self naviController] pushViewController:rankingProgramDetailVC animated:YES];
    }
    // 游戏中心
    if (indexPath.item == 3) {
        XQ_WKWebViewController *wkWebViewVC = [[XQ_WKWebViewController alloc] init];
        if (_arrDisCollectionView.count != 0) {
            XQ_DisModel *model = _arrDisCollectionView[indexPath.item];
            wkWebViewVC.strTitle = model.title;
            wkWebViewVC.strURL = model.url;
        }
        [[self naviController] pushViewController:wkWebViewVC animated:YES];
    }
    
}


#pragma mark - 自定义分区头标题高度
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
    
    // 小编推荐
    if (section == 0) {
        labelTitle.text = _strSmallEditor;
    }
    // 精品听单
    else if (section == 1) {
        labelTitle.text = _strSpecialHear;
    }
    // 热门推荐
    else if (_arrHotRecommends.count != 0) {
        XQ_SmallEditorModel *model = [_arrHotRecommends objectAtIndex:section - 2];
        labelTitle.text = model.title;
    }
    
    // 更多
    UIButton *buttonMore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonMore.frame = CGRectMake(lineView.bounds.size.width * 0.8, lineView.bounds.size.height * 0.2, lineView.bounds.size.width * 0.2, lineView.bounds.size.height * 0.6);
    [buttonMore setTitle:@"更多 〉" forState:UIControlStateNormal];
    [buttonMore setTitle:@"更多 〉" forState:UIControlStateHighlighted];
    [buttonMore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonMore setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [lineView addSubview:buttonMore];
    buttonMore.tag = 10000 + section;
    // 小编推荐
    if (section == 0) {
        [buttonMore addTarget:self action:@selector(smallEditorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 精品听单
    else if (section == 1) {
        [buttonMore addTarget:self action:@selector(specialHearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 热门推荐
    else if (_arrHotRecommends.count != 0) {
        [buttonMore addTarget:self action:@selector(hotRecommendsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
    
}

#pragma mark - 分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrHotRecommends.count + 2;
    
}
#pragma mark - Cell的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 精品听单
    if (section == 1) {
        return 2;
    }
    return 1;
}
#pragma mark - Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 精品听单
    if (indexPath.section == 1) {
        return 110 * lfheight;
    }
    return 210 * lfheight;
}
#pragma mark - Cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 小编推荐
    if (indexPath.section == 0) {
        XQ_SmallEditorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallEditorCell"];
        cell.arrSmallEditor = _arrSmallEditor;
        return cell;
    }
    // 精品听单
    if (indexPath.section == 1) {
        XQ_SpecialHearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"specialHearCell"];
        cell.specialHearModel = _arrSpecialHear[indexPath.row];
        return cell;
    }
    // 热门推荐
    XQ_HotRecommendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotRecommendsCell"];
    if (_arrHotRecommends.count != 0) {
        cell.hotRecModel = _arrHotRecommends[indexPath.section - 2];
    }
    return cell;
    
    
}
#pragma mark - 精品听单跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        XQ_HearingDetailViewController *headerDetailVC = [[XQ_HearingDetailViewController alloc] init];
        if (_arrSpecialHear.count != 0) {
            headerDetailVC.model = _arrSpecialHear[indexPath.row];
            [[self naviController] pushViewController:headerDetailVC animated:YES];
        }
    }
}

#pragma mark - 跳转界面点击事件
// 小编推荐更多
-(void)smallEditorButtonAction:(UIButton *)smallEditorButton {
    XQ_SmallEditorViewController *smallEditorMoreVC = [[XQ_SmallEditorViewController alloc] init];
    
    smallEditorMoreVC.strTitle = _strSmallEditor;
    
    [[self naviController] pushViewController:smallEditorMoreVC animated:YES];
    
    
}
// 精品听单更多
- (void)specialHearButtonAction:(UIButton *)specialHearButton {
    XQ_SpecialHearViewController *specialVC = [[XQ_SpecialHearViewController alloc] init];
    [[self naviController] pushViewController:specialVC animated:YES];

}
// 热门推荐更多
- (void)hotRecommendsButtonAction:(UIButton *)hotRecommendsButton {
    XQ_HotRecommendsViewController *hotVC = [[XQ_HotRecommendsViewController alloc] init];
    if (_arrHotRecommends.count != 0) {
        hotVC.model = _arrHotRecommends[hotRecommendsButton.tag - 10000 - 2];
    }
    [[self naviController] pushViewController:hotVC animated:YES];

}


#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrCycleScrollView removeAllObjects];
    [_arrSmallEditor removeAllObjects];
    [_arrSpecialHear removeAllObjects];
    [_arrDisCollectionView removeAllObjects];
    [_arrHotRecommends removeAllObjects];
    [_tableView reloadData];
    [_disCollectionView reloadData];
    [self getDataFromJsonOfEditorAndImagesAndSpecial];
    [self getDataFromJsonOfDiscoveryHeader];
    
}


#pragma mark - 数据解析
// 轮播图&小编推荐&精品听单的数据
- (void)getDataFromJsonOfEditorAndImagesAndSpecial {
    [_arrCycleScrollView removeAllObjects];
    [_arrSmallEditor removeAllObjects];
    [_arrSpecialHear removeAllObjects];
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=and-d8&device=android&includeActivity=true&includeSpecial=true&scale=2&version=5.4.27";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        // 归档
        [XQArchiverTool archiverObject:dic ByKey:@"recomCSS" WithPath:@"recomCSS.plist"];
        
        
        // 轮播图数据
        NSDictionary *dicFocusImages = dic[@"focusImages"];
        NSArray *arrFocusList = dicFocusImages[@"list"];
        for (NSDictionary *dic in arrFocusList) {
            [self.arrCycleScrollView addObject:[dic objectForKey:@"pic"]];
            _sdCycleScrollView.imageURLStringsGroup = _arrCycleScrollView;
        }
        // 小编推荐数据
        NSDictionary *dicEditor = dic[@"editorRecommendAlbums"];
        self.strSmallEditor = dicEditor[@"title"];
        NSMutableArray *arrEditorList = dicEditor[@"list"];
        for (NSDictionary *dic in arrEditorList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrSmallEditor addObject:model];
        }
        // 精品听单数据
        NSDictionary *dicSpecialColumn = dic[@"specialColumn"];
        self.strSpecialHear = dicSpecialColumn[@"title"];
        NSMutableArray *arrSpecialList = dicSpecialColumn[@"list"];
        for (NSDictionary *dic in arrSpecialList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrSpecialHear addObject:model];
        }
        
        [_tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        // 反归档
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"recomCSS" WithPath:@"recomCSS.plist"];
        
        
        // 轮播图数据
        NSDictionary *dicFocusImages = dic[@"focusImages"];
        NSArray *arrFocusList = dicFocusImages[@"list"];
        for (NSDictionary *dic in arrFocusList) {
            [self.arrCycleScrollView addObject:[dic objectForKey:@"pic"]];
            _sdCycleScrollView.imageURLStringsGroup = _arrCycleScrollView;
        }
        // 小编推荐数据
        NSDictionary *dicEditor = dic[@"editorRecommendAlbums"];
        self.strSmallEditor = dicEditor[@"title"];
        NSMutableArray *arrEditorList = dicEditor[@"list"];
        for (NSDictionary *dic in arrEditorList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrSmallEditor addObject:model];
        }
        // 精品听单数据
        NSDictionary *dicSpecialColumn = dic[@"specialColumn"];
        self.strSpecialHear = dicSpecialColumn[@"title"];
        NSMutableArray *arrSpecialList = dicSpecialColumn[@"list"];
        for (NSDictionary *dic in arrSpecialList) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrSpecialHear addObject:model];
        }
        
        [_tableView reloadData];
        
        
    }];
    
}
// 榜单_发现新奇&热门推荐
- (void)getDataFromJsonOfDiscoveryHeader {
    [_arrDisCollectionView removeAllObjects];
    [_arrHotRecommends removeAllObjects];
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_210000_2102&device=android&version=5.4.27";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"recomDH" WithPath:@"recomDH.plist"];
        
        
        // 发现新奇(圆)
        NSDictionary *dicDiscoveryColumns = dic[@"discoveryColumns"];
        NSMutableArray *arrDisList = dicDiscoveryColumns[@"list"];
        NSDictionary *dict1 = [arrDisList objectAtIndex:0];
        NSDictionary *dict2 = [arrDisList objectAtIndex:1];
        NSDictionary *dict3 = [arrDisList objectAtIndex:2];
        NSDictionary *dict4 = [arrDisList objectAtIndex:5];
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:dict1];
        [array addObject:dict2];
        [array addObject:dict3];
        [array addObject:dict4];
        for (NSDictionary *dic in array) {
            XQ_DisModel *model = [[XQ_DisModel alloc] initWithDic:dic];
            [_arrDisCollectionView addObject:model];
        }
        // 热门推荐
        NSDictionary *dicHotRecommends = dic[@"hotRecommends"];
        NSMutableArray *arrHotList = dicHotRecommends[@"list"];
        for (NSDictionary *dic in arrHotList) {
            XQ_HotRecModel *model = [[XQ_HotRecModel alloc] initWithDic:dic];
            [_arrHotRecommends addObject:model];
        }
        
        [_disCollectionView reloadData];
        [_tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"recomDH" WithPath:@"recomDH.plist"];

        
        // 发现新奇(圆)
        NSDictionary *dicDiscoveryColumns = dic[@"discoveryColumns"];
        NSMutableArray *arrDisList = dicDiscoveryColumns[@"list"];
        NSDictionary *dict1 = [arrDisList objectAtIndex:0];
        NSDictionary *dict2 = [arrDisList objectAtIndex:1];
        NSDictionary *dict3 = [arrDisList objectAtIndex:2];
        NSDictionary *dict4 = [arrDisList objectAtIndex:5];
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:dict1];
        [array addObject:dict2];
        [array addObject:dict3];
        [array addObject:dict4];
        for (NSDictionary *dic in array) {
            XQ_DisModel *model = [[XQ_DisModel alloc] initWithDic:dic];
            [_arrDisCollectionView addObject:model];
        }
        // 热门推荐
        NSDictionary *dicHotRecommends = dic[@"hotRecommends"];
        NSMutableArray *arrHotList = dicHotRecommends[@"list"];
        for (NSDictionary *dic in arrHotList) {
            XQ_HotRecModel *model = [[XQ_HotRecModel alloc] initWithDic:dic];
            [_arrHotRecommends addObject:model];
        }
        
        [_disCollectionView reloadData];
        [_tableView reloadData];

        
    }];
    
}

#pragma mark - 当前控制器的导航控制器
- (UINavigationController*)naviController {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}




@end
