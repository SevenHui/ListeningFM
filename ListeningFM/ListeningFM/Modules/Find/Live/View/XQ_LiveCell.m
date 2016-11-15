//
//  XQ_LiveCell.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveCell.h"
// 最上面电台
#import "XQ_LiveTopCollectionViewCell.h"
// 电台类别
#import "XQ_LiveCategoriesModel.h"
#import "XQ_LiveCategoriesCollectionViewCell.h"
#import "XQ_LiveProvinceRadioViewController.h"
#import "XQ_LiveCategoriesDetailViewController.h"
// 分区
#import "XQ_LiveRadiosModel.h"
#import "XQ_LiveTableViewCell.h"
#import "XQ_LiveMoreViewController.h"

@interface XQ_LiveCell ()
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>

/**主界面视图*/
@property (nonatomic, retain) UITableView *tableView;
/**头视图*/
@property (nonatomic, retain) UIView *headerView;
/**最上面电台CollectionView*/
@property (nonatomic, retain) UICollectionView *upCollectionView;
/**最上面电台图片数组*/
@property (nonatomic, retain) NSMutableArray *topImageArray;
/**最上面电台名数组*/
@property (nonatomic, retain) NSMutableArray *topTitleArray;
/**电台类别CollectionView*/
@property (nonatomic, retain) UICollectionView *cateCollectionView;
/**电台类别数据*/
@property (nonatomic, retain) NSMutableArray *arrCategories;
/**本地分区更多接口*/
@property (nonatomic, retain) NSString *strLocalUrl;
/**排行榜分区更多接口*/
@property (nonatomic, retain) NSString *strTopUrl;
/**本地台接口*/
@property (nonatomic, retain) NSString *strLocal;
/**国家台接口*/
@property (nonatomic, retain) NSString *strCountry;
/**网络台接口*/
@property (nonatomic, retain) NSString *strInternet;

@end

@implementation XQ_LiveCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrCategories = [NSMutableArray array];
        self.topImageArray = [NSMutableArray array];
        self.topTitleArray = [NSMutableArray array];
        self.arrLocal = [NSMutableArray array];
        self.arrTop = [NSMutableArray array];
        
        [self getDataFromJsonOfLive];
        [self getMoreUrl];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 100 * lfheight;
        [self addSubview:_tableView];
        // 不显示线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 本地分区
        [_tableView registerClass:[XQ_LiveTableViewCell class] forCellReuseIdentifier:@"localTableViewCell"];
        // 排行榜分区
        [_tableView registerClass:[XQ_LiveTableViewCell class] forCellReuseIdentifier:@"topTableViewCell"];
        
        [self createHeaderView];
        

    }
    return self;
    
}

#pragma mark - 头视图
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.47)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _headerView;
    
    [self createUpLiveCollectionView];
    [self createCateCollectionView];
    
}
#pragma mark - 最上面电台CollectionView
- (void)createUpLiveCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5, _headerView.bounds.size.height * 0.35);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.scrollDirection = NO;
    self.upCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, _headerView.bounds.size.height * 0.35) collectionViewLayout:flowLayout];
    _upCollectionView.backgroundColor = [UIColor whiteColor];
    _upCollectionView.dataSource = self;
    _upCollectionView.delegate = self;
    [_headerView addSubview:_upCollectionView];
    
    _upCollectionView.pagingEnabled = YES;
    _upCollectionView.showsHorizontalScrollIndicator = NO;
    
    // 圆CollectionView
    [_upCollectionView registerClass:[XQ_LiveTopCollectionViewCell class] forCellWithReuseIdentifier:@"upCollectionView"];
    
    
}
#pragma mark - 电台类别CollectionView
- (void)createCateCollectionView {
    UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
    flowOut.itemSize = CGSizeMake((WIDTH * 0.9 ) / 3.9 , (_headerView.frame.size.height - _upCollectionView.frame.size.height) / 4.5);
    flowOut.minimumLineSpacing = 2;
    flowOut.minimumInteritemSpacing = 2;
    flowOut.sectionInset = UIEdgeInsetsMake(8, 11, 8, 11);
    self.cateCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_upCollectionView.frame.origin.x, _upCollectionView.frame.size.height, WIDTHSCREEN - _upCollectionView.frame.origin.x * 2, _headerView.frame.size.height - _upCollectionView.frame.size.height) collectionViewLayout:flowOut];
    _cateCollectionView.backgroundColor = [UIColor whiteColor];
    _cateCollectionView.delegate = self;
    _cateCollectionView.dataSource = self;
    _cateCollectionView.scrollEnabled = NO;
    [_headerView addSubview:_cateCollectionView];

    [_cateCollectionView registerClass:[XQ_LiveCategoriesCollectionViewCell class] forCellWithReuseIdentifier:@"cateCell"];
        

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _upCollectionView) {
        return _topTitleArray.count;
    } else {
        return _arrCategories.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 在上面
    if (collectionView == _upCollectionView) {
        XQ_LiveTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"upCollectionView" forIndexPath:indexPath];
    
        cell.imageViewPhoto.image = [UIImage imageNamed:_topImageArray[indexPath.item]];
        
        cell.labelName.text = [NSString stringWithFormat:@"%@", _topTitleArray[indexPath.item]];
        
        return cell;
        
    }
    else {
    // 电台类别
    XQ_LiveCategoriesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cateCell" forIndexPath:indexPath];
        if (_arrCategories.count != 0) {
            cell.cateModel = _arrCategories[indexPath.item];
        }
        
    return cell;
    }
    
}

