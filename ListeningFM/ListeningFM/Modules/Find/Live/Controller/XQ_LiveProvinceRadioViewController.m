//
//  XQ_LiveProvinceRadioViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveProvinceRadioViewController.h"
// 顶部
#import "XQ_LiveProvinceTopCollectionViewCell.h"
#import "XQ_LiveCategoriesModel.h"
// 切换
#import "XQ_LiveProvinceMainCollectionViewCell.h"
#import "XQ_LiveRadiosModel.h"

@interface XQ_LiveProvinceRadioViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
XQ_LiveProvinceMainCollectionViewCellDlegate
>

/**顶部视图collectionView*/
@property (nonatomic, retain) UICollectionView *topCollectionView;
/**切换视图collectionView*/
@property (nonatomic, retain) UICollectionView *mainCollectionView;
/**顶部视图数据*/
@property (nonatomic, retain) NSMutableArray *topArray;
/**切换视图数据*/
@property (nonatomic, retain) NSMutableArray *mainArray;
/**监听变量*/
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, assign) NSInteger proVinceNumber;

@end

@implementation XQ_LiveProvinceRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"省市台";
    
    [self createNavigation];

    [self createTopCollectionView];
    [self createMainCollectionView];
    [self getData];
    [self getMainDataPage:1 proVince:110000];
    


}

- (void)createTopCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5, HEIGHTSCREEN * 0.06);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.06) collectionViewLayout:flowLayout];
    _topCollectionView.backgroundColor = [UIColor whiteColor];
    _topCollectionView.showsHorizontalScrollIndicator = NO;
    _topCollectionView.delegate = self;
    _topCollectionView.dataSource = self;
    [self.view addSubview:_topCollectionView];
    
    //注册顶部的cell
    [_topCollectionView registerClass:[XQ_LiveProvinceTopCollectionViewCell class] forCellWithReuseIdentifier:@"topCell"];
    
}

- (void)createMainCollectionView{
    UICollectionViewFlowLayout *flowLuyout = [[UICollectionViewFlowLayout alloc] init];
    flowLuyout.itemSize = CGSizeMake(WIDTHSCREEN, HEIGHTSCREEN - HEIGHTSCREEN * 0.06 - 64);
    flowLuyout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLuyout.minimumLineSpacing = 0;
    flowLuyout.minimumInteritemSpacing = 0;
    flowLuyout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _topCollectionView.frame.size.height, WIDTHSCREEN, HEIGHTSCREEN - HEIGHTSCREEN * 0.06 - 64) collectionViewLayout:flowLuyout];
    _mainCollectionView.pagingEnabled = YES;
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [self.view addSubview:_mainCollectionView];
    
    [_mainCollectionView registerClass:[XQ_LiveProvinceMainCollectionViewCell class] forCellWithReuseIdentifier:@"mainCell"];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _topArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        XQ_LiveProvinceTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        cell.model = _topArray[indexPath.row];
        if (_selectedItem == indexPath.item) {
            
            [cell setDidSelected:YES];
        }
        else {
            [cell setDidSelected:NO];
        }
        
        return cell;
        
    }
    XQ_LiveProvinceMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.array = _mainArray;
    
    // block跳转播放界面
    void(^audioPlayVC)(XQ_AudioPlayVC *) = ^(XQ_AudioPlayVC  *audioPlayVC) {
        
        [self presentViewController:audioPlayVC animated:YES completion:nil];
        
        
    };
    cell.block = audioPlayVC;

    
    return cell;
    
    
}

