//
//  XQ_CategoryTableViewCell.h
//  ListeningFM
//
//  Created by apple on 16/9/24.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQ_HotRecommendsViewController.h"
@interface XQ_CategoryTableViewCell : UITableViewCell

/**传值数组*/
@property (nonatomic, retain) NSMutableArray *arrCategory;
/**个数*/
@property (nonatomic, assign) NSInteger numIndexPath;


@end
