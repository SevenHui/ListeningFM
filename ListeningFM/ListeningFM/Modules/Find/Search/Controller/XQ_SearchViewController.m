//
//  XQ_SearchViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SearchViewController.h"
#import "XQ_BaseView.h"
#import "XQ_SearchContentTableViewCell.h"
#import "XQ_SearchHotContentCollectionViewCell.h"
#import "XQ_NoDataSearchView.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_SearchViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain) UITableView *tableView;
/**搜索栏*/
@property (nonatomic, retain) UISearchBar *search;
/**搜索文字*/
@property (nonatomic, retain) NSString *searchText;
/**热搜视图*/
@property(nonatomic, retain)UIView *hotSearchView;
/**热搜数据*/
@property(nonatomic, retain)NSMutableArray *hotSearchDataSource;
/**搜索可选信息视图*/
@property (nonatomic, retain) UICollectionView *collectionView;
/**没数据时视图*/
@property(nonatomic, retain)XQ_NoDataSearchView *noDataSearchView;
/**数据源数组*/
@property (nonatomic, retain) NSMutableArray *arrForSearch;

@end

@implementation XQ_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrForSearch = [NSMutableArray array];
    self.hotSearchDataSource = [NSMutableArray array];
    
    [self createNavigation];
    
    [self getDataFromNet];
    
    [self createSearchBar];
    [self createCollectionView];
    [self createTableView];
    [self showNoDataSearchView];
    _tableView.hidden = YES;


    
}
#pragma mark - 搜索栏
- (void)createSearchBar {
    // 搜索框
    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 40 * lfheight)];
    _search.backgroundImage = [[UIImage alloc] init];
    self.navigationItem.titleView = _search;
    UITextField *searchField = [_search valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    _search.placeholder = @"倾听你的声音";
    [_search becomeFirstResponder];
    
}

#pragma mark - 热搜CollectionView
- (void)createCollectionView {
    _tableView.hidden = YES;
    self.hotSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64)];
    [self.view addSubview:_hotSearchView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(WIDTHSCREEN * 0.4, WIDTHSCREEN * 0.07, WIDTHSCREEN * 0.2, HEIGHTSCREEN * 0.04);
    label.text = @"热门搜索";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [_hotSearchView addSubview:label];
    
    
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.itemSize = CGSizeMake(WIDTHSCREEN / 4, HEIGHTSCREEN * 0.06);
    flowLayOut.minimumInteritemSpacing = 10;
    flowLayOut.minimumLineSpacing = 10;
    flowLayOut.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y + label.frame.size.height * 1.5, WIDTHSCREEN, HEIGHTSCREEN * 0.23) collectionViewLayout:flowLayOut];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_hotSearchView addSubview:_collectionView];
    [self.collectionView registerClass:[XQ_SearchHotContentCollectionViewCell class] forCellWithReuseIdentifier:@"hotCell"];
    
}

#pragma mark - TableView
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[XQ_SearchContentTableViewCell class] forCellReuseIdentifier:@"searchTableViewCell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotSearchDataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XQ_SearchHotContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
    if (_hotSearchDataSource.count != 0) {
        cell.label.textColor = COLOR;
        cell.label.text = [_hotSearchDataSource objectAtIndex:indexPath.item];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _searchText = [_hotSearchDataSource objectAtIndex:indexPath.item];
    _hotSearchView.hidden = YES;
    _tableView.hidden = NO;
    _noDataSearchView.hidden = YES;
    _search.text = _searchText;
    [self getSearchContentWithText:_searchText];
}
#pragma mark - 热门搜索数据
- (void)getDataFromNet {
    NSString *string = @"http://mobile.ximalaya.com/m/hot_search_keys?device=iPhone";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        _hotSearchDataSource = [result objectForKey:@"keys"];
        
        [_collectionView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        
    }];

}
#pragma mark - 没有数据页面
- (void)showNoDataSearchView {
    self.noDataSearchView = [[XQ_NoDataSearchView alloc] init];
    _noDataSearchView.frame = CGRectMake(0, 64, WIDTHSCREEN, HEIGHTSCREEN - 64);
    [_tableView addSubview:_noDataSearchView];
}

#pragma mark - cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_arrForSearch.count != 0) {
        _noDataSearchView.hidden = YES;
    }
    else {
        _noDataSearchView.hidden = NO;
    }
    return _arrForSearch.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80 * lfheight;
}
#pragma mark - cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XQ_SearchContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.searchText = _searchText;
        cell.model = [_arrForSearch objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 跳转到专辑页面
    XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
    albumVC.model = [_arrForSearch objectAtIndex:indexPath.row];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:albumVC animated:YES];

}
#pragma mark - 搜索文字并跳转
- (void)getSearchContentWithText:(NSString *)text {
    NSString *string = [NSString stringWithFormat:@"http://search.ximalaya.com/suggest?device=iPhone&kw=%@",text];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSArray *arrTemp = [result objectForKey:@"albumResultList"];
        for (NSDictionary *dic in arrTemp) {
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            [_arrForSearch addObject:model];
        }
        
        [_tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        
    }];
}

#pragma mark - 搜索栏文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchText = searchText;
    if (searchText.length == 0) {
        self.tableView.hidden = YES;
        self.hotSearchView.hidden = NO;
    }
    else {
        self.hotSearchView.hidden = YES;
        self.tableView.hidden = NO;
        self.noDataSearchView.hidden = YES;
        
    }
    
    [self getSearchContentWithText:searchText];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
