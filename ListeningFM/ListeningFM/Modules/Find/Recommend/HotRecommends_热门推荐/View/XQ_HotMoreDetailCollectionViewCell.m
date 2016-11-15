//
//  XQ_HotMoreDetailCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HotMoreDetailCollectionViewCell.h"
#import "XQ_SmallEditorMoreTableViewCell.h"
#import "SDCycleScrollView.h"
#import "XQ_HotRecModel.h"

@interface XQ_HotMoreDetailCollectionViewCell ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) SDCycleScrollView *sdScrollView;

@end

@implementation XQ_HotMoreDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100 * lfheight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN * 0.25)];
        view.backgroundColor = [UIColor redColor];
        _tableView.tableHeaderView = view;
        self.sdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:view.bounds delegate:self placeholderImage:[UIImage imageNamed:@"live_btn_image"]];
        [view addSubview:_sdScrollView];
        [self addSubview:_tableView];
        [_tableView registerClass:[XQ_SmallEditorMoreTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
    }
    return self;
    
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
    
    XQ_HotRecModel *model = _mainArray[section];
    labelTitle.font = [UIFont systemFontOfSize:14];
    labelTitle.text = model.title;
    [lineView addSubview:labelTitle];
    

    
    return view;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mainArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XQ_HotRecModel *model = _mainArray[section];
    return model.arrayList.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQ_SmallEditorMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XQ_HotRecModel *model = _mainArray[indexPath.section];
    cell.model = model.arrayList[indexPath.row];
    return cell;
}
- (void)setTopscrollviewArray:(NSMutableArray *)topscrollviewArray{
    if (_topscrollviewArray != topscrollviewArray) {
        _topscrollviewArray = topscrollviewArray;
    }
    _sdScrollView.imageURLStringsGroup = topscrollviewArray;
    
}
- (void)setMainArray:(NSMutableArray *)mainArray{
    if (_mainArray != mainArray) {
        _mainArray = mainArray;
    }
    
    [_tableView reloadData];
    
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
