//
//  XQ_AnchorDetailTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/6.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AnchorDetailTableViewCell.h"
#import "XQ_AnchorDetailModel.h"

@interface XQ_AnchorDetailTableViewCell ()

@property (nonatomic, retain) UIImageView *imageViewTitle;
@property (nonatomic, retain) UILabel *labelTitle;
@property (nonatomic, retain) UIImageView *imageViewAngle;
@property (nonatomic, retain) UILabel *playtimesLabel;
@property (nonatomic, retain) UIImageView *timeImageView;
@property (nonatomic, retain) UILabel *durationLabel;
@property (nonatomic, retain) UIImageView *commmenImageView;
@property (nonatomic, retain) UILabel *commentsLabel;
@property (nonatomic, retain) UIButton *downloadButton;

@end

@implementation XQ_AnchorDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageViewTitle = [[UIImageView alloc] init];
        [self addSubview:_imageViewTitle];
        
        self.labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        [self addSubview:_labelTitle];
        
        self.imageViewAngle = [[UIImageView alloc] init];
        _imageViewAngle.alpha = 0.5;
        _imageViewAngle.image = [UIImage imageNamed:@"find_albumcell_play"];
        [self addSubview:_imageViewAngle];
        
        self.playtimesLabel = [[UILabel alloc] init];
        _playtimesLabel.font = [UIFont systemFontOfSize:14];
        _playtimesLabel.alpha = 0.5;
        [self addSubview:_playtimesLabel];
        
        self.timeImageView = [[UIImageView alloc] init];
        _timeImageView.alpha = 0.5;
        _timeImageView.image = [UIImage imageNamed:@"find_hotUser_sounds"];
        [self addSubview:_timeImageView];
        
        self.durationLabel = [[UILabel alloc] init];
        _durationLabel.alpha = 0.5;
        [self addSubview:_durationLabel];
        
        self.commmenImageView = [[UIImageView alloc] init];
        _commmenImageView.image = [UIImage imageNamed:@"xim_eye_on"];
        [self addSubview:_commmenImageView];

        self.commentsLabel = [[UILabel alloc] init];
        _commentsLabel.font = [UIFont systemFontOfSize:14];
        _commentsLabel.alpha = 0.5;
        [self addSubview:_commentsLabel];
        
        self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setImage:[UIImage imageNamed:@"cell_download"] forState:UIControlStateNormal];
        [self addSubview:_downloadButton];
        [_downloadButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewTitle.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.12, WIDTH * 0.15, WIDTH * 0.15);
    _imageViewTitle.layer.masksToBounds = YES;
    _imageViewTitle.layer.cornerRadius = WIDTH * 0.15 / 2;

    _labelTitle.frame = CGRectMake(_imageViewTitle.frame.origin.x * 2 + _imageViewTitle.frame.size.width * 1.2, _imageViewTitle.frame.origin.y, _imageViewTitle.frame.size.width * 4, _imageViewTitle.frame.size.height * 0.88);
    
    _imageViewAngle.frame = CGRectMake(_labelTitle.frame.origin.x, _labelTitle.frame.origin.y * 2 + _labelTitle.frame.size.height, WIDTH * 0.02, HEIGHT * 0.1);

    _playtimesLabel.frame = CGRectMake(_imageViewAngle.frame.origin.x + _imageViewAngle.frame.size.width * 1.5, _labelTitle.frame.origin.y * 1.7 + _labelTitle.frame.size.height, _imageViewAngle.frame.size.width * 6, HEIGHT * 0.17);
    
    _timeImageView.frame = CGRectMake(_playtimesLabel.frame.origin.x + _playtimesLabel.frame.size.width + _imageViewAngle.frame.size.width, _labelTitle.frame.origin.y * 2 + _labelTitle.frame.size.height, WIDTH * 0.02, HEIGHT * 0.1);
    
    _durationLabel.frame = CGRectMake(_timeImageView.frame.origin.x + _timeImageView.frame.size.width * 1.5, _labelTitle.frame.origin.y * 1.7 + _labelTitle.frame.size.height, _timeImageView.frame.size.width * 6, HEIGHT * 0.17);
    
    _commmenImageView.frame = CGRectMake(_durationLabel.frame.origin.x + _durationLabel.frame.size.width + _imageViewAngle.frame.size.width, _labelTitle.frame.origin.y * 2 + _labelTitle.frame.size.height, WIDTH * 0.02, HEIGHT * 0.1);
    
    _commentsLabel.frame = CGRectMake(_commmenImageView.frame.origin.x + _commmenImageView.frame.size.width * 1.5, _labelTitle.frame.origin.y * 1.7 + _labelTitle.frame.size.height, _commmenImageView.frame.size.width * 5, HEIGHT * 0.17);
    
    _downloadButton.frame = CGRectMake(WIDTH * 0.9, HEIGHT * 0.7, WIDTH * 0.07, HEIGHT * 0.25);
    
}

- (void)setModel:(XQ_AnchorDetailModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    [_imageViewTitle sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"me"]];
    _labelTitle.text = model.title;
    
    if ([model.playtimes integerValue] < 10000) {
        _playtimesLabel.text = [NSString stringWithFormat:@"%ld",[model.playtimes integerValue]];
    } else {
        _playtimesLabel.text = [NSString stringWithFormat:@"%.f万",[model.playtimes floatValue] / 10000];
    }
    _durationLabel.text = [NSString stringWithFormat:@"%.2f",[model.duration floatValue] / 60];
    if (![model.comments isEqual:@0]) {
        _commentsLabel.text = [NSString stringWithFormat:@"%ld",[model.comments integerValue]];
    } else {
        _commmenImageView.hidden = YES;
        _commentsLabel.hidden = YES;
    }

}
#pragma mark - 下载
- (void)downloadButtonAction:(UIButton *)downloadButton {
    [downloadButton setImage:[UIImage imageNamed:@"cell_downloaded"] forState:UIControlStateNormal];
}

@end
