//
//  XQ_MainProgramDetailCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_MainProgramDetailCollectionViewCell.h"
#import "XQ_TwoProgramDetailTableViewCell.h"
#import "XQ_ThreeProgramDetailTableViewCell.h"
// 跳转详情界面
#import "XQ_AlbumDetailViewController.h"

@interface XQ_MainProgramDetailCollectionViewCell ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation XQ_MainProgramDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        [_tableView registerClass:[XQ_TwoProgramDetailTableViewCell class] forCellReuseIdentifier:@"twoCell"];
        
        [_tableView registerClass:[XQ_ThreeProgramDetailTableViewCell class] forCellReuseIdentifier:@"threeCell"];
        
        
    }
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_titleString isEqualToString:@"track"]){
        return _firstArray.count;
    }
    return _firstArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * lfheight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_titleString isEqualToString:@"track"]) {
        XQ_TwoProgramDetailTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        twoCell.model = [_firstArray objectAtIndex:indexPath.row];
        twoCell.labelInter = indexPath.row + 1;
        return twoCell;
    
    }
    
    XQ_ThreeProgramDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
    cell.model = [_firstArray objectAtIndex:indexPath.row];
    cell.labelInter = indexPath.row + 1;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XQ_AlbumDetailViewController *albumVC = [[XQ_AlbumDetailViewController alloc] init];
    albumVC.model = _firstArray[indexPath.row];
    [[self naviController] pushViewController:albumVC animated:YES];

}
- (void)setFirstArray:(NSMutableArray *)firstArray {
    if (_firstArray != firstArray) {
        _firstArray = firstArray;
    }
    
    [_tableView reloadData];
    
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
