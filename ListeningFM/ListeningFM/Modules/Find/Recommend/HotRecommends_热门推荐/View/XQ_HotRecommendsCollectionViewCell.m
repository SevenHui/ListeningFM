//
//  XQ_HotRecommendsCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HotRecommendsCollectionViewCell.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_HotRecommendsCollectionViewCell ()

/**封面图片*/
@property (nonatomic, retain) UIImageView *imageViewPhoto;
/**标题*/
@property (nonatomic, retain) UILabel *labelTrackTitle;
/**图标*/
@property (nonatomic, retain) UIImageView *imageViewSmallPhoto;
/**昵称*/
@property (nonatomic, retain) UILabel *labelTitle;
/**播放图标*/
@property (nonatomic, retain) UIImageView *imageViewplay;

@end

@implementation XQ_HotRecommendsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelTrackTitle = [[UILabel alloc] init];
        _labelTrackTitle.numberOfLines = 2;
        [self addSubview:_labelTrackTitle];
        
        self.imageViewSmallPhoto = [[UIImageView alloc] init];
        _imageViewSmallPhoto.image = [UIImage imageNamed:@"find_specialicon"];
        [self addSubview:_imageViewSmallPhoto];
        
        self.labelTitle = [[UILabel alloc] init];
        _labelTitle.textColor = [UIColor grayColor];
        _labelTitle.font = [UIFont systemFontOfSize:15];
        [self addSubview:_labelTitle];
        
        self.imageViewplay = [[UIImageView alloc] init];
        _imageViewplay.image = [UIImage imageNamed:@"find_track_play"];
        [self addSubview:_imageViewplay];
                
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(0, 0, WIDTH, WIDTH);
    
    _labelTrackTitle.frame = CGRectMake(0, _imageViewPhoto.frame.size.height * 1.05, _imageViewPhoto.frame.size.width, _imageViewPhoto.frame.size.height * 0.45);
    
    _imageViewSmallPhoto.frame = CGRectMake(0, _labelTrackTitle.frame.origin.y + _labelTrackTitle.frame.size.height * 1.12, _labelTrackTitle.frame.size.width * 0.1, HEIGHT * 0.07 * lfheight);
    
    _labelTitle.frame = CGRectMake(_imageViewSmallPhoto.frame.size.width, _imageViewPhoto.frame.size.height + _labelTrackTitle.frame.size.height, _labelTrackTitle.frame.size.width * 0.8, HEIGHT - _imageViewPhoto.frame.size.height - _labelTrackTitle.frame.size.height);
    
    _imageViewplay.frame = CGRectMake(_imageViewPhoto.frame.size.width * 0.75, _imageViewPhoto.frame.size.height * 0.75, _imageViewPhoto.frame.size.width * 0.2, _imageViewPhoto.frame.size.height * 0.2);
    
}

- (void)setHotRecListModel:(XQ_SmallEditorModel *)hotRecListModel {
    if (_hotRecListModel != hotRecListModel) {
        _hotRecListModel = hotRecListModel;
    }
    
    [self.imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:hotRecListModel.coverLarge] placeholderImage:[UIImage imageNamed:@"me"]];
    self.labelTrackTitle.text = hotRecListModel.trackTitle;
    self.labelTitle.text = hotRecListModel.title;

    
}

@end
