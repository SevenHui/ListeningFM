//
//  XQ_AnchorIntroduceTableViewCell.h
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQ_AnchorIntroduceModel.h"

@interface XQ_AnchorIntroduceTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *smallLogoImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *followersLabel;
@property (nonatomic, retain) UILabel *personalSignatureLabel;
@property (nonatomic, retain) XQ_AnchorIntroduceModel *model;


@end
