//
//  XQ_rankingAnchorDetailTableViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQ_RankingModel;
@interface XQ_rankingAnchorDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) XQ_RankingModel *model;

@property (nonatomic, assign) NSInteger number;

@end
