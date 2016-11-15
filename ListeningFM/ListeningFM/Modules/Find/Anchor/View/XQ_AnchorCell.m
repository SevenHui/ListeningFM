//
//  XQ_AnchorCell.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AnchorCell.h"
#import "XQ_AnchorModel.h"
#import "XQ_AnchorListModel.h"
#import "XQ_AnchorTableViewCell.h"
#import "XQ_AnchorSingerTableViewCell.h"
// 更多跳转
#import "XQ_AnchorFamousMoreViewController.h"
#import "XQ_AnchorNormalMoreViewController.h"
// 详情
#import "XQ_AnchorDetailViewController.h"

@interface XQ_AnchorCell ()
<UITableViewDataSource, UITableViewDelegate>

/**主界面视图*/
@property (nonatomic, retain) UITableView *tableView;
/**前四个分区数据*/
@property (nonatomic, retain) NSMutableArray *arrFamousTitle;
/**后面分区数据*/
@property (nonatomic, retain) NSMutableArray *arrNormalTitle;
/**歌手分区数据*/
@property (nonatomic, retain) NSMutableArray *arrSinger;

@end

@implementation XQ_AnchorCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrFamousTitle = [NSMutableArray array];
        self.arrNormalTitle = [NSMutableArray array];
        self.arrSinger = [NSMutableArray array];
        
        [self getDataFromJsonOfAnchor];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20 * lfheight, WIDTH, HEIGHT - 49) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.contentView addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 注册前三分区cell
        [_tableView registerClass:[XQ_AnchorTableViewCell class] forCellReuseIdentifier:@"famousThirdCell"];
        // 注册歌手分区cell
        [_tableView registerClass:[XQ_AnchorSingerTableViewCell class] forCellReuseIdentifier:@"famousOfSingerCell"];
        // 注册后面分区cell
        [_tableView registerClass:[XQ_AnchorTableViewCell class] forCellReuseIdentifier:@"normalCell"];
        
        
    }
    return self;
    
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
    // 头标题
    if (section < 4) {
        if (_arrFamousTitle.count != 0) {
            XQ_AnchorModel *model = _arrFamousTitle[section];
            labelTitle.text = model.title;
        }
    }
    else {
        if (_arrNormalTitle.count != 0) {
            XQ_AnchorModel *model = _arrNormalTitle[section - 4];
            labelTitle.text = model.title;
        }
    }
    // 更多
    UIButton *buttonMore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonMore.frame = CGRectMake(lineView.bounds.size.width * 0.8, lineView.bounds.size.height * 0.2, lineView.bounds.size.width * 0.2, lineView.bounds.size.height * 0.6);
    [buttonMore setTitle:@"更多 〉" forState:UIControlStateNormal];
    [buttonMore setTitle:@"更多 〉" forState:UIControlStateHighlighted];
    [buttonMore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonMore setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [lineView addSubview:buttonMore];
    if (section < 4) {
        buttonMore.tag = 10000 + section;
        [buttonMore addTarget:self action:@selector(famousMoreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (section >= 4) {
        buttonMore.tag = 10000 + section - 4;
        [buttonMore addTarget:self action:@selector(normalMoreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return view;
    
}

#pragma mark - 分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrFamousTitle.count + _arrNormalTitle.count;
    
}
#pragma mark - Cell的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return _arrSinger.count;
    }
    return 1;
}
#pragma mark - Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 3) {
        return 420 * lfheight;
    }
    if (indexPath.section == 3) {
        return 640 * lfheight / _arrSinger.count;
    }
    else {
        return 210 * lfheight;
    }
}
#pragma mark - Cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 前三分区Cell
    if (indexPath.section < 3) {
        XQ_AnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"famousThirdCell"];
        
        if (_arrFamousTitle.count != 0) {
            
            cell.anchorModel = _arrFamousTitle[indexPath.section];
            
        }
        
        return cell;
        
    }
    // 歌手分区Cell
    else if (indexPath.section == 3) {
        XQ_AnchorSingerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"famousOfSingerCell"];
        
        if (_arrSinger.count != 0) {
            
            cell.model = _arrSinger[indexPath.row];
            
        }
        
        return cell;
        
    }
    else {
        // 后面分区Cell
        XQ_AnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];
        
        if (_arrNormalTitle.count != 0) {
            
            cell.anchorModel = _arrNormalTitle[indexPath.section - 4];
            
        }
        return cell;
        
    }
    
}
#pragma mark - 详情界面的跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
    XQ_AnchorDetailViewController *anchorDetailVC = [[XQ_AnchorDetailViewController alloc] init];
    anchorDetailVC.model = [_arrSinger objectAtIndex:indexPath.row];
    [[self naviController] pushViewController:anchorDetailVC animated:YES];
    }
}

