//
//  XQ_HotMoreMainCollectionViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XQ_HotMoreMainCollectionViewCellDelegate <NSObject>

// 刷新数据的协议方法
- (void)getdelegateData:(NSInteger)page;

@end

@interface XQ_HotMoreMainCollectionViewCell : UICollectionViewCell
/**数据*/
@property (nonatomic, retain) NSMutableArray *listArray;
/**使用assign, 其他的会导致循环引用*/
@property (nonatomic, assign) id <XQ_HotMoreMainCollectionViewCellDelegate>delegate;


@end
