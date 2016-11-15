//
//  XQ_SmallEditorCollectionViewCell.h
//  ListeningFM
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQ_SmallEditorCollectionViewCell : UICollectionViewCell

/**封面图片*/
@property (nonatomic, retain) UIImageView *imageViewPhoto;
/**标题*/
@property (nonatomic, retain) UILabel *labelTrackTitle;
/**图标*/
@property (nonatomic, retain) UIImageView *imageViewSmallPhoto;
/**昵称*/
@property (nonatomic, retain) UILabel *labelTitle;

@end