#pragma mark - 跳转界面点击事件
// 前四
- (void)famousMoreButtonAction:(UIButton *)famousButtonMore {
    
    XQ_AnchorFamousMoreViewController *famousMoreVC = [[XQ_AnchorFamousMoreViewController alloc] init];
    
    XQ_AnchorModel *model = _arrFamousTitle[famousButtonMore.tag - 10000];
    famousMoreVC.model = model;
    
    [[self naviController] pushViewController:famousMoreVC animated:YES];
    
    
}
// 后四
- (void)normalMoreButtonAction:(UIButton *)normalMoreButton {
    
    XQ_AnchorNormalMoreViewController *normalMoreVC = [[XQ_AnchorNormalMoreViewController alloc] init];
    
    XQ_AnchorModel *model = _arrNormalTitle[normalMoreButton.tag - 10000];
    normalMoreVC.model = model;
    
    [[self naviController] pushViewController:normalMoreVC animated:YES];
    
    
}
#pragma mark - 主播数据
- (void)getDataFromJsonOfAnchor {
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.33";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"anchorFSN" WithPath:@"anchorFSN.plist"];
        
        
        // 主播前四个分区数据
        NSMutableArray *arrFamous = dic[@"famous"];
        for (NSDictionary *dic in arrFamous) {
            XQ_AnchorModel *model = [[XQ_AnchorModel alloc] initWithDic:dic];
            [_arrFamousTitle addObject:model];
        }
        // 歌手分区数据
        NSDictionary *dicSinger = arrFamous[3];
        NSMutableArray *arrSingeList = dicSinger[@"list"];
        for (NSDictionary *dic in arrSingeList) {
            XQ_AnchorListModel *model = [[XQ_AnchorListModel alloc] initWithDic:dic];
            [_arrSinger addObject:model];
        }
        // 主播后面分区数据
        NSMutableArray *arrNormal = dic[@"normal"];
        NSMutableArray *arrNormals = [NSMutableArray arrayWithArray:arrNormal];
        [arrNormals removeLastObject];
        for (NSDictionary *dic in arrNormals) {
            XQ_AnchorModel *model = [[XQ_AnchorModel alloc] initWithDic:dic];
            [_arrNormalTitle addObject:model];
        }
        
        [_tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"anchorFSN" WithPath:@"anchorFSN.plist"];
        
        
        // 主播前四个分区数据
        NSMutableArray *arrFamous = dic[@"famous"];
        for (NSDictionary *dic in arrFamous) {
            XQ_AnchorModel *model = [[XQ_AnchorModel alloc] initWithDic:dic];
            [_arrFamousTitle addObject:model];
        }
        // 歌手分区数据
        NSDictionary *dicSinger = arrFamous[3];
        NSMutableArray *arrSingeList = dicSinger[@"list"];
        for (NSDictionary *dic in arrSingeList) {
            XQ_AnchorListModel *model = [[XQ_AnchorListModel alloc] initWithDic:dic];
            [_arrSinger addObject:model];
        }
        // 主播后面分区数据
        NSMutableArray *arrNormal = dic[@"normal"];
        NSMutableArray *arrNormals = [NSMutableArray arrayWithArray:arrNormal];
        [arrNormals removeLastObject];
        for (NSDictionary *dic in arrNormals) {
            XQ_AnchorModel *model = [[XQ_AnchorModel alloc] initWithDic:dic];
            [_arrNormalTitle addObject:model];
        }
        
        [_tableView reloadData];

        
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



@end
