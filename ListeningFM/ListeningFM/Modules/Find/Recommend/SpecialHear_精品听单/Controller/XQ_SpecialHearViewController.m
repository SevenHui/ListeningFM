//
//  XQ_SpecialHearViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SpecialHearViewController.h"
#import "XQ_SpecialHearTableViewCell.h"
#import "XQ_SmallEditorModel.h"
#import "XQ_HearingDetailViewController.h"

@interface XQ_SpecialHearViewController ()
<UITableViewDelegate,UITableViewDataSource>

/**主视图*/
@property (nonatomic, retain) UITableView *tableView;
/**时间戳*/
@property (nonatomic, retain) NSDateFormatter *objDateformat;
/**数据源数组*/
@property (nonatomic, retain) NSMutableArray *dataSource;
/**时间戳数据数组*/
@property (nonatomic, retain) NSMutableArray *timeArray;
/**字典*/
@property (nonatomic, retain) NSMutableDictionary *bigDic;
/**页数*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation XQ_SpecialHearViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    self.dataSource = [NSMutableArray array];
    self.bigDic= [NSMutableDictionary dictionary];
    // 时间戳数组初始化
    self.timeArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    self.navigationItem.title  = @"精品听单";
    
    [self createNavigation];
    
    
    [self getData:1];
    
    [self createTableView];

    

}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -HEIGHTSCREEN * 0.02, WIDTHSCREEN, HEIGHTSCREEN - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    // 注册cell
    [_tableView registerClass:[XQ_SpecialHearTableViewCell class] forCellReuseIdentifier:@"cell"];

    // 上拉加载
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getDownData];
        [_tableView.mj_footer endRefreshing];
        
    }];
    


}
#pragma mark - 时间戳数据
- (NSString *)setString:(NSString *)str{
    NSString * timeStampString = str;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM/yyyy"];
    NSString *key =[objDateformat stringFromDate: date];
    return key;
}
#pragma mark - 自定义分区头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WIDTHSCREEN * 0.15;
}
#pragma mark - 自定义分区头标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *key = [self.dataSource objectAtIndex:section];
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
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageViewAngle.bounds.size.width * 2, lineView.bounds.size.height * 0.2, imageViewAngle.bounds.size.width * 12, lineView.bounds.size.height * 0.6)];
    labelTitle.text = key;
    [lineView addSubview:labelTitle];
    

    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [_dataSource objectAtIndex:section];
    NSMutableArray *array = [_bigDic objectForKey:key];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQ_SpecialHearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = _dataSource[indexPath.section];
    NSMutableArray *array = [_bigDic objectForKey:key];
    cell.specialHearModel = array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_HearingDetailViewController *headerDetailVC = [[XQ_HearingDetailViewController alloc] init];
    if (_dataSource.count != 0) {
        NSString *key = _dataSource[indexPath.section];
        NSMutableArray *array = [_bigDic objectForKey:key];
        headerDetailVC.model = array[indexPath.row];;
        [self.navigationController pushViewController:headerDetailVC animated:YES]
        ;    }
}


#pragma mark - 上拉加载
- (void)getDownData {
    _page++;
    [self getData:_page];
}

#pragma mark -- 解析数据
- (void)getData:(NSInteger)page{
    NSString *string =[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_list?device=android&page=%ld&per_page=10",page];
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"specia" WithPath:@"specia.plist"];
        
        
        NSMutableArray *array = [dic objectForKey:@"list"];
        for (NSDictionary *dic in array) {
            NSString *key = [self setString:[dic objectForKey:@"releasedAt"]];
            
            NSMutableArray *array2= [_bigDic objectForKey:key];
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            if (array2.count == 0) {
                array2 = [NSMutableArray array];
                [self.bigDic setObject:array2 forKey:key];
                [self.dataSource addObject:key];
            }
            [array2 addObject:model];
            
        }
        
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"specia" WithPath:@"specia.plist"];
        
        
        NSMutableArray *array = [dic objectForKey:@"list"];
        for (NSDictionary *dic in array) {
            NSString *key = [self setString:[dic objectForKey:@"releasedAt"]];
            
            NSMutableArray *array2= [_bigDic objectForKey:key];
            XQ_SmallEditorModel *model = [[XQ_SmallEditorModel alloc] initWithDic:dic];
            if (array2.count == 0) {
                array2 = [NSMutableArray array];
                [self.bigDic setObject:array2 forKey:key];
                [self.dataSource addObject:key];
            }
            [array2 addObject:model];
            
        }
        
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        
    }];
    
    
    
}

@end
