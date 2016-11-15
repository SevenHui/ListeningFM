//
//  XQ_HotRecommendsViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HotRecommendsViewController.h"
#import "XQ_HotMoreTopCollectionViewCell.h"
#import "XQ_HotMoreMainCollectionViewCell.h"
#import "XQ_HotMoreDetailCollectionViewCell.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_HotRecommendsViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
XQ_HotMoreMainCollectionViewCellDelegate
>

/**顶部视图*/
@property (nonatomic, retain) UICollectionView *topCollectionView;
/**切换视图*/
@property (nonatomic, retain) UICollectionView *mainCollectionView;
/**顶部数据*/
@property (nonatomic, retain) NSMutableArray *topArray;
/**切换数据*/
@property (nonatomic, retain) NSMutableArray *mainArray;
/**监听被选中的item下标*/
@property(nonatomic, assign)NSInteger selectedItem;
/**推荐数据*/
@property (nonatomic, retain) NSMutableArray *remmendArray;
/**轮播图数据*/
@property (nonatomic, retain) NSMutableArray *headArray;
/**推荐里tableView的数据*/
@property (nonatomic, retain) NSMutableArray *tableViewArray;
@property (nonatomic, assign) NSInteger keyNumber;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger categrayId;

@end

@implementation XQ_HotRecommendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _model.title;

    self.topArray = [NSMutableArray array];
    self.remmendArray = [NSMutableArray array];
    self.headArray = [NSMutableArray array];
    self.tableViewArray = [NSMutableArray array];
    
    [self createNavigation];
    
    [self getData];
    [self getRecommendData];
    [self createTopcollectionView];
    [self createMainCollectionView];
    

}
#pragma mark - 顶部
- (void)createTopcollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5 * lfweight, HEIGHTSCREEN * 0.07);
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
    [_topCollectionView registerClass:[XQ_HotMoreTopCollectionViewCell class] forCellWithReuseIdentifier:@"topCell"];
    
    
}
#pragma mark - 下面
- (void)createMainCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN, HEIGHTSCREEN - HEIGHTSCREEN * 0.06 - 64);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _topCollectionView.frame.size.height, WIDTHSCREEN, HEIGHTSCREEN - HEIGHTSCREEN * 0.06 - 64) collectionViewLayout:flowLayout];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.delegate  = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.pagingEnabled = YES;
    [self.view addSubview:_mainCollectionView];
    // 注册推荐的cell
    [_mainCollectionView registerClass:[XQ_HotMoreDetailCollectionViewCell class] forCellWithReuseIdentifier:@"detailCell"];
    // 注册其他的cell
    [_mainCollectionView registerClass:[XQ_HotMoreMainCollectionViewCell class] forCellWithReuseIdentifier:@"mainCell"];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _topArray.count + 1;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        XQ_HotMoreTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        if (indexPath.item != 0) {
            if (_topArray.count != 0) {
                XQ_HotRecModel *model = [_topArray objectAtIndex:indexPath.row - 1];
                cell.model = model;
            }
        }
        else {
            cell.label.text = @"推荐";
        }
        
        if (_selectedItem == indexPath.item) {
            [cell setDidSelected:YES];
        }
        else {
            [cell setDidSelected:NO];
        }
        return cell;
        
    }
    if (collectionView == _mainCollectionView) {
        // 推荐
        if (indexPath.item == 0) {
            XQ_HotMoreDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
            cell.topscrollviewArray = _headArray;
            cell.mainArray = _tableViewArray;
            return cell;
        }
        else {
            XQ_HotMoreMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
            cell.listArray = _mainArray;
            cell.delegate = self;
            
            return cell;
        }
        
    }
    
    return nil;
    
}
#pragma mark - 点击改变当前栏和滑动导航栏
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _topCollectionView) {
        if (indexPath.item != 0) {
            // 从网络请求列表内容数据
            if (_topArray.count != 0) {
                if (_model.ID == nil) {
                    [self getMainCollectionData:[_model.categoryId integerValue] keyword:[[[_topArray objectAtIndex:indexPath.item - 1] keywordId] integerValue] pNumber:1];
                }
                if(_model.categoryId == nil){
                    [self getMainCollectionData:[_model.ID integerValue] keyword:[[[_topArray objectAtIndex:indexPath.item - 1] keywordId] integerValue] pNumber:1];
                    
                }
                
                self.keyNumber = [[[_topArray objectAtIndex:indexPath.item - 1] keywordId] integerValue];
            }
            
        }
        
        // 将前一个item还原
        XQ_HotMoreTopCollectionViewCell *topcell = (XQ_HotMoreTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [topcell setDidSelected:NO];
        // 获取当前点击的item
        XQ_HotMoreTopCollectionViewCell *cell = (XQ_HotMoreTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
        
        
        // 点击item改变偏移量:
        if (indexPath.item > 1 && indexPath.item < _topArray.count - 1) {
            [_topCollectionView setContentOffset:CGPointMake((indexPath.item - 1) * (90 + 10) - 50, 0) animated:YES];
        }
        else if (indexPath.item == 1 || indexPath.item == 0)
        {
            [_topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (indexPath.item == _topArray.count - 1 || indexPath.item == _topArray.count)
        {
            [_topCollectionView setContentOffset:CGPointMake((_topArray.count - 3) * (90 + 10) - 4, 0) animated:YES];
        }
        [_mainCollectionView setContentOffset:CGPointMake(indexPath.item * WIDTHSCREEN, 0)];
    }
    
}
#pragma mark - 滑动改变导航栏的偏移量和当前栏
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _mainCollectionView) {
        if (scrollView.contentOffset.x / WIDTHSCREEN >= 1) {
            //从网络请求列表内容数据:
            if (_model.ID == nil) {
                [self getMainCollectionData:[_model.categoryId integerValue] keyword:[[[_topArray objectAtIndex:scrollView.contentOffset.x / WIDTHSCREEN - 1] keywordId] integerValue] pNumber:1];
            }
            else {
                [self getMainCollectionData:[_model.ID integerValue] keyword:[[[_topArray objectAtIndex:scrollView.contentOffset.x / WIDTHSCREEN - 1] keywordId] integerValue] pNumber:1];
            }
            _keyNumber = [[[_topArray objectAtIndex:scrollView.contentOffset.x / WIDTHSCREEN - 1] keywordId] integerValue];
        }
        
        if (scrollView.contentOffset.x / WIDTHSCREEN > 1 && scrollView.contentOffset.x / WIDTHSCREEN < _topArray.count - 1) {
            [_topCollectionView setContentOffset:CGPointMake((scrollView.contentOffset.x / WIDTHSCREEN - 1) * (90 + 10) - 50, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / WIDTHSCREEN == 1 || scrollView.contentOffset.x / WIDTHSCREEN == 0)
        {
            [_topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / WIDTHSCREEN == _topArray.count - 1 || scrollView.contentOffset.x / WIDTHSCREEN == _topArray.count)
        {
            [_topCollectionView setContentOffset:CGPointMake((_topArray.count - 3) * (90 + 10) - 4, 0) animated:YES];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / WIDTHSCREEN inSection:0];
        
        // 将前一个item复原:
        XQ_HotMoreTopCollectionViewCell *lastCell = (XQ_HotMoreTopCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        // 获取当前点击的item:
        XQ_HotMoreTopCollectionViewCell *cell = (XQ_HotMoreTopCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
        
    }
}
#pragma mark - 上面数据
- (void)getData {
    [_topArray removeAllObjects];
    NSString *string = nil;
    if (_model.ID  == nil) {
        string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/keywords?categoryId=%@&channel=and-d8&contentType=album&device=android&version=5.4.15",_model.categoryId];
    }
    if (_model.categoryId == nil) {
        string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/keywords?categoryId=%@&channel=and-d8&contentType=album&device=android&version=5.4.15",_model.ID];
    }

    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        // 归档
        [XQArchiverTool archiverObject:dic ByKey:@"hotRecomUp" WithPath:@"hotRecomUp.plist"];
        
        
        NSMutableArray *array = [dic objectForKey:@"keywords"];
        for (NSDictionary *dic in array) {
            XQ_HotRecModel *model = [[XQ_HotRecModel alloc] initWithDic:dic];
            [_topArray addObject:model];
        }
        
        if (_topArray.count != 0) {
            [self.topCollectionView reloadData];
            [self.mainCollectionView reloadData];
            
        }
        
        
    } Failure:^(NSError *error) {
        
        // 反归档
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"hotRecomUp" WithPath:@"hotRecomUp.plist"];
        
        
        NSMutableArray *array = [dic objectForKey:@"keywords"];
        for (NSDictionary *dic in array) {
            XQ_HotRecModel *model = [[XQ_HotRecModel alloc] initWithDic:dic];
            [_topArray addObject:model];
        }
        
        if (_topArray.count != 0) {
            [self.topCollectionView reloadData];
            [self.mainCollectionView reloadData];
            
        }
        
        
    }];

}
#pragma mark - 下面数据
- (void)getMainCollectionData:(NSInteger)Id keyword:(NSInteger)keywordId pNumber:(NSInteger)pageNumber {
    if (pageNumber == 1) {
        self.mainArray = [NSMutableArray array];
    }
    
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/category/keyword/albums?calcDimension=hot&categoryId=%ld&device=android&keywordId=%ld&pageId=%ld&pageSize=20&status=0&version=5.4.15",Id,keywordId,pageNumber];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        [XQArchiverTool archiverObject:dic ByKey:@"hotRecomDown" WithPath:@"hotRecomDown.plist"];
        
        NSMutableArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dic in listarray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_mainArray addObject:model];
        }

        [_mainCollectionView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"hotRecomDown" WithPath:@"hotRecomDown.plist"];
        
        
        NSMutableArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dic in listarray) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_mainArray addObject:model];
        }
        
        [_mainCollectionView reloadData];

        
    }];
    
    
}
#pragma mark -- 实现代理方法
- (void)getdelegateData:(NSInteger)page {
    if (_model.ID == nil) {
        [self getMainCollectionData:[_model.categoryId integerValue] keyword:_keyNumber pNumber:page];
    }
    else{
        [self getMainCollectionData:[_model.ID integerValue] keyword:_keyNumber pNumber:page];
    }
}
#pragma mark - 推荐的数据
- (void)getRecommendData {
    [_tableViewArray removeAllObjects];
    NSString *string = nil;
    // 推荐
    if (_model.ID == nil) {
        string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v3/category/recommends?categoryId=%ld&contentType=album&device=android&version=5.4.15",[_model.categoryId integerValue]];
    }
    // 分类
    if (_model.categoryId == nil) {
        string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v3/category/recommends?categoryId=%ld&contentType=album&device=android&version=5.4.15",[_model.ID integerValue]];
    }
    
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        [XQArchiverTool archiverObject:dic ByKey:@"recommends" WithPath:@"recommends.plist"];
        
        // 图片数据
        NSDictionary *dict = [dic objectForKey:@"focusImages"];
        NSMutableArray *listArray = [dict objectForKey:@"list"];
        for (NSDictionary *listDic in listArray) {
            [_headArray addObject:[listDic objectForKey:@"pic"]];
        }
        // 下面tableView的数据
        NSDictionary *diction = [dic objectForKey:@"categoryContents"];
        NSMutableArray *dicArray = [diction objectForKey:@"list"];
        for (NSDictionary *dictionary in dicArray) {
            if ([[dictionary objectForKey:@"moduleType"] integerValue] == 3 || [[dictionary objectForKey:@"moduleType"] integerValue] == 5 ) {
                XQ_HotRecModel *bigModel = [[XQ_HotRecModel alloc] initWithDic:dictionary];
                [_tableViewArray addObject:bigModel];
            }
            
        }
        
        [_mainCollectionView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"recommends" WithPath:@"recommends.plist"];

        
        // 图片数据
        NSDictionary *dict = [dic objectForKey:@"focusImages"];
        NSMutableArray *listArray = [dict objectForKey:@"list"];
        for (NSDictionary *listDic in listArray) {
            [_headArray addObject:[listDic objectForKey:@"pic"]];
        }
        // 下面tableView的数据
        NSDictionary *diction = [dic objectForKey:@"categoryContents"];
        NSMutableArray *dicArray = [diction objectForKey:@"list"];
        for (NSDictionary *dictionary in dicArray) {
            if ([[dictionary objectForKey:@"moduleType"] integerValue] == 3 || [[dictionary objectForKey:@"moduleType"] integerValue] == 5 ) {
                XQ_HotRecModel *bigModel = [[XQ_HotRecModel alloc] initWithDic:dictionary];
                [_tableViewArray addObject:bigModel];
            }
            
        }
        
        [_mainCollectionView reloadData];
        
        
    }];
    
    
    
}
    
    
    
    
    

@end
