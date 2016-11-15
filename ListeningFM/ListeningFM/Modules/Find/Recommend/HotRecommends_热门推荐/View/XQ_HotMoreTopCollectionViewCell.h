//
//  XQ_HotMoreTopCollectionViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQ_HotRecModel.h"

@interface XQ_HotMoreTopCollectionViewCell : UICollectionViewCell

/**导航名*/
@property (nonatomic, retain) UILabel *label;
/**监听变量*/
@property (nonatomic, assign) BOOL didSelected;
/**数据模型*/
@property (nonatomic, retain) XQ_HotRecModel *model;

@end
