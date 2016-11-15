//
//  XQ_LiveTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveTableViewCell.h"
#import "XQ_LiveRadiosModel.h"

@interface XQ_LiveTableViewCell()

/**封面*/
@property (nonatomic, retain) UIImageView *imageViewPhoto;
/**电台标题*/
@property (nonatomic, retain) UILabel *labelTitle;
/**节目单*/
@property (nonatomic, retain) UILabel *labelName;
/**收听人数图标*/
@property (nonatomic, retain) UIImageView *imageViewSmall;
/**收听人数*/
@property (nonatomic, retain) UILabel *labelNumber;
/**播放图标*/
@property (nonatomic, retain) UIButton *buttonPlay;

@end

@implementation XQ_LiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelTitle = [[UILabel alloc] init];
        [self addSubview:_labelTitle];
        
        self.labelName = [[UILabel alloc] init];
        _labelName.textColor = [UIColor grayColor];
        [self addSubview:_labelName];
        
        self.imageViewSmall = [[UIImageView alloc] init];
        _imageViewSmall.image = [UIImage imageNamed:@"find_albumcell_play"];
        [self addSubview:_imageViewSmall];
        
        self.labelNumber = [[UILabel alloc] init];
        _labelNumber.textColor = [UIColor grayColor];
        [self addSubview:_labelNumber];
        
        self.buttonPlay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonPlay setImage:[UIImage imageNamed:@"find_hotuser_play"] forState:UIControlStateNormal];
        [self addSubview:_buttonPlay];
        
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.04, HEIGHT * 0.17, WIDTH * 0.18, HEIGHT * 0.66);
    
    _labelTitle.frame = CGRectMake(_imageViewPhoto.frame.size.width + _imageViewPhoto.frame.origin.x * 2, _imageViewPhoto.frame.origin.y, _imageViewPhoto.frame.size.width * 3, _imageViewPhoto.frame.size.height * 0.35);
    
    _labelName.frame = CGRectMake(_labelTitle.frame.origin.x, _labelTitle.frame.origin.y * 1.1 + _labelTitle.frame.size.height, _labelTitle.frame.size.width * 1.1, _labelTitle.frame.size.height);
    
    _imageViewSmall.frame = CGRectMake(_labelName.frame.origin.x, _labelName.frame.origin.y * 1.2 + _labelName.frame.size.height, _labelName.frame.size.width * 0.04, _labelName.frame.size.height * 0.4);
    
    _labelNumber.frame = CGRectMake(_imageViewSmall.frame.origin.x + _imageViewSmall.frame.size.width * 1.5, _labelName.frame.origin.y * 1.1 + _labelName.frame.size.height, _imageViewSmall.frame.size.width * 12, _imageViewSmall.frame.size.height * 1.7);
    
    _buttonPlay.frame = CGRectMake(WIDTH * 0.88, HEIGHT * 0.38, WIDTH * 0.07, HEIGHT * 0.24);
    
}

- (void)setLiveRadiosModel:(XQ_LiveRadiosModel *)liveRadiosModel {
    if (_liveRadiosModel != liveRadiosModel) {
        _liveRadiosModel = liveRadiosModel;
    }
    
    [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:liveRadiosModel.coverLarge] placeholderImage:[UIImage imageNamed:@"me"]];
    _labelTitle.text = liveRadiosModel.title;
    if (liveRadiosModel.programName != nil) {
        _labelName.text = [NSString stringWithFormat:@"正在直播:  %@", liveRadiosModel.programName];
    }
    else {
        _labelName.text = @"暂无节目单";
    }
    _labelNumber.text = [NSString stringWithFormat:@"%.2lf万人",[liveRadiosModel.playCount floatValue] / 10000];
    
    
}


@end
