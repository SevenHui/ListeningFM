//
//  XQ_LiveCell.h
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQ_LiveCell : UICollectionViewCell

@property (nonatomic, copy)void(^block)(XQ_AudioPlayVC *);

/**本地分区数据*/
@property (nonatomic, retain) NSMutableArray *arrLocal;
/**排行榜分区数据*/
@property (nonatomic, retain) NSMutableArray *arrTop;

@end
