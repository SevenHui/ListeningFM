//
//  XQ_ThreeProgramDetailTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_ThreeProgramDetailTableViewCell.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_ThreeProgramDetailTableViewCell ()

@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UIImageView *coverSmallImageView;
@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UIImageView *roundImageView;
@property (nonatomic, retain) UILabel *tracksCountsLabel;

@end

@implementation XQ_ThreeProgramDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.numberLabel = [[UILabel alloc] init];
        [self addSubview:_numberLabel];
        
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self addSubview:_coverSmallImageView];
        
        self.titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLable];
        
        self.nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:14];
        _nicknameLabel.alpha = 0.5;
        [self addSubview:_nicknameLabel];
        
        self.roundImageView = [[UIImageView alloc] init];
        _roundImageView.image = [UIImage imageNamed:@"find_hotUser_sounds"];
        [self addSubview:_roundImageView];
        
        self.tracksCountsLabel = [[UILabel alloc] init];
        _tracksCountsLabel.alpha = 0.5;
        _tracksCountsLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_tracksCountsLabel];
        
        
        
    }
    return self;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _numberLabel.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.4, WIDTH * 0.04, HEIGHT * 0.2);
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.textColor = COLOR;
    _numberLabel.textAlignment = 1;
    
    _coverSmallImageView.frame = CGRectMake(_numberLabel.frame.origin.x * 2 + _numberLabel.frame.size.width, HEIGHT * 0.1, WIDTH * 0.2, HEIGHT * 0.75);
    
    _titleLable.frame = CGRectMake(_coverSmallImageView.frame.origin.x * 1.5 + _coverSmallImageView.frame.size.width, _coverSmallImageView.frame.origin.y, _coverSmallImageView.frame.size.width * 2, _coverSmallImageView.frame.size.height * 0.35);
    
    _nicknameLabel.frame = CGRectMake(_titleLable.frame.origin.x, _titleLable.frame.origin.y * 1.5 + _titleLable.frame.size.height, _titleLable.frame.size.width * 1.4, _titleLable.frame.size.height * 0.9);
    
    _roundImageView.frame = CGRectMake(_nicknameLabel.frame.origin.x, _nicknameLabel.frame.origin.y * 1.2 + _nicknameLabel.frame.size.height, WIDTH * 0.03, HEIGHT * 0.12);
    
    _tracksCountsLabel.frame = CGRectMake(_roundImageView.frame.origin.x + _roundImageView.frame.size.width * 1.5, _roundImageView.frame.origin.y, _titleLable.frame.size.width * 0.5, _roundImageView.frame.size.height);
    
}

- (void)setModel:(XQ_SmallEditorModel *)model{
    if (_model != model) {
        _model = model;
    }
    [_coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"me"]];
    _titleLable.text = model.title;
    _nicknameLabel.text = model.nickname;
    _tracksCountsLabel.text = [NSString stringWithFormat:@"%ld集",[model.tracks integerValue]];
    
}
- (void)setLabelInter:(NSInteger)labelInter{
    if (_labelInter != labelInter) {
        _labelInter = labelInter;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%ld",_labelInter];
    
}









@end
