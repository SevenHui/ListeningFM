//
//  XQ_LiveProvinceMainCollectionViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XQ_LiveProvinceMainCollectionViewCellDlegate <NSObject>

- (void)getDelegateData:(NSInteger)pageNumber;

@end

@interface XQ_LiveProvinceMainCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain)NSMutableArray *array;

@property (nonatomic, assign) id<XQ_LiveProvinceMainCollectionViewCellDlegate>delegate;

@property (nonatomic, copy)void(^block)(XQ_AudioPlayVC *);

@end
