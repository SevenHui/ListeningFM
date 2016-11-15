//
//  XQ_ParticularsTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_ParticularsTableViewCell.h"

@interface XQ_ParticularsTableViewCell ()
@property (nonatomic, retain) UIImageView *coverMiddleImageView;

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *triangleImageView;
@property (nonatomic, retain) UILabel *playtimesLabel;
@property (nonatomic, retain) UILabel *commentsLabel;
@property (nonatomic, retain) UIImageView *timeImageView;
@property (nonatomic, retain) UILabel *durationLabel;
@property (nonatomic, retain) UIImageView *commmenImageView;

@end

@implementation XQ_ParticularsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.coverMiddleImageView = [[UIImageView alloc] init];
        [self addSubview:_coverMiddleImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        self.triangleImageView = [[UIImageView alloc] init];
        [self addSubview:_triangleImageView];
        
        self.playtimesLabel = [[UILabel alloc] init];
        [self addSubview:_playtimesLabel];
        
        self.commentsLabel = [[UILabel alloc] init];
        [self addSubview:_commentsLabel];
        
        self.commmenImageView = [[UIImageView alloc] init];
        [self addSubview:_commmenImageView];
        
        self.timeImageView = [[UIImageView alloc] init];
        [self addSubview:_timeImageView];
        
        self.durationLabel = [[UILabel alloc] init];
        [self addSubview:_durationLabel];
        

        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _coverMiddleImageView.frame = CGRectMake(WIDTH * 0.04, HEIGHT * 0.15, HEIGHT * 0.6, HEIGHT * 0.6);
    _coverMiddleImageView.layer.masksToBounds = YES;
    _coverMiddleImageView.layer.cornerRadius = HEIGHT * 0.6 / 2;
    
    _titleLabel.frame = CGRectMake(_coverMiddleImageView.frame.origin.x * 2 + _coverMiddleImageView.frame.size.width, _coverMiddleImageView.frame.origin.y, _coverMiddleImageView.frame.size.width * 3.8, _coverMiddleImageView.frame.size.height * 0.45);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines = 0;
    
    _triangleImageView.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y * 1.3 + _titleLabel.frame.size.height, WIDTH * 0.03, HEIGHT * 0.12);
    
    _playtimesLabel.frame = CGRectMake(_triangleImageView.frame.origin.x + _triangleImageView.frame.size.width * 1.5, _triangleImageView.frame.origin.y * 0.98, _triangleImageView.frame.size.width * 5, _triangleImageView.frame.size.height * 1.2);
    _playtimesLabel.font = [UIFont systemFontOfSize:14];
    _playtimesLabel.alpha = 0.5;
    
    _timeImageView.frame = CGRectMake(_playtimesLabel.frame.origin.x + _playtimesLabel.frame.size.width + _triangleImageView.frame.size.width, _triangleImageView.frame.origin.y, WIDTH * 0.03, HEIGHT * 0.12);
    
    _durationLabel.frame = CGRectMake(_timeImageView.frame.origin.x + _timeImageView.frame.size.width * 1.5, _timeImageView.frame.origin.y * 0.98, _timeImageView.frame.size.width * 4, _timeImageView.frame.size.height * 1.2);
    _durationLabel.font = [UIFont systemFontOfSize:14];
    _durationLabel.alpha = 0.5;
    
    _commmenImageView.frame = CGRectMake(_durationLabel.frame.origin.x + _durationLabel.frame.size.width + _triangleImageView.frame.size.width, _triangleImageView.frame.origin.y, WIDTH * 0.03, HEIGHT * 0.12);
    
    _commentsLabel.frame = CGRectMake(_commmenImageView.frame.origin.x + _commmenImageView.frame.size.width * 1.5, _commmenImageView.frame.origin.y * 0.98, _commmenImageView.frame.size.width * 4, _commmenImageView.frame.size.height * 1.2);
    _commentsLabel.alpha = 0.5;
    _commentsLabel.font = [UIFont systemFontOfSize:14];
    
    
}
- (void)setModel:(XQ_SmallEditorModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [_coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:@"user_head_comment"]];
    _triangleImageView.image = [UIImage imageNamed:@"find_albumcell_play"];
    _titleLabel.text = model.title;
    
    if ([model.playtimes integerValue] < 10000) {
        _playtimesLabel.text = [NSString stringWithFormat:@"%ld",[model.playtimes integerValue]];
    }
    
    else {
        _playtimesLabel.text = [NSString stringWithFormat:@"%.f万",[model.playtimes floatValue] / 10000];
    }
    
    _timeImageView.image = [UIImage imageNamed:@"top_history"];
    _durationLabel.text = [NSString stringWithFormat:@"%.2f",[model.duration floatValue] / 60];
   
    if (![model.comments isEqual:@0]) {
        _commmenImageView.image = [UIImage imageNamed:@"find_specialicon"];
        _commentsLabel.text = [NSString stringWithFormat:@"%@",model.comments];
    }
    else{
        _commmenImageView.hidden = YES;
        _commentsLabel.hidden = YES;
    }
    
    
}


@end
