//
//  XQ_SearchContentTableViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQ_SmallEditorModel;

@interface XQ_SearchContentTableViewCell : UITableViewCell

@property(nonatomic, retain)UIImageView *leftImageView;
@property(nonatomic, retain)UILabel *titleLbel;
@property(nonatomic, retain)UILabel *categoryLabel;
@property(nonatomic, retain)XQ_SmallEditorModel *model;
@property(nonatomic, copy)NSString *searchText;

@end
