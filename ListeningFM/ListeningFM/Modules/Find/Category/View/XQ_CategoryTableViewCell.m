//
//  XQ_CategoryTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/24.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_CategoryTableViewCell.h"
#import "XQ_CategoryCollectionViewCell.h"
#import "XQ_CategoryModel.h"

@interface XQ_CategoryTableViewCell ()
<UICollectionViewDataSource, UICollectionViewDelegate>
/**分割线*/
@property (nonatomic, retain) UIView *lineView;
/**注释*/
@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation XQ_CategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 分割线
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    _lineView.frame = CGRectMake(0, 0, WIDTH, HEIGHT * 0.08);
    [self addSubview:_lineView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH / 2, (HEIGHT - _lineView.bounds.size.height) / 3);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _lineView.bounds.size.height, WIDTH, HEIGHT - _lineView.bounds.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    // 关闭滑动功能
    self.collectionView.scrollEnabled = NO;
    
    [_collectionView registerClass:[XQ_CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XQ_CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (_arrCategory.count != 0) {
        
        cell.model = [_arrCategory objectAtIndex:indexPath.item + _numIndexPath * 6];
        
    }
    
    
    return cell;
    
}

- (void)setArrCategory:(NSMutableArray *)arrCategory {
    if (_arrCategory != arrCategory) {
        _arrCategory = arrCategory;
    }
    
    [_collectionView reloadData];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XQ_HotRecommendsViewController *recVC = [[XQ_HotRecommendsViewController alloc] init];
    
    if (_arrCategory.count != 0) {
        recVC.model = _arrCategory[indexPath.item + _numIndexPath * 6];
        
    }
    [[self naviController] pushViewController:recVC animated:YES];
    

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
