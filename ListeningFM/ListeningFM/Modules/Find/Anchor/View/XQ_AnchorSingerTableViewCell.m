//
//  XQ_AnchorSingerTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AnchorSingerTableViewCell.h"

@interface XQ_AnchorSingerTableViewCell ()

/**封面图片*/
@property (nonatomic, retain) UIImageView *imageViewPhoto;
/**标题*/
@property (nonatomic, retain) UILabel *labelTitle;
/**简介*/
@property (nonatomic, retain) UILabel *labelDescribe;
/**声音数量图标*/
@property (nonatomic, retain) UIImageView *imageViewTracksCounts;
/**声音数量*/
@property (nonatomic, retain) UILabel *labelTracksCounts;
/**粉丝数量图标*/
@property (nonatomic, retain) UIImageView *imageViewFollowersCounts;
/**粉丝数量*/
@property (nonatomic, retain) UILabel *labelFollowersCounts;

@end

@implementation XQ_AnchorSingerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelTitle = [[UILabel alloc] init];
        [self addSubview:_labelTitle];
        
        self.labelDescribe = [[UILabel alloc] init];
        _labelDescribe.textColor = [UIColor grayColor];
        [self addSubview:_labelDescribe];
        
        self.imageViewTracksCounts = [[UIImageView alloc] init];
        _imageViewTracksCounts.image = [UIImage imageNamed:@"find_hotUser_sounds"];
        [self addSubview:_imageViewTracksCounts];
        
        self.labelTracksCounts = [[UILabel alloc] init];
        _labelTracksCounts.textColor = [UIColor grayColor];
        [self addSubview:_labelTracksCounts];
        
        self.imageViewFollowersCounts = [[UIImageView alloc] init];
        _imageViewFollowersCounts.image = [UIImage imageNamed:@"find_hotUser_fans"];
        [self addSubview:_imageViewFollowersCounts];
        
        self.labelFollowersCounts = [[UILabel alloc] init];
        _labelFollowersCounts.textColor = [UIColor grayColor];
        [self addSubview:_labelFollowersCounts];
        
        
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.04, HEIGHT * 0.2, WIDTH * 0.17, HEIGHT * 0.6);
    
    _labelTitle.frame = CGRectMake(_imageViewPhoto.frame.origin.x * 2 + _imageViewPhoto.frame.size.width, _imageViewPhoto.frame.origin.y, _imageViewPhoto.frame.size.width * 3.4, _imageViewPhoto.frame.size.height * 0.35);
    
    _labelDescribe.frame = CGRectMake(_labelTitle.frame.origin.x, _labelTitle.frame.origin.y + _labelTitle.frame.size.height * 1.2, _labelTitle.frame.size.width, _labelTitle.frame.size.height * 0.8);
    
    _imageViewTracksCounts.frame =
    CGRectMake(_labelDescribe.frame.origin.x,
               _labelDescribe.frame.origin.y + _labelDescribe.frame.size.height * 1.3,
               WIDTH * 0.03, HEIGHT * 0.1);
    
    _labelTracksCounts.frame = CGRectMake(_imageViewTracksCounts.frame.origin.x + _imageViewTracksCounts.frame.size.width * 1.5, _imageViewTracksCounts.frame.origin.y * 0.98, _imageViewTracksCounts.frame.size.width * 6, _imageViewTracksCounts.frame.size.height * 1.3);
    
    _imageViewFollowersCounts.frame =
    CGRectMake(_labelTracksCounts.frame.origin.x + _labelTracksCounts.frame.size.width + _imageViewTracksCounts.frame.size.width,
               _imageViewTracksCounts.frame.origin.y,
               WIDTH * 0.03, HEIGHT * 0.1);
    
    _labelFollowersCounts.frame = CGRectMake(_imageViewFollowersCounts.frame.origin.x + _imageViewFollowersCounts.frame.size.width * 1.5, _imageViewFollowersCounts.frame.origin.y * 0.98, _imageViewFollowersCounts.frame.size.width * 6, _imageViewFollowersCounts.frame.size.height * 1.3);
    
    
}


- (void)setModel:(XQ_AnchorListModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    
    [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:model.largeLogo] placeholderImage:[UIImage imageNamed:@"me"]];
    _labelTitle.text = model.nickname;
    _labelTracksCounts.text = [NSString stringWithFormat:@"%ld",model.tracksCounts];
    _labelDescribe.text = model.personDescribe;
    if (model.followersCounts < 10000) {
        _labelFollowersCounts.text = [NSString stringWithFormat:@"%ld", model.followersCounts];
    } else {
        _labelFollowersCounts.text = [NSString stringWithFormat:@"%ld万", (model.followersCounts) / 10000];
    }
    
}

@end
