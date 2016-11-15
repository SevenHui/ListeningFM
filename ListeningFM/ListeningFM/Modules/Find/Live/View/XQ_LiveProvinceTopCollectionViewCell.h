//
//  XQ_LiveProvinceTopCollectionViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQ_LiveCategoriesModel;
@interface XQ_LiveProvinceTopCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, assign) BOOL didSelected;
@property (nonatomic, retain) XQ_LiveCategoriesModel *model;

@end
