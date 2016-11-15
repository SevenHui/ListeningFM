//
//  XQ_CategoryCell.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_CategoryCell.h"
#import "XQ_HotRecModel.h"
#import "XQ_CategoryTableViewCell.h"

@interface XQ_CategoryCell ()
<UITableViewDataSource, UITableViewDelegate>

/**主界面视图*/
@property (nonatomic, retain) UITableView *tableView;
/**头视图图片*/
@property (nonatomic, retain) UIImageView *headerViewImage;
/**分类数据*/
@property (nonatomic, retain) NSMutableArray *arrCategory;

@end

@implementation XQ_CategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrCategory = [NSMutableArray array];
        [self getDataFromJsonOfCategory];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 180 * lfheight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[XQ_CategoryTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    
    [self createHeaderView];
    
}

#pragma mark - 头视图
- (void)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.28)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.headerViewImage = [[UIImageView alloc] initWithFrame:headerView.frame];
    _headerViewImage.image = [UIImage imageNamed:@"live_btn_image"];
    [headerView addSubview:_headerViewImage];
    _tableView.tableHeaderView = headerView;
    

}

#pragma mark - Cell的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
#pragma mark - Cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (_arrCategory.count != 0) {
        cell.arrCategory = _arrCategory;
        cell.numIndexPath = indexPath.row;
    }
    
    
    return cell;
}


#pragma mark - 分类的数据
- (void)getDataFromJsonOfCategory {
    [_arrCategory removeAllObjects];
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v1/categories?channel=and-f3&device=android&picVersion=13&scale=2";
    [XQNetTool GET:string Body:nil HeaderFile:nil Response:XQJSON Success:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        
        [XQArchiverTool archiverObject:dic ByKey:@"cate" WithPath:@"cate.plist"];
        
        
        NSMutableArray *arrList = dic[@"list"];
        
        // 头视图数据
        NSDictionary *dicHeaderImage = arrList[0];
        [_headerViewImage sd_setImageWithURL:[NSURL URLWithString:dicHeaderImage[@"coverPath"]]];
        
        NSMutableArray *arrOtherList = [NSMutableArray arrayWithArray:arrList];
        if (arrOtherList.count != 0) {
            [arrOtherList removeObjectAtIndex:0];
        }
        for (NSDictionary *dic in arrOtherList) {
            XQ_HotRecModel *model = [[XQ_HotRecModel alloc] initWithDic:dic];
            [_arrCategory addObject:model];
        }
        
        [_tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        
        NSDictionary *dic = [XQArchiverTool unarchiverObjectByKey:@"cate" WithPath:@"cate.plist"];
        
        
        NSMutableArray *arrList = dic[@"list"];
        
        // 头视图数据
        NSDictionary *dicHeaderImage = arrList[0];
        [_headerViewImage sd_setImageWithURL:[NSURL URLWithString:dicHeaderImage[@"coverPath"]]];
        
        NSMutableArray *arrOtherList = [NSMutableArray arrayWithArray:arrList];
        if (arrOtherList.count != 0) {
            [arrOtherList removeObjectAtIndex:0];
        }
        for (NSDictionary *dic in arrOtherList) {
            XQ_HotRecModel *model = [[XQ_HotRecModel alloc] initWithDic:dic];
            [_arrCategory addObject:model];
        }
        
        [_tableView reloadData];

        
    }];
    
}






@end
