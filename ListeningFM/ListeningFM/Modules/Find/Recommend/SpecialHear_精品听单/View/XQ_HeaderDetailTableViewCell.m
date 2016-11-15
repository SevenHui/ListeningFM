//
//  XQ_HeaderDetailTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HeaderDetailTableViewCell.h"

@interface XQ_HeaderDetailTableViewCell ()

@property (nonatomic, retain) UIImageView *coverSmallImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UIImageView *triangleImageView;
@property (nonatomic, retain) UILabel *playsCountsLabel;
@property (nonatomic, retain) UIImageView *timeImageView;
@property (nonatomic, retain) UILabel *durationLabel;

@end


@implementation XQ_HeaderDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self addSubview:_coverSmallImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        self.headImageView = [[UIImageView alloc] init];
        [self addSubview:_headImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self addSubview:_nicknameLabel];
        
        self.triangleImageView = [[UIImageView alloc] init];
        [self addSubview:_triangleImageView];
        
        self.playsCountsLabel = [[UILabel alloc] init];
        [self addSubview:_playsCountsLabel];
        
        self.timeImageView = [[UIImageView alloc] init];
        [self addSubview:_timeImageView];
        
        self.durationLabel = [[UILabel alloc] init];
        [self addSubview:_durationLabel];
                
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _coverSmallImageView.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.1, WIDTH * 0.17, HEIGHT * 0.65);
    
    _titleLabel.frame = CGRectMake(_coverSmallImageView.frame.origin.x * 2 + _coverSmallImageView.frame.size.width, _coverSmallImageView.frame.origin.y, _coverSmallImageView.frame.size.width * 4, _coverSmallImageView.frame.size.height * 0.45);
    _titleLabel.numberOfLines = 0;
    
    _nicknameLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height * 1.2, _titleLabel.frame.size.width, _titleLabel.frame.size.height * 0.8);
    _nicknameLabel.textColor = [UIColor grayColor];
    
    _triangleImageView.frame = CGRectMake(_nicknameLabel.frame.origin.x, _nicknameLabel.frame.origin.y + _nicknameLabel.frame.size.height * 1.3, WIDTH * 0.02, HEIGHT * 0.1);
    _triangleImageView.image = [UIImage imageNamed:@"find_albumcell_play"];
    
    _playsCountsLabel.frame = CGRectMake(_triangleImageView.frame.origin.x + _triangleImageView.frame.size.width * 1.5, _triangleImageView.frame.origin.y * 0.98, _triangleImageView.frame.size.width * 6, _triangleImageView.frame.size.height * 1.3);
    _playsCountsLabel.font = [UIFont systemFontOfSize:14];
    _playsCountsLabel.alpha = 0.5;
    
    _timeImageView.frame = CGRectMake(_playsCountsLabel.frame.origin.x + _playsCountsLabel.frame.size.width + _triangleImageView.frame.size.width, _triangleImageView.frame.origin.y, WIDTH * 0.03, HEIGHT * 0.1);
    _timeImageView.image = [UIImage imageNamed:@"top_history"];
   
    _durationLabel.frame = CGRectMake(_timeImageView.frame.origin.x + _timeImageView.frame.size.width * 1.5, _timeImageView.frame.origin.y * 0.98, _timeImageView.frame.size.width * 6, _timeImageView.frame.size.height * 1.3);
    _durationLabel.font = [UIFont systemFontOfSize:14];
    _durationLabel.alpha = 0.5;
    
    
    
}
- (void)setModel:(XQ_SmallEditorModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [_coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"me"]];
    
    _titleLabel.text = model.title;
    _nicknameLabel.text = model.nickname;
    
    if ([model.playsCounts integerValue] < 10000) {
        _playsCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.playsCounts integerValue]];
    }
    else{
        _playsCountsLabel.text = [NSString stringWithFormat:@"%.f万",[model.playsCounts floatValue] / 10000];
    }
    
    _timeImageView.image = [UIImage imageNamed:@"Unknown"];
    _durationLabel.text = [NSString stringWithFormat:@"%.2f",[model.duration floatValue] / 60];
    
    
}

@end