#pragma mark - 视图切换
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        XQ_LiveCategoriesModel *model = _topArray[indexPath.item];
        self.proVinceNumber = [model.code integerValue];
        [self getMainDataPage:1 proVince:[model.code integerValue]];
        // 将前一个item还原
        XQ_LiveProvinceTopCollectionViewCell *latCell = (XQ_LiveProvinceTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [latCell setDidSelected:NO];
        // 获取当前的item
        XQ_LiveProvinceTopCollectionViewCell *cell = (XQ_LiveProvinceTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
        // item改变偏移量
        if (indexPath.item > 1 && indexPath.item < _topArray.count - 2) {
            
            [_topCollectionView setContentOffset:CGPointMake((indexPath.item - 1) * (60 + 10) - 60, 0) animated:YES];
        }
        else if (indexPath.item == 1 || indexPath.item == 0){
            [_topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (indexPath.item == _topArray.count - 1 || indexPath.item == _topArray.count){
            [_topCollectionView setContentOffset:CGPointMake((_topArray.count - 5)  * (60 + 10) + 10  , 0) animated:YES];
        }
        [_mainCollectionView setContentOffset:CGPointMake(indexPath.item * WIDTHSCREEN, 0) animated:YES];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _mainCollectionView) {
        XQ_LiveCategoriesModel *model = [_topArray objectAtIndex:scrollView.contentOffset.x / WIDTHSCREEN];
        self.proVinceNumber = [model.code integerValue];
        [self getMainDataPage:1 proVince:[model.code integerValue]];
        if (scrollView.contentOffset.x / WIDTHSCREEN > 1 && scrollView.contentOffset.x / WIDTHSCREEN < _topArray.count - 2) {
            [_topCollectionView setContentOffset:CGPointMake((scrollView.contentOffset.x / WIDTHSCREEN - 1) * (60 + 10) - 60, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / WIDTHSCREEN == 1 || scrollView.contentOffset.x / WIDTHSCREEN == 0)
        {
            [_topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / WIDTHSCREEN == _topArray.count - 1 || scrollView.contentOffset.x / WIDTHSCREEN == _topArray.count)
        {
            [_topCollectionView setContentOffset:CGPointMake((_topArray.count - 5) * (60 + 10) + 10, 0) animated:YES];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / WIDTHSCREEN inSection:0];
        // 将前一个item复原
        XQ_LiveProvinceTopCollectionViewCell *lastCell = (XQ_LiveProvinceTopCollectionViewCell *)[_topCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        // 获取当前点击的item
        XQ_LiveProvinceTopCollectionViewCell *cell = (XQ_LiveProvinceTopCollectionViewCell *)[_topCollectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
    }
}
#pragma mark - 实现协议方法
- (void)getDelegateData:(NSInteger)pageNumber {
    
    [self getMainDataPage:pageNumber proVince:_proVinceNumber];
    
}

#pragma mark - 顶部数据
- (void)getData {
    self.topArray = [NSMutableArray array];
    NSString *string = @"http://live.ximalaya.com/live-web/v2/province?device=iPhone&statEvent=pageview%2Fradiolist%40%E7%9C%81%E5%B8%82%E5%8F%B0&statModule=%E7%9C%81%E5%B8%82%E5%8F%B0&statPage=tab%40%E5%8F%91%E7%8E%B0_%E5%B9%BF%E6%92%AD";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"province" WithPath:@"province.plist"];
        
        
        NSMutableArray *dataArray = dic[@"data"];
        for (NSDictionary *dic in dataArray) {
            XQ_LiveCategoriesModel *model = [[XQ_LiveCategoriesModel alloc] initWithDic:dic];
            [_topArray addObject:model];
        }
        
        [self.topCollectionView reloadData];
        [self.mainCollectionView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"province" WithPath:@"province.plist"];
        
        
        NSMutableArray *dataArray = dic[@"data"];
        for (NSDictionary *dic in dataArray) {
            XQ_LiveCategoriesModel *model = [[XQ_LiveCategoriesModel alloc] initWithDic:dic];
            [_topArray addObject:model];
        }
        
        [self.topCollectionView reloadData];
        [self.mainCollectionView reloadData];

        
    }];

}

#pragma mark -- 切换视图数据
- (void)getMainDataPage:(NSInteger)pageNUmber proVince:(NSInteger)provinceNumber {
    if (pageNUmber == 1) {
        self.mainArray = [NSMutableArray array];
    }
    NSString *string = [NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v2/radio/province?device=iPhone&pageNum=%ld&pageSize=30&provinceCode=%ld",pageNUmber,provinceNumber];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"provinceMain" WithPath:@"provinceMain.plist"];
        
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSMutableArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_mainArray addObject:model];
        }
        
        [_mainCollectionView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"provinceMain" WithPath:@"provinceMain.plist"];
        
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSMutableArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            XQ_LiveRadiosModel *model = [[XQ_LiveRadiosModel alloc] initWithDic:dic];
            [_mainArray addObject:model];
        }
        
        [_mainCollectionView reloadData];

        
    }];
    
}






@end