#pragma mark - 跳转界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _upCollectionView) {
        // 本地台
        if (indexPath.item == 0) {
            XQ_LiveMoreViewController *liveMoreVC = [[XQ_LiveMoreViewController alloc] init];
            liveMoreVC.name = _topTitleArray[0];
            liveMoreVC.string = _strLocal;
            [[self naviController] pushViewController:liveMoreVC animated:YES];
        }
        // 国家台
        if (indexPath.item == 1) {
            XQ_LiveMoreViewController *liveMoreVC = [[XQ_LiveMoreViewController alloc] init];
            liveMoreVC.name = _topTitleArray[1];
            liveMoreVC.string = _strCountry;
            [[self naviController] pushViewController:liveMoreVC animated:YES];
        }
        // 省市台
        if (indexPath.item == 2) {
            XQ_LiveProvinceRadioViewController *provinceVC = [[XQ_LiveProvinceRadioViewController alloc] init];
            [[self naviController] pushViewController:provinceVC animated:YES];
        }
        // 网络台
        if (indexPath.item == 3) {
            XQ_LiveMoreViewController *liveMoreVC = [[XQ_LiveMoreViewController alloc] init];
            liveMoreVC.name = _topTitleArray[3];
            liveMoreVC.string = _strInternet;
            [[self naviController] pushViewController:liveMoreVC animated:YES];
        }
    }
    // 类别台
    if (collectionView == _cateCollectionView) {
        XQ_LiveCategoriesDetailViewController *cateVC = [[XQ_LiveCategoriesDetailViewController alloc] init];
        cateVC.model = _arrCategories[indexPath.row];
        [[self naviController] pushViewController:cateVC animated:YES];
    }
    
}

