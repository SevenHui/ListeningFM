//
//  XQ_LiveProvinceMainCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveProvinceMainCollectionViewCell.h"
#import "XQ_LiveTableViewCell.h"

@interface XQ_LiveProvinceMainCollectionViewCell ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) NSInteger pNumber;

@end

@implementation XQ_LiveProvinceMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pNumber = 1;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.delegate getDelegateData:1];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pNumber++;
            [self.delegate getDelegateData:_pNumber];
            
        }];
        
        [_tableView registerClass:[XQ_LiveTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
    }
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * lfheight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQ_LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_array.count != 0) {
        cell.liveRadiosModel = _array[indexPath.row];
    }
    return cell;
    
}
#pragma mark - 跳转播放界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XQ_AudioPlayVC *audioPlauVC = [XQ_AudioPlayVC shareDetailViewController];

    audioPlauVC.model = _array[indexPath.row];
        audioPlauVC.musicArr = _array;
        audioPlauVC.index = indexPath.row;
        // 通知按钮旋转,播放及按钮改变图片和状态
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    
    self.block(audioPlauVC);
    
    
}

- (void)setArray:(NSMutableArray *)array{
    if (_array != array) {
        _array = array;
    }
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}


@end
