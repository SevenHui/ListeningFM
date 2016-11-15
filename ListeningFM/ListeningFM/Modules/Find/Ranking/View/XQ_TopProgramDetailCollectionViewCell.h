//
//  XQ_TopProgramDetailCollectionViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQ_RankingModel;
@interface XQ_TopProgramDetailCollectionViewCell : UICollectionViewCell

/**导航标题*/
@property (nonatomic, retain) UILabel *topLabel;
/**导航线*/
@property (nonatomic, retain) UILabel *lineLabel;

@property (nonatomic, retain) XQ_RankingModel *model;

@property (nonatomic, assign) BOOL didSelected;

@end