#pragma mark - 分区头标题高度
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
    // 本地头标题
    if (section == 0) {
        labelTitle.text = @"你好, 大连";
    }
    // 排行榜头标题
    else {
        labelTitle.text = @"排行榜";
    }
    // 更多
    UIButton *buttonMore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonMore.frame = CGRectMake(lineView.bounds.size.width * 0.8, lineView.bounds.size.height * 0.2, lineView.bounds.size.width * 0.2, lineView.bounds.size.height * 0.6);
    [buttonMore setTitle:@"更多 〉" forState:UIControlStateNormal];
    [buttonMore setTitle:@"更多 〉" forState:UIControlStateHighlighted];
    [buttonMore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonMore setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [lineView addSubview:buttonMore];
    // 本地
    if (section == 0) {
        [buttonMore addTarget:self action:@selector(localCityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 排行榜
    else {
        [buttonMore addTarget:self action:@selector(rankingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    
    return view;
    
}

#pragma mark - 分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}
#pragma mark - Cell的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
#pragma mark - Cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 你好, 大连
    if (indexPath.section == 0) {
        XQ_LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localTableViewCell"];
        
        if (_arrLocal.count != 0) {
            
            cell.liveRadiosModel = _arrLocal[indexPath.row];

        }
        
        return cell;
        
    }
    // 排行榜
    XQ_LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topTableViewCell"];
    
    if (_arrTop.count != 0) {
        
        cell.liveRadiosModel = _arrTop[indexPath.row];
        
    }
    
    return cell;
    
}
#pragma mark - 跳转播放界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AudioPlayVC *audioPlauVC = [XQ_AudioPlayVC shareDetailViewController];
    // 你好, 大连
    if (indexPath.section == 0) {
        audioPlauVC.model = _arrLocal[indexPath.row];
        audioPlauVC.musicArr = _arrLocal;
        audioPlauVC.index = indexPath.row;
        
        // 通知按钮旋转,播放及按钮改变图片和状态
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"coverURL"] = [NSURL URLWithString:[[_arrLocal objectAtIndex:indexPath.row] coverMiddle]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
        
    }
    // 排行榜
    else {
        audioPlauVC.model = _arrTop[indexPath.row];
        audioPlauVC.musicArr = _arrTop;
        audioPlauVC.index = indexPath.row;
        // 通知按钮旋转,播放及按钮改变图片和状态
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"coverURL"] = [NSURL URLWithString:[[_arrTop objectAtIndex:indexPath.row] coverMiddle]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
        
    }
    
    self.block(audioPlauVC);
    
    
}

#pragma mark - 本地更多跳转界面点击事件
- (void)localCityButtonAction:(UIButton *)localCityButton {
    
    XQ_LiveMoreViewController *liveMoreVC = [[XQ_LiveMoreViewController alloc] init];
    liveMoreVC.name = @"你好, 大连";
    liveMoreVC.string = _strLocalUrl;
    [[self naviController] pushViewController:liveMoreVC animated:YES];
    
}
#pragma mark - 排行榜更多跳转界面点击事件
- (void)rankingButtonAction:(UIButton *)rankingButton {

    XQ_LiveMoreViewController *liveMoreVC = [[XQ_LiveMoreViewController alloc] init];
    liveMoreVC.name = @"电台排行榜";
    liveMoreVC.string = _strTopUrl;
    [[self naviController] pushViewController:liveMoreVC animated:YES];

}

#pragma mark - 广播的数据
- (void)getDataFromJsonOfLive {
    // 最上面CollectionView的图片和标题
    self.topImageArray = [NSMutableArray arrayWithObjects:@"icon_radio_local",@"icon_radio_country",@"icon_radio_province",@"icon_radio_internet", nil];
    self.topTitleArray = [NSMutableArray arrayWithObjects:@"本地台",@"国家台",@"省市台",@"网络台", nil];
    
    NSString *string = @"http://live.ximalaya.com/live-web/v4/homepage";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"live" WithPath:@"live.plist"];
        
        
        NSDictionary *dicData = dic[@"data"];
        
        // 电台类别数据
        NSMutableArray *arrCategories = dicData[@"categories"];
        for (NSDictionary *dic in arrCategories) {
            XQ_LiveCategoriesModel *model = [[XQ_LiveCategoriesModel alloc] initWithDic:dic];
            [_arrCategories addObject:model];
        }
        // 本地分区数据
        NSMutableArray *arrLocal = dicData[@"localRadios"];
        for (NSDictionary *dic in arrLocal) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_arrLocal addObject:model];
        }
        // 排行榜分区数据
        NSMutableArray *arrTop = dicData[@"topRadios"];
        for (NSDictionary *dic in arrTop) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_arrTop addObject:model];
        }
        
        [_tableView reloadData];
        [_cateCollectionView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"live" WithPath:@"live.plist"];
        
        
        NSDictionary *dicData = dic[@"data"];
        
        // 电台类别数据
        NSMutableArray *arrCategories = dicData[@"categories"];
        for (NSDictionary *dic in arrCategories) {
            XQ_LiveCategoriesModel *model = [[XQ_LiveCategoriesModel alloc] initWithDic:dic];
            [_arrCategories addObject:model];
        }
        // 本地分区数据
        NSMutableArray *arrLocal = dicData[@"localRadios"];
        for (NSDictionary *dic in arrLocal) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_arrLocal addObject:model];
        }
        // 排行榜分区数据
        NSMutableArray *arrTop = dicData[@"topRadios"];
        for (NSDictionary *dic in arrTop) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_arrTop addObject:model];
        }
        
        [_tableView reloadData];
        [_cateCollectionView reloadData];

        
    }];
    
    
}

#pragma mark - 当前控制器的导航控制器
- (UINavigationController *)naviController {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}




#pragma mark - 点击接口
- (void)getMoreUrl {
    // 本地更多接口
    self.strLocalUrl = @"http://live.ximalaya.com/live-web/v1/radio/local?pageNum=%ld&pageSize=20";
    // 排行榜更多接口
    self.strTopUrl = @"http://live.ximalaya.com/live-web/v2/radio/hot?pageNum=%ld&pageSize=20";
    // 本地&国家&网络电台接口
    self.strLocal = @"http://live.ximalaya.com/live-web/v2/radio/province?pageNum=%ld&pageSize=20&provinceCode=210000";
    self.strCountry = @"http://live.ximalaya.com/live-web/v2/radio/national?pageNum=%ld&pageSize=20";
    self.strInternet = @"http://live.ximalaya.com/live-web/v2/radio/network?pageNum=%ld&pageSize=20";
}


@end
